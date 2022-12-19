#! /bin/bash
read -p "Enter username" un
echo "press 1 for patient"
echo "press 2 for staff"

read -p "Enter: " reply

case $reply in
1)
read -p "Enter new patient first name " pfname
read -p "Enter new patient last name " plname
read -p "Enter new patient address " padd
read -p "Enter new patient age " page
read -p "Enter new patient sex (M|F) " psex
read -p "Enter new patient phone number (xxxxxxxxxx) " ppn
read -p "Enter new patient notes " pnotes
read -p "Enter new patient doctor " pdr
psql $un <<EOF

insert into patient_tbl values(round(random()*1000000-random()),
'$pfname', '$plname', '$padd',$page, '$psex', $ppn, '$pnotes', $pdr);

EOF
echo "Patient added"

;;

2)
read -p "Enter new staff first name " sfname
read -p "Enter new staff last name " slname
read -p "Enter new staff department " sdept
read -p "Enter new staff job title " sjt
read -p "Enter new staff clinic_id " scid
psql $un <<EOF

insert into med_staff_tbl values(round(random()*1000000-random()),
 '$sfname', '$slname', '$sdept', '$sjt', $scid);

EOF
echo "Staff member added"
;;
esac


