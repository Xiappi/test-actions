set term ^;

create procedure temp_add_role_to_user (
    in_username  varchar(20) character set none,
    in_role_name varchar(100) character set none)
as
  declare variable var_user_key integer;
  declare variable var_role_id integer;
begin
  select u.user_key
    from users u
  where u.username = :in_username
    into :var_user_key;

  select urrm.role_id
    from user_roles_rights_mst urrm
  where urrm.role_name = :in_role_name
    into :var_role_id;

  if (:var_user_key is not null) then
  begin
      insert into user_roles(user_key, role_id, last_modified_date, last_modified_by)
        values (:var_user_key, :var_role_id, 'NOW', null);
  end

end^

commit^

execute procedure temp_add_role_to_user('lborg', 'Underwriter - Task Notification')^
execute procedure temp_add_role_to_user('mbezzina', 'Underwriter - Task Notification')^
execute procedure temp_add_role_to_user('psciortino', 'Underwriter - Task Notification')^
execute procedure temp_add_role_to_user('lcfarrugia', 'Underwriter - Task Notification')^

commit^

drop procedure temp_add_role_to_user^

set term ;^

insert into applied_scripts (name, description, script_date)
     values ('210706DC03', 'AIS-35980 add roles to users', '2021-Jul-06');
