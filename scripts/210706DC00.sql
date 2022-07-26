set term ^;

create procedure temp_remove_task_rights_before_adding
as
  declare variable var_task_activity_id integer;
  declare variable var_uw_exists integer;
  declare variable var_uwsr_exists integer;
  declare variable var_uwmgr_exists integer;
  declare variable var_mgmtsr_exists integer;
  declare variable var_security_key_id integer;
begin
  for select ta.activity_id,
      (select 1 from task_activity_rights tar join ais_security asec on asec.id = tar.security_key_id where tar.security_level_key = 'EDIT' and asec.right_key = 'UW' and tar.activity_id = ta.activity_id),
      (select 1 from task_activity_rights tar join ais_security asec on asec.id = tar.security_key_id where tar.security_level_key = 'EDIT' and asec.right_key = 'UWSR' and tar.activity_id = ta.activity_id),
      (select 1 from task_activity_rights tar join ais_security asec on asec.id = tar.security_key_id where tar.security_level_key = 'EDIT' and asec.right_key = 'UWMGR' and tar.activity_id = ta.activity_id),
      (select 1 from task_activity_rights tar join ais_security asec on asec.id = tar.security_key_id where tar.security_level_key = 'EDIT' and asec.right_key = 'MGMTSR' and tar.activity_id = ta.activity_id)
      from task_activity ta
      into :var_task_activity_id,
           :var_uw_exists,
           :var_uwsr_exists,
           :var_uwmgr_exists,
           :var_mgmtsr_exists
  do      
      if (:var_uw_exists is not null) then
          begin
               select asec.id
                  from ais_security asec
                  where asec.right_key = 'PMSCINT'
                  into :var_security_key_id;

                delete from task_activity_rights 
                    where activity_id = :var_task_activity_id
                    and security_key_id = :var_security_key_id
                    and security_level_key = 'EMAIL_NEW';
          end
      else if (:var_uwsr_exists is not null) then
          begin
               select asec.id
                  from ais_security asec
                  where asec.right_key = 'UWSR'
                  into :var_security_key_id;
    
               delete from task_activity_rights 
                    where activity_id = :var_task_activity_id
                    and security_key_id = :var_security_key_id
                    and security_level_key = 'EMAIL_NEW';
          end
      else if (:var_uwmgr_exists is not null) then
          begin
               select asec.id
                  from ais_security asec
                  where asec.right_key = 'UWMGR'
                  into :var_security_key_id;
    
               delete from task_activity_rights 
                    where activity_id = :var_task_activity_id
                    and security_key_id = :var_security_key_id
                    and security_level_key = 'EMAIL_NEW';
          end
      else if (:var_mgmtsr_exists is not null) then
          begin
               select asec.id
                  from ais_security asec
                  where asec.right_key = 'MGMTSR'
                  into :var_security_key_id;
    
               delete from task_activity_rights 
                    where activity_id = :var_task_activity_id
                    and security_key_id = :var_security_key_id
                    and security_level_key = 'EMAIL_NEW';
          end
  suspend;
end^

execute procedure temp_remove_task_rights_before_adding^

commit work^

drop procedure temp_remove_task_rights_before_adding^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("210706DC00", "AIS-35980 remove task rights before adding them", "2021-Jul-06");