#! /bin/bash
read -p "Enter Patient ID " userinput
read -p "Enter username: " un

psql $un <<EOF

create view PATIENT_PROFILE as select concat(f_name,' ', l_name)as Name, concat(fname,' ',lname) as Doctor,
patientid, age, sex, address, phone, patient_notes
from
patient_tbl, med_staff_tbl
where patientid=$userinput and staff_id=doctor_id;

create view PRESCRIPTIONS as select precription_id, drug_name, drug_brand, drug_use, instructions, side_effects
from
pharmacy, medications, patient_tbl
where
patient_tbl.patientid=patient_id and medications.drugid=pharmacy.drugid and patientid=$userinput;

create view LABS as select lab_number, lab_results.lab_type, results
from lab_results, labratory, patient_tbl
WHERE
patient_tbl.patientid=$userinput and lab_results.lab_type =labratory.description
and lab_results.patientid=patient_tbl.patientid;

create view UPCOMING_APPOINTMENTS as select * from appointments where patient_id=$userinput;

select * from PATIENT_PROFILE as "PROFILE";
select * from PRESCRIPTIONS;
select * from LABS;
select * from UPCOMING_APPOINTMENTS;
drop view patient_profile;
drop view prescriptions;
drop view labs;
drop view upcoming_appointments;
EOF
