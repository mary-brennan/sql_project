#! /bin/bash

read -p "Enter username " un
psql $un <<EOF


INSERT into clinic VALUES
(01, '123 Main Street, Sacramento, CA 95811'),
(02, '555 Sesame Street, Roseville, CA 95771'),
(03, '911 Elm Way, Rancho Cordova, CA 95670');

INSERT into med_staff_tbl VALUES
(5123, 'Will', 'Gelato', 'Oncology', 'Physician', 02),
(5121, 'Mia', 'Vidal', 'Adult and Family Medicine', 'Nurse', 01),
(5122, 'Viola', 'Davis', 'Pediatrics', 'Nurse Practitioner', 02),
(5120, 'Jennifer', 'Coolige', 'OBGYN', 'Nurse', 03),
(5125, 'Matthew', 'Pesto', 'Pediatrics', 'Medical Assistant', 01),
(5126, 'Theo', 'James', 'Adult and Family Medicine', 'Physician', 03),
(5127, 'Jacob', 'Fritz', 'Oncology', 'Physician', 01),
(5128, 'Liz', 'Ebbing', 'OBGYN', 'Physician', 02);

insert into patient_tbl values
(1, 'Peggy', 'Saunders', '145 Mason Ave, Rockville CA 95677', 64, 'F', 914356321,null, 5123),
(2, 'Anthony', 'Saunders', '145 Mason Ave, Rockville CA 95677', 23, 'M', 914356321,null, 5123),
(3, 'Nancy', 'Brown', '145 Ontario Circle, Rockville CA 95678', 57, 'F', 9124623781,null, 5126),
(5, 'Martin', 'Bresbury', '6140 Shadow Ln, Foresthill CA 84942', 42, 'M', 9145769218,null, 5126),
(6, 'Albert', 'Bresbury', '7441 Auburn Oaks, Foresthill CA 84942', 91, 'M', 914576218, null, 5126),
(7, 'Mary', 'Avabello', '6310 Nachez Ct, Foresthill CA 84942', 25, 'F', 9142340098, null, 5128),
(8, 'Beth', 'Turner', '9584 Gatsbury St, Orin, CA 98342', 71, 'F', 345740398,null, 5128);

INSERT into appointments VALUES
(200000001, 1, 5121, '12/01/2022', 01, 'Annual Physical'),
(200000002, 3, 5120, '12/02/2022', 03, 'Annual Womens Health Appt'),
(200000003, 6, 5126, '12/04/2022', 03, 'Annual Physical'),
(200000004, 7, 5123, '12/04/2022', 02, 'Screening'),
(200000005, 8, 5120, '12/05/2022', 03, 'Illness');


INSERT into pharmacy VALUES
(301, 'Diclofenac Sodium', 'Pfizer', 'Anti-inflammatory gel', 'redness, fever, nausea', 01),
(302, 'Ibuprofen', 'Moderna', 'Anti-inflammatory', 'headache, nausea, vomiting', 02),
(303, 'Ondanestron', 'Moderna', 'Anti-nausea', 'headache, dizziness, vomiting', 02),
(304, 'Fluticasone', 'Bayer', 'Nasal Decongestant', 'headache, dizziness, vomiting', 03),
(305, 'Tizanidine', 'Abbott', 'Muscle Relaxer', 'fever, headache, nausea, dizziness', 01);


INSERT into pharmacy VALUES
(301, 'Diclofenac Sodium', 'Pfizer', 'Anti-inflammatory gel', 'redness, fever, nausea', 01),
(302, 'Ibuprofen', 'Moderna', 'Anti-inflammatory', 'headache, nausea, vomiting', 02),
(303, 'Ondanestron', 'Moderna', 'Anti-nausea', 'headache, dizziness, vomiting', 02),
(304, 'Fluticasone', 'Bayer', 'Nasal Decongestant', 'headache, dizziness, vomiting', 03),
(305, 'Tizanidine', 'Abbott', 'Muscle Relaxer', 'fever, headache, nausea, dizziness', 01);

INSERT INTO medications Values
(6001, 1, 301, 'take 2x a day with meals'),
(6002, 2, 302, 'take 400mg every 24 hours with food'),
(6003, 3, 303, 'take every 4 hours while symptoms persist'),
(6004, 5, 304, 'take at night for 7 days');

INSERT into labratory VALUES
(001, 'FLU A', 01),
(002, 'FLU B', 01),
(003, 'COVID', 02),
(004, 'ALLERGY', 02);

INSERT into lab_results VALUES
(401, 1, 'FLU A', 'Negative'),
(402, 1, 'COVID', 'Negative'),
(403, 5, 'FLU B', 'Positive'),
(404, 7, 'ALLERGY', 'Positive');

EOF
