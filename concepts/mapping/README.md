# Mapping tables

## lab-dictionary.csv

eICU-CRD has no dictionary of its lab tests: the `lab` table records the picklist name
(`lab.labName`) itself, often an abbreviation such as `Hgb`, `-polys` or `WBC x 1000`. This
table gives each of the 148 lab names of eICU-CRD v2.0 a description and, where a link can be
traced, a LOINC code.

| Column | Content |
| ------ | ------- |
| `labname` | `lab.labName`, exactly as recorded |
| `description` | what the lab name measures |
| `loinc_code` | LOINC code, for 50 lab names; empty where no link could be traced |
| `source` | where the description (and LOINC code) come from, see below |
| `source_detail` | the same, in words |

Sources, in `source`:

- `weavehr:<concept>`: the concept the lab name is mapped to in the eICU mapping of
  [WeavEHR](https://github.com/aidh-ms/WeavEHR) (MIT, commit 210a539).
- `mimic-labitem:<itemid> <label>` and `mimic-loinc:<itemid> <label> -> LOINC <code>`: the
  MIMIC-IV lab item mapped to the same WeavEHR concept, and its LOINC code in
  [mimic-code](https://github.com/MIT-LCP/mimic-code)'s `d_labitems_to_loinc.csv` (MIT, v2.4.0).
- `eicu-code`: the canonical column of the lab in `concepts/pivoted/pivoted-lab.sql` or
  `pivoted-bg.sql`.
- `expansion`: a plain reading of the picklist name, for the 94 lab names no source above covers.
  These are the least certain; corrections are welcome.

**The LOINC codes are an inference** across two curated mappings (eICU lab name -> WeavEHR concept
<- MIMIC-IV lab item with its LOINC code), not a mapping made from eICU's own lab definitions. A
code therefore inherits the MIMIC-IV item's specimen and method, e.g. serum/plasma versus whole
blood, which may not match what a given eICU hospital measured. Each code was checked to exist and
not be deprecated in LOINC 2.83.

The table was built for [eICU-MEDS](https://github.com/Medical-Event-Data-Standard/eICU_MEDS),
which uses it to describe lab codes.

This material contains content from LOINC (http://loinc.org). LOINC is copyright © Regenstrief
Institute, Inc. and the Logical Observation Identifiers Names and Codes (LOINC) Committee and is
available at no cost under the license at http://loinc.org/license. LOINC® is a registered United
States trademark of Regenstrief Institute, Inc.
