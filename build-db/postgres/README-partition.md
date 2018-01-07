# Partitioning eICU

This README overviews the process that was used to create the partitions on `vitalperiodic`. The rough goal of partitioning a table is to improve query speed by splitting one big table into several "mini" tables.

## 1. Make a count table

```sql
create table count_vitalperiodic as (select patientunitstayid, count(*) as numobs from vitalperiodic group by patientunitstayid order by patientunitstayid);
```

We would like ~10 million rows per partition. Since `vitalperiodic` has 146,671,642 rows total, we'll probably end up with ~15 partitions.

## 2. Determine how many partitions we will need

```sql
with t1 as
(
  select
    patientunitstayid
    , numobs
    , (SUM(numobs) OVER (order by patientunitstayid)) as numobs_cumulative
  from count_vitalperiodic
)
, t2 as
(
  select
  patientunitstayid
  , numobs_cumulative
  , floor( (numobs_cumulative)/10000000) as rn
  , lead( floor((numobs_cumulative)/10000000) ) OVER (order by patientunitstayid) as rn_lead
  from t1
)
select
  patientunitstayid
  , numobs_cumulative
  , rn
  , rn_lead
from t2
where rn != rn_lead
order by patientunitstayid;
```

The above query returns the `patientunitstayid` we can use for our partitions.

patientunitstayid | numobs_cumulative | rn | rn_lead
------------------- | ------------------- | ---- | ---------
           264445 |           9999827 |  0 |       1
           514528 |          19998675 |  1 |       2
           823517 |          29999797 |  2 |       3
          1037072 |          39999970 |  3 |       4
          1129722 |          49999716 |  4 |       5
          1453997 |          59999555 |  5 |       6
          1609951 |          69998417 |  6 |       7
          1775421 |          79999795 |  7 |       8
          2137713 |          89999590 |  8 |       9
          2499831 |          99999579 |  9 |      10
          2763893 |         109997409 | 10 |      11
          2937948 |         119999608 | 11 |      12
          3100629 |         129998232 | 12 |      13
          3213286 |         139999892 | 13 |      14

Now we adapt this into SQL code compliant with PostgreSQL 9.4+. Rather than write the code ourself, we can write an SQL script based upon the above query which outputs the SQL code.

## 3. Get code for partitions

### Postgres 9.4

```sql
with t1 as
(
  select
    patientunitstayid
    , numobs
    , (SUM(numobs) OVER (order by patientunitstayid)) as numobs_cumulative
  from count_vitalperiodic
)
, t2 as
(
  select
  patientunitstayid
  , numobs_cumulative
  , floor( (numobs_cumulative)/10000000) as rn
  , lead( floor((numobs_cumulative)/10000000) ) OVER (order by patientunitstayid) as rn_lead
  from t1
)
, t3 as
(
  select
     lag(patientunitstayid) over (order by patientunitstayid) as pid_lower
    , patientunitstayid as pid_upper
    , numobs_cumulative
    , rn
    , rn_lead
  from t2
  where rn != rn_lead
)
-- next two staging tables add in an upper limit of (pid_lower = highest pid, pid_upper = 9999999999)
, last_row1 as
(
  select
    pid_upper as pid_lower
    , 999999999 as pid_upper
    -- note we add 1 to rn_lead to that this is the highest partition value
    , rn_lead+1 as rn_lead
    , ROW_NUMBER() over (order by rn_lead desc) as rn_last_row
  from t3
)
, last_row2 as
(
  select
    last_row1.*
  from last_row1
  where rn_last_row = 1
)
, t4 as
(
  select coalesce(t3.pid_lower, 0) as pid_lower, t3.pid_upper, t3.rn_lead from t3
  UNION
  select lr.pid_lower, lr.pid_upper, lr.rn_lead from last_row2 lr
)
select
  'CREATE TABLE vitalperiodic_' || cast(rn_lead as text) || ' ( CHECK ( patientunitstayid >= ' || cast(pid_lower as text) || ' AND patientunitstayid < ' || cast(pid_upper as text) || ' )) INHERITS vitalperiodic;' as txt
from t4
order by rn_lead;
```

Returns:

```
txt                                                                
----------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE vitalperiodic_1 ( CHECK ( patientunitstayid >= 0 AND patientunitstayid < 264445)) INHERITS vitalperiodic;
CREATE TABLE vitalperiodic_2 ( CHECK ( patientunitstayid >= 264445 AND patientunitstayid < 514528)) INHERITS vitalperiodic;
CREATE TABLE vitalperiodic_3 ( CHECK ( patientunitstayid >= 514528 AND patientunitstayid < 823517)) INHERITS vitalperiodic;
CREATE TABLE vitalperiodic_4 ( CHECK ( patientunitstayid >= 823517 AND patientunitstayid < 1037072)) INHERITS vitalperiodic;
CREATE TABLE vitalperiodic_5 ( CHECK ( patientunitstayid >= 1037072 AND patientunitstayid < 1129722)) INHERITS vitalperiodic;
CREATE TABLE vitalperiodic_6 ( CHECK ( patientunitstayid >= 1129722 AND patientunitstayid < 1453997)) INHERITS vitalperiodic;
CREATE TABLE vitalperiodic_7 ( CHECK ( patientunitstayid >= 1453997 AND patientunitstayid < 1609951)) INHERITS vitalperiodic;
CREATE TABLE vitalperiodic_8 ( CHECK ( patientunitstayid >= 1609951 AND patientunitstayid < 1775421)) INHERITS vitalperiodic;
CREATE TABLE vitalperiodic_9 ( CHECK ( patientunitstayid >= 1775421 AND patientunitstayid < 2137713)) INHERITS vitalperiodic;
CREATE TABLE vitalperiodic_10 ( CHECK ( patientunitstayid >= 2137713 AND patientunitstayid < 2499831)) INHERITS vitalperiodic;
CREATE TABLE vitalperiodic_11 ( CHECK ( patientunitstayid >= 2499831 AND patientunitstayid < 2763893)) INHERITS vitalperiodic;
CREATE TABLE vitalperiodic_12 ( CHECK ( patientunitstayid >= 2763893 AND patientunitstayid < 2937948)) INHERITS vitalperiodic;
CREATE TABLE vitalperiodic_13 ( CHECK ( patientunitstayid >= 2937948 AND patientunitstayid < 3100629)) INHERITS vitalperiodic;
CREATE TABLE vitalperiodic_14 ( CHECK ( patientunitstayid >= 3100629 AND patientunitstayid < 3213286)) INHERITS vitalperiodic;
CREATE TABLE vitalperiodic_15 ( CHECK ( patientunitstayid >= 3213286 AND patientunitstayid < 999999999)) INHERITS vitalperiodic;
(15 rows)
```

### Postgres 10.0+

```sql
with t1 as
(
  select
    patientunitstayid
    , numobs
    , (SUM(numobs) OVER (order by patientunitstayid)) as numobs_cumulative
  from count_vitalperiodic
)
, t2 as
(
  select
  patientunitstayid
  , numobs_cumulative
  , floor( (numobs_cumulative)/10000000) as rn
  , lead( floor((numobs_cumulative)/10000000) ) OVER (order by patientunitstayid) as rn_lead
  from t1
)
, t3 as
(
  select
     lag(patientunitstayid) over (order by patientunitstayid) as pid_lower
    , patientunitstayid as pid_upper
    , numobs_cumulative
    , rn
    , rn_lead
  from t2
  where rn != rn_lead
)
-- next two staging tables add in an upper limit of (pid_lower = highest pid, pid_upper = 9999999999)
, last_row1 as
(
  select
    pid_upper as pid_lower
    , 999999999 as pid_upper
    -- note we add 1 to rn_lead to that this is the highest partition value
    , rn_lead+1 as rn_lead
    , ROW_NUMBER() over (order by rn_lead desc) as rn_last_row
  from t3
)
, last_row2 as
(
  select
    last_row1.*
  from last_row1
  where rn_last_row = 1
)
, t4 as
(
  select coalesce(t3.pid_lower, 0) as pid_lower, t3.pid_upper, t3.rn_lead from t3
  UNION
  select lr.pid_lower, lr.pid_upper, lr.rn_lead from last_row2 lr
)
select
  'CREATE TABLE vitalperiodic_' || cast(rn_lead as text) || ' PARTITION OF vitalperiodic FOR VALUES FROM (' || cast(pid_lower as text) || ') TO (' || cast(pid_upper as text) || ');' as txt
from t4
order by rn_lead;
```

Returns:

```
txt                                                 
----------------------------------------------------------------------------------------------------
CREATE TABLE vitalperiodic_10 PARTITION OF vitalperiodic FOR VALUES FROM (2137713) TO (2499831);
CREATE TABLE vitalperiodic_11 PARTITION OF vitalperiodic FOR VALUES FROM (2499831) TO (2763893);
CREATE TABLE vitalperiodic_12 PARTITION OF vitalperiodic FOR VALUES FROM (2763893) TO (2937948);
CREATE TABLE vitalperiodic_13 PARTITION OF vitalperiodic FOR VALUES FROM (2937948) TO (3100629);
CREATE TABLE vitalperiodic_14 PARTITION OF vitalperiodic FOR VALUES FROM (3100629) TO (3213286);
CREATE TABLE vitalperiodic_15 PARTITION OF vitalperiodic FOR VALUES FROM (3213286) TO (999999999);
CREATE TABLE vitalperiodic_1 PARTITION OF vitalperiodic FOR VALUES FROM (0) TO (264445);
CREATE TABLE vitalperiodic_2 PARTITION OF vitalperiodic FOR VALUES FROM (264445) TO (514528);
CREATE TABLE vitalperiodic_3 PARTITION OF vitalperiodic FOR VALUES FROM (514528) TO (823517);
CREATE TABLE vitalperiodic_4 PARTITION OF vitalperiodic FOR VALUES FROM (823517) TO (1037072);
CREATE TABLE vitalperiodic_5 PARTITION OF vitalperiodic FOR VALUES FROM (1037072) TO (1129722);
CREATE TABLE vitalperiodic_6 PARTITION OF vitalperiodic FOR VALUES FROM (1129722) TO (1453997);
CREATE TABLE vitalperiodic_7 PARTITION OF vitalperiodic FOR VALUES FROM (1453997) TO (1609951);
CREATE TABLE vitalperiodic_8 PARTITION OF vitalperiodic FOR VALUES FROM (1609951) TO (1775421);
CREATE TABLE vitalperiodic_9 PARTITION OF vitalperiodic FOR VALUES FROM (1775421) TO (2137713);
(15 rows)
```
