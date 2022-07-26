set term ^;

create procedure tmp_assign_view_right (
    in_activity_name varchar(50),
    in_security_name varchar(10))
as
    declare variable var_activity_id integer;
    declare variable var_security_id integer;
begin
    select activity_id
      from task_activity
     where activity_name = :in_activity_name
      into :var_activity_id;

    select id
      from ais_security
     where right_key = :in_security_name
      into :var_security_id;

    insert into task_activity_rights (activity_id, security_key_id, security_level_key)
         values (:var_activity_id, :var_security_id, 'VIEW');
end^

commit^

execute procedure tmp_assign_view_right('GLASS_25K', 'AG')^
execute procedure tmp_assign_view_right('GLASS_175K', 'AG')^
execute procedure tmp_assign_view_right('GLASS_175K', 'UW')^

commit^

drop procedure tmp_assign_view_right^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("200930ML01", "RT-224 - all identities can view workflow tasks", "09/30/2020");