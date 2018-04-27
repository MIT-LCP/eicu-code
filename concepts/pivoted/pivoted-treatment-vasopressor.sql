DROP TABLE IF EXISTS pivoted_treatment_vasopressor CASCADE;
CREATE TABLE pivoted_treatment_vasopressor AS
with tr as
(
  select
    patientunitstayid
   , treatmentoffset as chartoffset
   , max(case when treatmentstring in
   (
     'toxicology|drug overdose|vasopressors|vasopressin' --                                                                   |    23
   , 'toxicology|drug overdose|vasopressors|phenylephrine (Neosynephrine)' --                                                 |    21
   , 'toxicology|drug overdose|vasopressors|norepinephrine > 0.1 micrograms/kg/min' --                                        |    62
   , 'toxicology|drug overdose|vasopressors|norepinephrine <= 0.1 micrograms/kg/min' --                                       |    29
   , 'toxicology|drug overdose|vasopressors|epinephrine > 0.1 micrograms/kg/min' --                                           |     6
   , 'toxicology|drug overdose|vasopressors|epinephrine <= 0.1 micrograms/kg/min' --                                          |     2
   , 'toxicology|drug overdose|vasopressors|dopamine 5-15 micrograms/kg/min' --                                               |     7
   , 'toxicology|drug overdose|vasopressors|dopamine >15 micrograms/kg/min' --                                                |     3
   , 'toxicology|drug overdose|vasopressors' --                                                                               |    30
   , 'surgery|cardiac therapies|vasopressors|vasopressin' --                                                                  |   356
   , 'surgery|cardiac therapies|vasopressors|phenylephrine (Neosynephrine)' --                                                |  1000
   , 'surgery|cardiac therapies|vasopressors|norepinephrine > 0.1 micrograms/kg/min' --                                       |   390
   , 'surgery|cardiac therapies|vasopressors|norepinephrine <= 0.1 micrograms/kg/min' --                                      |   347
   , 'surgery|cardiac therapies|vasopressors|epinephrine > 0.1 micrograms/kg/min' --                                          |   117
   , 'surgery|cardiac therapies|vasopressors|epinephrine <= 0.1 micrograms/kg/min' --                                         |   178
   , 'surgery|cardiac therapies|vasopressors|dopamine  5-15 micrograms/kg/min' --                                             |   274
   , 'surgery|cardiac therapies|vasopressors|dopamine >15 micrograms/kg/min' --                                               |    23
   , 'surgery|cardiac therapies|vasopressors' --                                                                              |   596
   , 'renal|electrolyte correction|treatment of hypernatremia|vasopressin' --                                                 |     7
   , 'neurologic|therapy for controlling cerebral perfusion pressure|vasopressors|phenylephrine (Neosynephrine)' --           |   321
   , 'neurologic|therapy for controlling cerebral perfusion pressure|vasopressors|norepinephrine > 0.1 micrograms/kg/min' --  |   348
   , 'neurologic|therapy for controlling cerebral perfusion pressure|vasopressors|norepinephrine <= 0.1 micrograms/kg/min' -- |   374
   , 'neurologic|therapy for controlling cerebral perfusion pressure|vasopressors|epinephrine > 0.1 micrograms/kg/min' --     |    21
   , 'neurologic|therapy for controlling cerebral perfusion pressure|vasopressors|epinephrine <= 0.1 micrograms/kg/min' --    |   199
   , 'neurologic|therapy for controlling cerebral perfusion pressure|vasopressors|dopamine 5-15 micrograms/kg/min' --         |   277
   , 'neurologic|therapy for controlling cerebral perfusion pressure|vasopressors|dopamine > 15 micrograms/kg/min' --         |    20
   , 'neurologic|therapy for controlling cerebral perfusion pressure|vasopressors' --                                         |   172
   , 'gastrointestinal|medications|hormonal therapy (for varices)|vasopressin' --                                             |   964
   , 'cardiovascular|shock|vasopressors|vasopressin' --                                                                       | 11082
   , 'cardiovascular|shock|vasopressors|phenylephrine (Neosynephrine)' --                                                     | 13189
   , 'cardiovascular|shock|vasopressors|norepinephrine > 0.1 micrograms/kg/min' --                                            | 24174
   , 'cardiovascular|shock|vasopressors|norepinephrine <= 0.1 micrograms/kg/min' --                                           | 17467
   , 'cardiovascular|shock|vasopressors|epinephrine > 0.1 micrograms/kg/min' --                                               |  2410
   , 'cardiovascular|shock|vasopressors|epinephrine <= 0.1 micrograms/kg/min' --                                              |  2384
   , 'cardiovascular|shock|vasopressors|dopamine  5-15 micrograms/kg/min' --                                                  |  4822
   , 'cardiovascular|shock|vasopressors|dopamine >15 micrograms/kg/min' --                                                    |  1102
   , 'cardiovascular|shock|vasopressors' --                                                                                   |  9335
   , 'toxicology|drug overdose|agent specific therapy|beta blockers overdose|dopamine' --                             |    66
   , 'cardiovascular|ventricular dysfunction|inotropic agent|norepinephrine > 0.1 micrograms/kg/min' --                       |   537
   , 'cardiovascular|ventricular dysfunction|inotropic agent|norepinephrine <= 0.1 micrograms/kg/min' --                      |   411
   , 'cardiovascular|ventricular dysfunction|inotropic agent|epinephrine > 0.1 micrograms/kg/min' --                          |   274
   , 'cardiovascular|ventricular dysfunction|inotropic agent|epinephrine <= 0.1 micrograms/kg/min' --                         |   456
   , 'cardiovascular|shock|inotropic agent|norepinephrine > 0.1 micrograms/kg/min' --                                         |  1940
   , 'cardiovascular|shock|inotropic agent|norepinephrine <= 0.1 micrograms/kg/min' --                                        |  1262
   , 'cardiovascular|shock|inotropic agent|epinephrine > 0.1 micrograms/kg/min' --                                            |   477
   , 'cardiovascular|shock|inotropic agent|epinephrine <= 0.1 micrograms/kg/min' --                                           |   505
   , 'cardiovascular|shock|inotropic agent|dopamine <= 5 micrograms/kg/min' --                                        |  1103
   , 'cardiovascular|shock|inotropic agent|dopamine  5-15 micrograms/kg/min' --                                       |  1156
   , 'cardiovascular|shock|inotropic agent|dopamine >15 micrograms/kg/min' --                                         |   144
   , 'surgery|cardiac therapies|inotropic agent|dopamine <= 5 micrograms/kg/min' --                                   |   171
   , 'surgery|cardiac therapies|inotropic agent|dopamine  5-15 micrograms/kg/min' --                                  |    93
   , 'surgery|cardiac therapies|inotropic agent|dopamine >15 micrograms/kg/min' --                                    |     3
   , 'cardiovascular|myocardial ischemia / infarction|inotropic agent|norepinephrine > 0.1 micrograms/kg/min' --              |   688
   , 'cardiovascular|myocardial ischemia / infarction|inotropic agent|norepinephrine <= 0.1 micrograms/kg/min' --             |   670
   , 'cardiovascular|myocardial ischemia / infarction|inotropic agent|epinephrine > 0.1 micrograms/kg/min' --                 |   381
   , 'cardiovascular|myocardial ischemia / infarction|inotropic agent|epinephrine <= 0.1 micrograms/kg/min' --                |   357
   , 'cardiovascular|ventricular dysfunction|inotropic agent|dopamine <= 5 micrograms/kg/min' --                      |   886
   , 'cardiovascular|ventricular dysfunction|inotropic agent|dopamine  5-15 micrograms/kg/min' --                     |   649
   , 'cardiovascular|ventricular dysfunction|inotropic agent|dopamine >15 micrograms/kg/min' --                       |    86
   , 'cardiovascular|myocardial ischemia / infarction|inotropic agent|dopamine <= 5 micrograms/kg/min' --             |   346
   , 'cardiovascular|myocardial ischemia / infarction|inotropic agent|dopamine  5-15 micrograms/kg/min' --            |   520
   , 'cardiovascular|myocardial ischemia / infarction|inotropic agent|dopamine >15 micrograms/kg/min' --              |    54
  ) then 1 else 0 end)::SMALLINT as vasopressor
  from treatment
  group by patientunitstayid, treatmentoffset
)
select
  patientunitstayid, chartoffset, vasopressor
from tr
where vasopressor = 1
order by patientunitstayid, chartoffset;
