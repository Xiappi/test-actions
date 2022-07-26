set term ^;

create procedure tmp_remove_auth_limits (
    line_code varchar(2),
    code_name varchar(100))
as
    declare variable var_rule_detail_id integer;
    declare variable var_auth_limit_id  integer;
begin
    for select rall.auth_limit_id
          from rule_details rd
          join custom_source_code csc on csc.code_id = rd.code_id
          join rule_master_detail_link rmdl on rmdl.rule_detail_id = rd.rule_detail_id
          join rule_master rm on rm.rule_master_id = rmdl.rule_master_id
          join rule_authorization_limits_link rall on rall.rule_detail_id = rd.rule_detail_id
         where csc.name = :code_name
           and rm.line = :line_code
          into :var_auth_limit_id
    do
    begin
        delete from rule_authorization_limits_identity
         where auth_limit_id = :var_auth_limit_id;

        delete from rule_unauthorized_task_link
         where auth_limit_id = :var_auth_limit_id;

        delete from rule_authorization_limits_link
         where auth_limit_id = :var_auth_limit_id;

        delete from rule_authorization_limits
         where auth_limit_id = :var_auth_limit_id;
    end
end^

create procedure tmp_insert_auth_limit (
    line_code        varchar(2),
    code_name        varchar(100),
    from_limit       integer,
    to_limit         integer,
    notify_task_name varchar(50),
    security_key1    varchar(10),
    security_key2    varchar(10),
    security_key3    varchar(10),
    security_key4    varchar(10))
as
    declare variable var_auth_limit_id integer;
    declare variable var_detail_id     integer;
    declare variable var_security_id   integer;
    declare variable var_activity_id   integer;
begin
    for select rd.rule_detail_id
          from rule_categories rc
          join rule_master rm
                     on rm.rule_category_id = rc.rule_category_id
          join rule_master_detail_link rmdl
                     on rmdl.rule_master_id = rm.rule_master_id
          join rule_details rd
                     on rd.rule_detail_id = rmdl.rule_detail_id
          join custom_source_code csc
                     on csc.code_id = rd.code_id
         where (   (rc.rule_code = 'AUTHORIZATION_LIMITS' and :notify_task_name is null) 
                or (rc.rule_code = 'AUTHORIZATION_LIMITS_NOTIFY' and :notify_task_name is not null))
           and csc.name = :code_name
           and rm.line = :line_code
          into :var_detail_id
    do
    begin
        var_auth_limit_id = gen_id(gen_auth_limit_id, 1);

        insert into rule_authorization_limits (auth_limit_id, from_limit, to_limit)
             values (:var_auth_limit_id, :from_limit, :to_limit);

        insert into rule_authorization_limits_link (rule_detail_id, auth_limit_id)
             values (:var_detail_id, :var_auth_limit_id);

        select id
          from ais_security
         where right_key = :security_key1 rows 1
          into :var_security_id;

        insert into rule_authorization_limits_identity (auth_limit_id, security_id)
             values (:var_auth_limit_id, :var_security_id);

        if (:security_key2 is not null) then
        begin
            select id
              from ais_security
             where right_key = :security_key2 rows 1
              into :var_security_id;

            insert into rule_authorization_limits_identity (auth_limit_id, security_id)
                 values (:var_auth_limit_id, :var_security_id);
        end

        if (:security_key3 is not null) then
        begin
            select id
              from ais_security
             where right_key = :security_key3 rows 1
              into :var_security_id;

            insert into rule_authorization_limits_identity (auth_limit_id, security_id)
                 values (:var_auth_limit_id, :var_security_id);
        end

        if (:security_key4 is not null) then
        begin
            select id
              from ais_security
             where right_key = :security_key4 rows 1
              into :var_security_id;

            insert into rule_authorization_limits_identity (auth_limit_id, security_id)
                 values (:var_auth_limit_id, :var_security_id);
        end

        if (:notify_task_name is not null) then
        begin
            select activity_id
              from task_activity
             where activity_name = :notify_task_name
              into :var_activity_id;

            insert into rule_unauthorized_task_link (auth_limit_id, activity_id)
                 values (:var_auth_limit_id, :var_activity_id);
        end
    end
end^

/* remove limits before replacing with updated values */
execute procedure tmp_remove_auth_limits('SP', 'AuthorizationLimitMachineryUngrouped')^

commit work^

execute procedure tmp_insert_auth_limit('SP', 'AuthorizationLimitMachineryUngrouped', 1, 250000, 'MACHINERY_UW', 'UW', 'UWSR', 'UWMGR', 'MGMTSR')^
execute procedure tmp_insert_auth_limit('SP', 'AuthorizationLimitMachineryUngrouped', 1, 250000, null, 'UW', 'UWSR', 'UWMGR', 'MGMTSR')^
execute procedure tmp_insert_auth_limit('SP', 'AuthorizationLimitMachineryUngrouped', 250001, 5000000, 'MACHINERY_UWSR', 'UWSR', 'UWMGR', 'MGMTSR', null)^
execute procedure tmp_insert_auth_limit('SP', 'AuthorizationLimitMachineryUngrouped', 250001, 5000000, null, 'UWSR', 'UWMGR', 'MGMTSR', null)^

commit work^

drop procedure tmp_insert_auth_limit^
drop procedure tmp_remove_auth_limits^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("201126ML02", "RT-178 - updating SP auth rule limits", "2020-NOV-26");
