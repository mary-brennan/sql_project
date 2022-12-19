#! /bin/bash
read -p "Enter username: " username
echo " "
read -p "Enter Patient ID " id

echo "Showing profile for patient"

psql $username <<EOF

select * from patient_tbl where patientid=$id;

EOF
x=1
while [ $x != 0 ]
do
echo " "
echo  "Press 1 to change contact information"
echo "Press  2 to change doctor"
echo "Press 3 to change address"
echo "Press 4 to add notes"
echo "Press 5 to finishing updating"
echo " "
read -p "Enter number: " reply

case $reply in

1)
read -p "new phone number " number
psql $username  <<EOF

update patient_tbl set phone=$number where patientid=$id;
EOF
;;

2) read -p "Enter new doctor id: " doctor

psql $username <<EOF
update patient_tbl set doctor_id=$doctor where patientid=$id;
EOF
;;

3)

read -p "Enter new Address: " address

psql $username <<EOF

update patient_tbl set address='$address' where patientid=$id;
EOF
;;

4)
read -p "Enter notes: " notes

psql $username <<EOF

update patient_tbl set patient_notes='$notes' where patientid=$id;
EOF
;;

5)

 x=$(( $x -1 ))
;;
esac
done
echo "Updated Profile "

psql $username <<EOF

select * from patient_tbl where patientid=$id;
EOF

