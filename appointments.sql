#! /bin/bash
read -p "enter username " un
counter=1
while [ $counter != 0 ]
do
un='mbrennan4'
echo "enter 1 to view upcoming appointments"
echo "enter 2 to schedule an appointmnet"
echo "enter 3 to cancel an appointment"
echo "Enter 4 to go back to main menu"
read -p "Enter number " input
case $input in
 1)

read -p "enter the patient id " id
psql $un <<EOF

select * from appointments where  patient_id = $id;
EOF
;;
2)
read -p "Enter patient id " id
read -p "Enter staff id " mid
read -p  "Enter date and time in format  YYYY/MM/DD HH:MM:SS " date
read -p  "What is the reason " reason
psql $un <<EOF

insert  into appointments values(round(random()*10000000-random()),
$id, $mid, '$date',( select clinic_id from med_staff_tbl where staff_id=$mid),'$reason' );
select * from appointments where  patient_id=$id and staff_id=$mid;

EOF
echo "appointment confirmed"
;;
3)
read -p "Enter ID " id
psql $un <<EOF
select * from appointments where patient_id = $id;
EOF
read -p "Enter appointment number to cancel " number
psql $un <<EOF
delete from appointments where appt_id=$number;
EOF
echo "APPOINTMENT CANCELLED"
;;
4)
      counter=$(( $counter - 1 ))
;;
esac
done
