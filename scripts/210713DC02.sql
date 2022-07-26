set term ^;

create procedure temp_add_ais_right_to_roles (
    in_role_name        varchar(100) character set none,
    in_security_key     varchar(10) character set none
)
as
  declare variable var_role_id          integer;
  declare variable var_security_key_id  integer;
begin
    select urrm.role_id
        from user_roles_rights_mst urrm
    where urrm.role_name = :in_role_name
        into :var_role_id;

    select asec.id
        from ais_security asec
    where asec.right_key = :in_security_key
        into :var_security_key_id;     

    if (:var_role_id is not null) then
    begin
        insert into user_roles_rights_dtl (right_id, role_id, security_key, security_key_id, last_modified_date, last_modified_by)
            values (gen_id(rightid_gen, 1), :var_role_id, :in_security_key, :var_security_key_id, 'NOW', null);
    end

end^

commit^

execute procedure temp_add_ais_right_to_roles('Underwriter', 'INTERNCOV')^
execute procedure temp_add_ais_right_to_roles('Underwriter - Senior', 'INTERNCOV')^
execute procedure temp_add_ais_right_to_roles('Underwriter - Manager', 'INTERNCOV')^
execute procedure temp_add_ais_right_to_roles('Senior Management', 'INTERNCOV')^

commit^

drop procedure temp_add_ais_right_to_roles^

set term ;^

insert into applied_scripts (name, description, script_date)
     values ('210713DC02', 'MHM-218 add ais right to roles', '2021-Jul-13');