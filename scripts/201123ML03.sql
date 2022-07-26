set term ^;

create procedure tmp_create_limits (
    detail_id     integer,
    from_limit    integer,
    to_limit      integer,
    security_key1 varchar(10),
    security_key2 varchar(10),
    security_key3 varchar(10),
    security_key4 varchar(10))
returns (
    out_auth_limit_id integer)
as
    declare variable var_security_id integer;
begin
    out_auth_limit_id = gen_id(gen_auth_limit_id, 1);

    insert into rule_authorization_limits (auth_limit_id, from_limit, to_limit)
         values (:out_auth_limit_id, :from_limit, :to_limit);

    insert into rule_authorization_limits_link (rule_detail_id, auth_limit_id)
         values (:detail_id, :out_auth_limit_id);

    select id
      from ais_security
     where right_key = :security_key1 rows 1
      into :var_security_id;

    insert into rule_authorization_limits_identity (auth_limit_id, security_id)
         values (:out_auth_limit_id, :var_security_id);

    if (:security_key2 is not null) then
    begin
        select id
          from ais_security
         where right_key = :security_key2 rows 1
          into :var_security_id;

        insert into rule_authorization_limits_identity (auth_limit_id, security_id)
             values (:out_auth_limit_id, :var_security_id);
    end

    if (:security_key3 is not null) then
    begin
        select id
          from ais_security
         where right_key = :security_key3 rows 1
          into :var_security_id;

        insert into rule_authorization_limits_identity (auth_limit_id, security_id)
             values (:out_auth_limit_id, :var_security_id);
    end

    if (:security_key4 is not null) then
    begin
        select id
          from ais_security
         where right_key = :security_key4 rows 1
          into :var_security_id;

        insert into rule_authorization_limits_identity (auth_limit_id, security_id)
             values (:out_auth_limit_id, :var_security_id);
    end

    suspend;
end^

commit work^

create procedure tmp_create_rule(in_line varchar(2))
as
    declare variable var_category_id   integer;
    declare variable var_code_id       integer;
    declare variable var_master_id     integer;
    declare variable var_detail_id     integer;
    declare variable var_auth_limit_id integer;
    declare variable var_activity_id   varchar(50);
begin
    select code_id
      from custom_source_code
     where name = 'AuthorizationLimitBusinessInterruptionIncrease'
      into :var_code_id;
    
    /* Business Interruption Rules that DON'T create tasks */
    select rule_category_id
      from rule_categories
     where rule_code = 'AUTHORIZATION_LIMITS' rows 1
      into :var_category_id;

    select rule_master_id
      from rule_master 
     where line = :in_line
       and rule_category_id = :var_category_id
      into :var_master_id;
    
    select out_detail_id
      from i_model_rule_details(:var_master_id, "Business Interruption exceeds authorized limit", :var_code_id, 1, 'TODAY')
      into :var_detail_id;

    select out_auth_limit_id
      from tmp_create_limits(:var_detail_id, 1, null, 'MGMTSR', 'UWSR', 'UW', 'UWMGR')
      into :var_auth_limit_id;

    /* Business Interruption Rules that create tasks */
    select rule_category_id
      from rule_categories
     where rule_code = 'AUTHORIZATION_LIMITS_NOTIFY' rows 1
      into :var_category_id;

    select rule_master_id
      from rule_master 
     where line = :in_line
       and rule_category_id = :var_category_id
      into :var_master_id;

    select out_detail_id
      from i_model_rule_details(:var_master_id, "Business Interruption exceeds authorized limit", :var_code_id, 1, 'TODAY')
      into :var_detail_id;

    select out_auth_limit_id
      from tmp_create_limits(:var_detail_id, 1, null, 'MGMTSR', 'UWSR', 'UW', 'UWMGR')
      into :var_auth_limit_id;

    select activity_id
      from task_activity
     where activity_name = 'BUSINESSINTERRUPT_UW' rows 1
      into :var_activity_id;

    insert into rule_unauthorized_task_link (auth_limit_id, activity_id)
         values (:var_auth_limit_id, :var_activity_id);
end^

commit work^

execute procedure i_model_custom_source_code('AuthorizationLimitBusinessInterruptionIncrease', "Business Interruption exceeds authorized limit", '', 1, 'TODAY', 'AUTHORIZE')^
commit work^
execute procedure tmp_create_rule('RP')^
execute procedure tmp_create_rule('SP')^

commit work^

drop procedure tmp_create_rule^
drop procedure tmp_create_limits^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("201123ML03", "RT-178 - inserted missing rules", "2020-NOV-23");