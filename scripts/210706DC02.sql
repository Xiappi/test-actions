set term ^;

create procedure temp_insert_new_security_right (
	in_security_key  varchar(10) character set none,
	in_role_name     varchar(100) character set none)
as
    declare variable var_role_id      integer;
    declare variable var_security_id  integer;
begin
	select asec.id
	  from ais_security asec
	 where asec.right_key = :in_security_key
	  into :var_security_id;
	  
	select urrm.role_id
	  from user_roles_rights_mst urrm
	 where urrm.role_name = :in_role_name
	  into :var_role_id;
	
	insert into user_roles_rights_dtl (right_id, role_id, security_key, security_key_id, last_modified_date, last_modified_by)
	     values (gen_id(rightid_gen,1), :var_role_id, :in_security_key, :var_security_id, 'NOW', null);
end^

commit^

execute procedure temp_insert_new_security_right('PMSCINT', 'Underwriter - Task Notification')^

commit^

drop procedure temp_insert_new_security_right^

set term ;^

insert into applied_scripts (name, description, script_date)
     values ('210706DC02', 'AIS-35980 add ais to pms interface permission to user role', '2021-Jul-06');