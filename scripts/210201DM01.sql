SET TERM ^;

create procedure temp_update_textmtc_task_rights
as
    declare variable var_activity_id          integer;
    declare variable var_agent_right_id       integer;
    declare variable var_underwriter_right_id integer;
begin
    select ta.activity_id
      from task_activity ta
     where activity_name = 'TEXTMTC'
      into :var_activity_id;

    delete from task_activity_rights
     where activity_id = :var_activity_id;

    select id
      from ais_security
     where right_key = 'AG'
      into :var_agent_right_id;

    select id
      from ais_security
     where right_key = 'UW'
      into :var_underwriter_right_id;

    insert into task_activity_rights (activity_id, security_key_id, security_level_key)
        values (:var_activity_id, :var_agent_right_id, 'VIEW');

    insert into task_activity_rights (activity_id, security_key_id, security_level_key)
        values (:var_activity_id, :var_underwriter_right_id, 'EDIT');
end^

commit^

execute procedure temp_update_textmtc_task_rights^

commit^

drop procedure temp_update_textmtc_task_rights^

commit^

INSERT INTO applied_scripts(NAME, DESCRIPTION, SCRIPT_DATE)
    VALUES ("210201DM01", "BCSB-1624 Update TEXTMTC task rights", "2021-FEB-01")^

SET TERM ;^
