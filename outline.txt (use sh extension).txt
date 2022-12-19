#! /bin/bash
read -p "what is your username? " username
counter=1
while [ $counter != 0 ]
do
echo "MENU"
echo "Enter 0 to view complete records"
echo "Enter 1 to look up patient profile" 
echo "Enter 2 for appointments" 
echo "Enter 3 to add new patient/staff "
echo "Enter 4 to update patient records "
echo  "Enter 5 to exit"


read -p "Enter number " reply

case $reply in

0)
psql $username <<EOF
select * from patient_tbl;
select * from med_staff_tbl;
select * from pharmacy;
select * from labratory;
select * from medications;
select * from lab_results;
select * from appointments;
EOF
;;
1)
   ./patientProfile.sh 
2)
 ./appointments.sh
 ;;

3)
./newprofile.sh
;;
4)
./update.sh
;;
5)
counter=$(( $counter -1 ))
;;
esac
done
