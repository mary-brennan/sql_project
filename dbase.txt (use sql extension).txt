#! /bin/bash
read -p "what is your username? " username
psql $username <<EOF

DROP TABLE IF EXISTS patient_tbl
cascade;
DROP TABLE IF EXISTS med_staff_tbl
cascade;
DROP TABLE IF EXISTS appointments
cascade;
DROP TABLE IF EXISTS clinic
cascade;
DROP TABLE IF EXISTS medications
cascade;
DROP TABLE IF EXISTS pharmacy
cascade;
DROP TABLE IF EXISTS labratory
cascade;
DROP TABLE IF EXISTS lab_results
cascade;

CREATE TABLE patient_tbl
(
    patientID numeric primary key,
    f_name varchar(20) not null,
    l_name varchar(20) not null,
    address text,
    age integer,
    sex char(1),
    phone numeric not null,
    patient_notes text,
    Doctor_ID numeric
   );

CREATE TABLE med_staff_tbl
(
    staff_id numeric primary key,
    fname varchar(15) not null,
    lname varchar(15) not null,
    department text not null,
    job_title text not null,
    Clinic_id numeric not null
);
CREATE TABLE appointments
(
    appt_id numeric primary key,
    patient_id numeric references
    patient_tbl (patientID),
    staff_id numeric not null,
    appt_date_time timestamp not null,
    appt_location numeric not null,
    appt_description varchar(100)
);

CREATE TABLE Clinic
(
    id numeric primary key,
    address text not null
);


CREATE table medications
(
        precription_id numeric primary key, patient_id numeric
        references patient_tbl(patientid),
         drugid numeric not null, instructions text not null
);

CREATE TABLE pharmacy
(
    drugid numeric primary key,
    drug_name text not null,
    drug_brand text not null,
    drug_use text not null,
    side_effects text not null,
    clinic_id numeric not null
);

CREATE TABLE Lab_results
(
    lab_number numeric primary key,
    patientid numeric
        references patient_tbl (patientid),
    lab_type text not null,
    results text not null
);

CREATE TABLE labratory
(
    lab_id numeric primary key,
    description text unique not null,
    clinic_id numeric references clinic (id)
);

ALTER table patient_tbl add foreign key (doctor_id)
references
med_staff_tbl (staff_id);

ALTER table appointments add foreign key (staff_id)
references
 med_staff_tbl(staff_id);

ALTER table appointments add foreign key (patient_id)
 references patient_tbl (patientID);


Alter table med_staff_tbl add foreign key (clinic_id)
references clinic(id);

Alter table appointments add foreign key (appt_location)
references clinic(id);

ALTER TABLE medications add foreign key (drugid)
references pharmacy (drugid);
ALTER TABLE pharmacy add foreign key (clinic_id)
references clinic (id);


ALTER TABLE lab_results add foreign key  (lab_type)
references labratory  (description);

BEGIN;
INSERT into clinic VALUES
(01, '123 Main Street, Sacramento, CA 95811'),
(02, '555 Sesame Street, Roseville, CA 95771'),
(03, '911 Elm Way, Rancho Cordova, CA 95670');

savepoint s1;

INSERT into med_staff_tbl VALUES
(5123, 'Will', 'Gelato', 'Oncology', 'Physician', 02),
(5121, 'Mia', 'Vidal', 'Adult and Family Medicine', 'Nurse', 01),
(5122, 'Viola', 'Davis', 'Pediatrics', 'Nurse Practitioner', 02),
(5120, 'Jennifer', 'Coolige', 'OBGYN', 'Nurse', 03),
(5125, 'Matthew', 'Pesto', 'Pediatrics', 'Medical Assistant', 01),
(5126, 'Theo', 'James', 'Adult and Family Medicine', 'Physician', 03),
(5127, 'Jacob', 'Fritz', 'Oncology', 'Physician', 01),
(5128, 'Liz', 'Ebbing', 'OBGYN', 'Physician', 02);

savepoint s2;

insert into patient_tbl values
(1, 'Peggy', 'Saunders', '145 Mason Ave, Rockville CA 95677', 64, 'F', 914356321,null, 5123),
(2, 'Anthony', 'Saunders', '145 Mason Ave, Rockville CA 95677', 23, 'M', 914356321,null, 5123),
(3, 'Nancy', 'Brown', '145 Ontario Circle, Rockville CA 95678', 57, 'F', 9124623781,null, 5126),
(5, 'Martin', 'Bresbury', '6140 Shadow Ln, Foresthill CA 84942', 42, 'M', 9145769218,null, 5126),
(6, 'Albert', 'Bresbury', '7441 Auburn Oaks, Foresthill CA 84942', 91, 'M', 914576218, null, 5126),
(7, 'Mary', 'Avabello', '6310 Nachez Ct, Foresthill CA 84942', 25, 'F', 9142340098, null, 5128),
(8, 'Beth', 'Turner', '9584 Gatsbury St, Orin, CA 98342', 71, 'F', 345740398,null, 5128);



savepoint s3;

INSERT into appointments VALUES
(200000001, 1, 5121, '2022/12/12 10:30:00', 01, 'Annual Physical'),
(200000002, 3, 5120, '2022/12/30 14:20:00', 03, 'Annual Womens Health Appt'),
(200000003, 6, 5126, '2022/12/18 07:00:00', 03, 'Annual Physical'),
(200000004, 7, 5123, '2022/12/22 09:15:00', 02, 'Screening'),
(200000005, 8, 5120, '2022/12/15 12:45:00', 03, 'Illness');

savepoint s4;
INSERT into pharmacy VALUES
(301, 'Diclofenac Sodium', 'Pfizer', 'Anti-inflammatory gel', 'redness, fever, nausea', 01),
(302, 'Ibuprofen', 'Moderna', 'Anti-inflammatory', 'headache, nausea, vomiting', 02),
(303, 'Ondanestron', 'Moderna', 'Anti-nausea', 'headache, dizziness, vomiting', 02),
(304, 'Fluticasone', 'Bayer', 'Nasal Decongestant', 'headache, dizziness, vomiting', 03),
(305, 'Tizanidine', 'Abbott', 'Muscle Relaxer', 'fever, headache, nausea, dizziness', 01);

savepoint s5;

INSERT INTO medications Values
(6001, 1, 301, 'take 2x a day with meals'),
(6002, 2, 302, 'take 400mg every 24 hours with food'),
(6003, 3, 303, 'take every 4 hours while symptoms persist'),
(6004, 5, 304, 'take at night for 7 days');

savepoint s6;

INSERT into labratory VALUES
(001, 'FLU A', 01),
(002, 'FLU B', 01),
(003, 'COVID', 02),
(004, 'ALLERGY', 02);

savepoint s7;
INSERT into lab_results VALUES
(401, 1, 'FLU A', 'Negative'),
(402, 1, 'COVID', 'Negative'),
(403, 5, 'FLU B', 'Positive'),
(404, 7, 'ALLERGY', 'Positive');
DROP Function if exists delete_old_appts();
\i function.sql
commit;
EOF

