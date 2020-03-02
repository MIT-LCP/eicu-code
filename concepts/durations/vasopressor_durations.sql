DROP MATERIALIZED VIEW IF EXISTS vasopressordurations;
CREATE MATERIALIZED VIEW vasopressordurations AS
SELECT * FROM epinephrinedurations
UNION ALL
SELECT * FROM norepinephrinedurations
UNION ALL
SELECT * FROM phenylephrinedurations
UNION ALL
SELECT * FROM vasopressindurations
UNION ALL
SELECT * FROM dopaminedurations;
