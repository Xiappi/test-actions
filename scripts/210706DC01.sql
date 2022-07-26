set term ^;

insert into user_roles_rights_mst (role_id, role_name, role_description, last_modified_date, last_modified_by, default_role)
        values (gen_id(roleid_gen, 1), 'Underwriter - Task Notification', 'Temporary role for underwriters to receive task creation notification email', 'now', null, 0)^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("210706DC01", "AIS-35980 add new user role", "2021-Jul-06");
