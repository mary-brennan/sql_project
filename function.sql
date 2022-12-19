CREATE FUNCTION delete_old_appts() returns trigger
as $$
begin
delete from appointments where appt_date_time <
current_timestamp - interval '1 minute';
return null;
end;
$$ Language plpgsql;

CREATE TRIGGER trig_del_past_appts
after insert on appointments
execute function delete_old_appts();
