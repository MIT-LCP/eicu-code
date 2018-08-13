-- This query groups patients who have similar APACHE diagnoses into clinically meaningful categories
-- for example, all the sepsis diagnoses are grouped into one group, 'Sepsis'
-- The remaining groups are categorized as 'other'

DROP MATERIALIZED VIEW IF EXISTS APACHE_GROUPS;
CREATE MATERIALIZED VIEW APACHE_GROUPS AS
select
  patientunitstayid
, case
  when apacheadmissiondx in ('Angina, unstable (angina interferes w/quality of life or meds are tolerated poorly)', 'Infarction, acute myocardial (MI)', 'MI admitted > 24 hrs after onset of ischemia')
    then 'ACS'
  when apacheadmissiondx in ('Chest pain, atypical (noncardiac chest pain)', 'Chest pain, epigastric', 'Chest pain, musculoskeletal', 'Chest pain, respiratory', 'Chest pain, unknown origin')
    then 'ChestPainUnknown'
  when apacheadmissiondx in ('Cardiomyopathy', 'CHF, congestive heart failure', 'Shock, cardiogenic')
    then 'CHF'
  when apacheadmissiondx in ('Angina, stable (asymp or stable pattern of symptoms w/meds)', 'Anomaly, cardiac congenital', 'Arteriovenous malformation, surgery for', 'Atrial Septal Defect (ASD) Repair', 'Cardiovascular medical, other', 'Cardiovascular surgery, other', 'Congenital Defect Repair (Other)')
    then 'CVOther'
  when apacheadmissiondx in ('Contusion, myocardial (include r/o)', 'Efffusion, pericardial', 'Endocarditis', 'Hypertension-pulmonary, primary/idiopathic', 'Monitoring, hemodynamic (pre-operative evaluation)', 'Pericardial effusion/tamponade', 'Pericardiectomy (total/subtotal)', 'Pericarditis', 'Tamponade, pericardial', 'Thrombus, arterial', 'Vascular medical, other', 'Vascular surgery, other')
    then 'CVOther'
  when apacheadmissiondx in ('Cardiac arrest (with or without respiratory arrest; for respiratory arrest see Respiratory System)', 'Rhythm disturbance (atrial, supraventricular)', 'Rhythm disturbance (conduction defect)', 'Rhythm disturbance (ventricular)')
    then 'CardiacArrest'
  when apacheadmissiondx in ('Ablation or mapping of cardiac conduction pathway', 'Defibrillator, automatic implantable cardiac; insertion of')
    then 'CVOther'
  when apacheadmissiondx in ('CABG alone, coronary artery bypass grafting', 'CABG alone, redo', 'CABG redo with other operation', 'CABG redo with valve repair/replacement', 'CABG with aortic valve replacement', 'CABG with double valve repair/replacement', 'CABG with mitral valve repair', 'CABG with mitral valve replacement', 'CABG with other operation', 'CABG with pulmonic or tricuspid valve repair or replacement ONLY.', 'CABG with single valve repair/replacement', 'CABG, minimally invasive; mid-CABG')
    then 'CABG'
  when apacheadmissiondx in ('Aortic and Mitral valve replacement', 'Aortic valve replacement (isolated)', 'Mitral valve repair', 'Mitral valve replacement', 'Papillary muscle rupture', 'Pulmonary valve surgery', 'Tricuspid valve surgery', 'Valve, double; repair/replacement', 'Valve, redo, single', 'Valve, single; repair/replacement', 'Valve, triple; repair/replacement')
    then 'ValveDz'
  when apacheadmissiondx in ('Pneumonia, aspiration', 'Pneumonia, bacterial', 'Pneumonia, fungal', 'Pneumonia, other', 'Pneumonia, parasitic (i.e., Pneumocystic pneumonia)', 'Pneumonia, viral')
    then 'PNA'
  when apacheadmissiondx in ('Apnea, sleep', 'Apnea-sleep; surgery for (i.e., UPPP - uvulopalatopharyngoplasty)', 'ARDS-adult respiratory distress syndrome, non-cardiogenic pulmonary edema', 'Arrest, respiratory (without cardiac arrest)')
    then 'RespMedOther'
  when apacheadmissiondx in ('Atelectasis', 'Biopsy, open lung', 'Effusions, pleural', 'Embolus, pulmonary', 'Guillain-Barre syndrome', 'Hemorrhage/hemoptysis, pulmonary', 'Hemothorax', 'Obstruction-airway (i.e., acute epiglottitis, post-extubation edema, foreign body, etc)', 'Pneumothorax', 'Respiratory - medical, other', 'Restrictive lung disease (i.e., Sarcoidosis, pulmonary fibrosis)', 'Tracheostomy', 'Weaning from mechanical ventilation (transfer from other unit or hospital only)')
    then 'RespMedOther'
  when apacheadmissiondx in ('Asthma', 'Emphysema/bronchitis')
    then 'Asthma-Emphys'
  when apacheadmissiondx in ('Bleeding, GI from esophageal varices/portal hypertension', 'Bleeding, GI-location unknown', 'Bleeding, lower GI', 'Bleeding, upper GI', 'Bleeding-lower GI, surgery for', 'Bleeding-other GI, surgery for', 'Bleeding-upper GI, surgery for', 'Bleeding-variceal, surgery for (excluding vascular shunting-see surgery for portosystemic shunt)', 'GI perforation/rupture', 'GI perforation/rupture, surgery for', 'Hemorrhage, intra/retroperitoneal', 'Ulcer disease, peptic')
    then 'GIBleed'
  when apacheadmissiondx in ('GI obstruction', 'GI obstruction, surgery for (including lysis of adhesions)')
    then 'GIObstruction'
  when apacheadmissiondx in ('CVA, cerebrovascular accident/stroke', 'Hemorrhage/hematoma, intracranial', 'Hemorrhage/hematoma-intracranial, surgery for', 'Hypertension, uncontrolled (for cerebrovascular accident-see Neurological System)', 'Subarachnoid hemorrhage/arteriovenous malformation', 'Subarachnoid hemorrhage/intracranial aneurysm', 'Subarachnoid hemorrhage/intracranial aneurysm, surgery for')
    then 'CVA'
  when apacheadmissiondx in ('Abscess, neurologic', 'Biopsy, brain', 'Hydrocephalus, obstructive', 'Neoplasm, neurologic', 'Neoplasm-cranial, surgery for (excluding transphenoidal)', 'Neoplasm-spinal cord, surgery or other related procedures', 'Neurologic medical, other', 'Neuromuscular medical, other', 'Palsy, cranial nerve', 'Seizures (primary-no structural brain disease)', 'Seizures-intractable, surgery for')
    then 'Neuro'
  when apacheadmissiondx in ('Coma/change in level of consciousness (for hepatic see GI, for diabetic see Endocrine, if related to cardiac arrest, see CV)', 'Nontraumatic coma due to anoxia/ischemia')
    then 'Coma'
  when apacheadmissiondx in ('Overdose, alcohols (bethanol, methanol, ethylene glycol)', 'Overdose, analgesic (aspirin, acetaminophen)', 'Overdose, antidepressants (cyclic, lithium)', 'Overdose, other toxin, poison or drug', 'Overdose, sedatives, hypnotics, antipsychotics, benzodiazepines', 'Overdose, self-inflicted', 'Overdose, street drugs (opiates, cocaine, amphetamine)', 'Toxicity, drug (i.e., beta blockers, calcium channel blockers, etc.)')
    then 'Overdose'
  when apacheadmissiondx in ('Sepsis, cutaneous/soft tissue', 'Sepsis, GI', 'Sepsis, gynecologic', 'Sepsis, other', 'Sepsis, pulmonary', 'Sepsis, renal/UTI (including bladder)', 'Sepsis, unknown')
    then 'Sepsis'
  when apacheadmissiondx in ('Renal failure, acute', 'Renal obstruction')
    then 'ARF'
  when apacheadmissiondx in ('Diabetic hyperglycemic hyperosmolar nonketotic coma (HHNC)', 'Diabetic ketoacidosis')
    then 'DKA'
  when apacheadmissiondx in ('Abdomen only trauma', 'Abdomen/extremity trauma', 'Abdomen/face trauma', 'Abdomen/multiple trauma', 'Abdomen/pelvis trauma', 'Abdomen/spinal trauma', 'Chest thorax only trauma', 'Chest/abdomen trauma', 'Chest/extremity trauma', 'Chest/face trauma', 'Chest/multiple trauma', 'Chest/pelvis trauma', 'Chest/spinal trauma', 'Chest/thorax only trauma', 'Extremity only trauma')
    then 'Trauma'
  when apacheadmissiondx in ('Extremity only trauma, surgery for', 'Extremity/face trauma', 'Extremity/face trauma, surgery for', 'Extremity/multiple trauma', 'Extremity/multiple trauma, surgery for', 'Face only trauma', 'Face only trauma, surgery for', 'Face/multiple trauma', 'Face/multiple trauma, surgery for', 'Facial surgery (if related to trauma, see Trauma)', 'Head only trauma', 'Head/abdomen trauma', 'Head/chest trauma')
    then 'Trauma'
  when apacheadmissiondx in ('Head/extremity trauma', 'Head/face trauma', 'Head/multiple trauma', 'Head/pelvis trauma', 'Head/spinal trauma', 'Pelvis/extremity trauma', 'Pelvis/face trauma', 'Pelvis/hip trauma', 'Pelvis/multiple trauma', 'Pelvis/spinal trauma', 'Spinal cord only trauma', 'Spinal/extremity trauma', 'Spinal/face trauma', 'Spinal/multiple trauma', 'Trauma medical, other', 'Trauma surgery, other')
    then 'Trauma'
else 'Other' end as apachedxgroup
, apacheadmissiondx
from patient;
