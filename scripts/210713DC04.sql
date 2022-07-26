set term ^;

create procedure temp_remove_role_from_user (
	in_role_name     varchar(100) character set none)
as
    declare variable var_role_id      integer;
begin
    select urrm.role_id
    from user_roles_rights_mst urrm
    where urrm.role_name = :in_role_name
    into :var_role_id;

    delete from user_roles where role_id = :var_role_id;

    delete from user_roles_rights_mst where role_name = :in_role_name;    
end^

commit^

execute procedure temp_remove_role_from_user('Underwriter - Task Notification')^

commit^

drop procedure temp_remove_role_from_user^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("210713DC04", "MHM-424 remove role and from user role", "2021-Jul-13");