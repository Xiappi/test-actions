set term ^;

execute procedure i_model_ais_security ('IDENTITY', 'MGMTSR', 'Senior Management')^

create procedure tmp_create_limits (
    detail_id     integer,
    from_limit    integer,
    to_limit      integer,
    security_key1 varchar(10),
    security_key2 varchar(10),
    security_key3 varchar(10))
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

    suspend;
end^

commit work^

create procedure tmp_create_rule
as
    declare variable var_category_id   integer;
    declare variable var_master_id     integer;
    declare variable var_detail_id     integer;
    declare variable var_code_id       integer;
    declare variable var_auth_limit_id integer;
    declare variable var_activity_id   varchar(50);
begin
    select out_code_id
      from i_model_custom_source_code('RP', 'AuthorizationLimitGlass', 'Glass exceeds authorized limit', '', 1, 'TODAY', 'AUTHORIZE')
      into :var_code_id;
    
    /* Glass Rules that DON'T create tasks */
    select rule_category_id
      from rule_categories
     where rule_code = 'AUTHORIZATION_LIMITS' rows 1
      into :var_category_id;

    select out_master_id
      from i_model_rule_master('RP', :var_category_id)
      into :var_master_id;
    
    select out_detail_id
      from i_model_rule_details(:var_master_id, 'AuthorizationLimitGlass', 'Glass exceeds authorized limit', :var_code_id, 1, 'TODAY', 1, 1, 1, 0)
      into :var_detail_id;

    select out_auth_limit_id
      from tmp_create_limits(:var_detail_id, 10001, 25000, 'UW', 'UWSR', 'MGMTSR')
      into :var_auth_limit_id;

    select out_auth_limit_id
      from tmp_create_limits(:var_detail_id, 25001, 175000, 'UWSR', 'MGMTSR', null)
      into :var_auth_limit_id;

    select out_auth_limit_id
      from tmp_create_limits(:var_detail_id, 175001, 250000, 'MGMTSR', null, null)
      into :var_auth_limit_id;

    /* Glass Rules that create tasks */
    select rule_category_id
      from rule_categories
     where rule_code = 'AUTHORIZATION_LIMITS_NOTIFY' rows 1
      into :var_category_id;

    select out_master_id
      from i_model_rule_master('RP', :var_category_id)
      into :var_master_id;

    select out_detail_id
      from i_model_rule_details(:var_master_id, 'AuthorizationLimitGlass_Notify', 'Glass exceeds authorized limit', :var_code_id, 1, 'TODAY', 1, 1, 1, 0)
      into :var_detail_id;

    select out_auth_limit_id
      from tmp_create_limits(:var_detail_id, 10001, 25000, 'UW', 'UWSR', 'MGMTSR')
      into :var_auth_limit_id;

    select activity_id
      from task_activity
     where activity_name = 'GLASS_10K' rows 1
      into :var_activity_id;

    insert into rule_unauthorized_task_link (auth_limit_id, activity_id)
         values (:var_auth_limit_id, :var_activity_id);

    select out_auth_limit_id
      from tmp_create_limits(:var_detail_id, 25001, 175000, 'UWSR', 'MGMTSR', null)
      into :var_auth_limit_id;

    select activity_id
      from task_activity
     where activity_name = 'GLASS_25K' rows 1
      into :var_activity_id;

    insert into rule_unauthorized_task_link (auth_limit_id, activity_id)
         values (:var_auth_limit_id, :var_activity_id);

    select out_auth_limit_id
      from tmp_create_limits(:var_detail_id, 175001, 250000, 'MGMTSR', null, null)
      into :var_auth_limit_id;

    select activity_id
      from task_activity
     where activity_name = 'GLASS_175K' rows 1
      into :var_activity_id;

    insert into rule_unauthorized_task_link (auth_limit_id, activity_id)
         values (:var_auth_limit_id, :var_activity_id);
end^

insert into task_activity (task_title, default_number_of_days_due, task_message, activity_name, web_link, notify_agent, notify_creator, category_name)
     values ('Glass exceeds 10,000', 5, 'An application has been submitted with glass coverage over 10,000 that needs your review.', 'GLASS_10K', null, 1, 1, 'GLASS')^
 
insert into task_activity (task_title, default_number_of_days_due, task_message, activity_name, web_link, notify_agent, notify_creator, category_name) 
     values ('Glass exceeds 25,000', 5,  'An application has been submitted with glass coverage over 25,000 that needs your review.', 'GLASS_25K', null, 1, 1, 'GLASS')^

insert into task_activity (task_title, default_number_of_days_due, task_message, activity_name, web_link, notify_agent, notify_creator, category_name)
     values ('Glass exceeds 175,000', 5, 'An application has been submitted with glass coverage over 175,000 that needs your review.', 'GLASS_175K', null, 1, 1, 'GLASS')^

commit work^

execute procedure tmp_create_rule^

commit work^

drop procedure tmp_create_rule^
drop procedure tmp_create_limits^

commit work^

set term ;^

insert into applied_scripts (name, description, script_date)
     values ('200918ML01', 'RT-161 - auth level for glass coverage', '2020-Sept-18');