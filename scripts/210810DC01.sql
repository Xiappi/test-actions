set term ^;

create procedure temp_remove_rights
as
    declare variable var_activity_rights_id      integer;
begin
    select tar.activity_rights_id
        from task_activity_rights tar
        join task_activity ta on ta.activity_id = tar.activity_id
        join ais_security asec on asec.id = tar.security_key_id
    where ta.activity_name = 'PEDAL_CYCLE_UWMGR'
        and asec.right_key = 'UWSR'
        and tar.security_level_key = 'EDIT'
    into :var_activity_rights_id;

    if (:var_activity_rights_id is not null) then
    begin
         delete from task_activity_rights tar where tar.activity_rights_id = :var_activity_rights_id; 
    end
end^

commit^

execute procedure temp_remove_rights^

commit^

drop procedure temp_remove_rights^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("210810DC01", "MHM-662 remove uwsr from edit pedal cycle", "2021-Aug-10");