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

    insert into rule_authorization_limits (auth_limit_id, from_limit, to_limit, rule_detail_id)
         values (:out_auth_limit_id, :from_limit, :to_limit, :detail_id);

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

create procedure temp_configure_task_activity_rights (
    in_activity_name      varchar(50),
    in_right_key          varchar(10),
    in_security_level_key varchar(10))
as
    declare variable var_task_activity_id integer;
    declare variable var_ais_security_id  integer;
begin
   select ta.activity_id
    from task_activity ta
   where ta.activity_name = :in_activity_name
    into :var_task_activity_id;

   select asec.id
    from ais_security asec
   where asec.right_key = :in_right_key
    into :var_ais_security_id;

   insert into task_activity_rights(activity_id, security_key_id, security_level_key)
          values (:var_task_activity_id, :var_ais_security_id, :in_security_level_key);

  suspend;
end^
 
create procedure temp_create_rule_without_notify(
  in_rule_name  varchar(100) character set none,
  in_rule_msg   varchar(255) character set none)
as
    declare variable var_category_id         integer;
    declare variable var_code_id             integer;
    declare variable var_detail_id           integer;
    declare variable var_source_code_type_id integer;
    declare variable var_book_id             integer;
    declare variable var_auth_limit_id       integer;   
begin
 
    select source_code_type_id
      from source_code_type
     where source_code_type = 'AUTHORIZE'
      into :var_source_code_type_id; 
 
      var_code_id = gen_id(gen_custom_code_id, 1);
 
    insert into custom_source_code (code_id, name, description, source_code, source_code_type_id)
         values (:var_code_id, :in_rule_name, :in_rule_msg, '', :var_source_code_type_id);
 
    select rule_category_id 
      from rule_categories 
     where rule_code = 'AUTHORIZATION_LIMITS' 
      into :var_category_id;
 
    select max(book_id)
      from rate_book rb
     where rb.effective_date <= 'TODAY'
       and rb.expiry_date >= 'TODAY'
      into :var_book_id;
 
      var_detail_id = gen_id(gen_rule_detail_id, 1);
 
    insert into rule_details(rule_detail_id, code_id, fail_message, rule_active, effective_book_id, sequence)
        values (:var_detail_id, :var_code_id, :in_rule_msg, 1, :var_book_id, 0);
 
    insert into rule_master_detail_link (rule_detail_id, rule_category_id, line)
        values (:var_detail_id, :var_category_id, 'HX');

    /* Adding the auth limits */
    select out_auth_limit_id
      from tmp_create_limits(:var_detail_id, 5001, 10000, 'UW', 'UWSR', 'UWMGR', 'MGMTSR')
      into :var_auth_limit_id;

    select out_auth_limit_id
      from tmp_create_limits(:var_detail_id, 10001, 100000, 'UWMGR', 'MGMTSR', null, null)
      into :var_auth_limit_id;
 
    suspend;
end^

create procedure temp_create_rule_with_notify(
  in_rule_name  varchar(100) character set none,
  in_rule_msg   varchar(255) character set none)
as
    declare variable var_category_id         integer;
    declare variable var_code_id             integer;
    declare variable var_detail_id           integer;
    declare variable var_source_code_type_id integer;
    declare variable var_book_id             integer;
    declare variable var_auth_limit_id       integer;
    declare variable var_activity_id         varchar(50);   
begin
    select csc.code_id
      from custom_source_code csc
     where csc.name = :in_rule_name
      into :var_code_id;    

    select rule_category_id 
      from rule_categories 
     where rule_code = 'AUTHORIZATION_LIMITS_NOTIFY' 
      into :var_category_id;
 
    select max(book_id)
      from rate_book rb
     where rb.effective_date <= 'TODAY'
       and rb.expiry_date >= 'TODAY'
      into :var_book_id;
 
      var_detail_id = gen_id(gen_rule_detail_id, 1);
 
    insert into rule_details(rule_detail_id, code_id, fail_message, rule_active, effective_book_id, sequence)
        values (:var_detail_id, :var_code_id, :in_rule_msg, 1, :var_book_id, 0);
 
    insert into rule_master_detail_link (rule_detail_id, rule_category_id, line)
        values (:var_detail_id, :var_category_id, 'HX');

    /* Adding the auth limits and linking */
    select out_auth_limit_id
      from tmp_create_limits(:var_detail_id, 5001, 10000, 'UW', 'UWSR', 'UWMGR', 'MGMTSR')
      into :var_auth_limit_id;

    select activity_id
      from task_activity
     where activity_name = 'ALLRISKS_SUM_HX_UW' rows 1
      into :var_activity_id;

    insert into rule_unauthorized_task_link (auth_limit_id, activity_id)
         values (:var_auth_limit_id, :var_activity_id);

    
    select out_auth_limit_id
      from tmp_create_limits(:var_detail_id, 10001, 100000, 'UWMGR', 'MGMTSR', null, null)
      into :var_auth_limit_id;

    select activity_id
      from task_activity
     where activity_name = 'ALLRISKS_SUM_HX_UWMGR' rows 1
      into :var_activity_id;

    insert into rule_unauthorized_task_link (auth_limit_id, activity_id)
         values (:var_auth_limit_id, :var_activity_id);  
 
    suspend;
end^

/* Create task activities */
insert into task_activity (task_title, default_number_of_days_due, task_message, activity_name, web_link, notify_agent, notify_creator, category_name)
     values ('All Risks (any one policy) exceeds Broker limit', 5, 'An application has been submitted with All Risks (any one policy) coverage that requires Underwriter review.', 'ALLRISKS_SUM_HX_UW', null, 1, 1, 'ALLRISKS')^
 
insert into task_activity (task_title, default_number_of_days_due, task_message, activity_name, web_link, notify_agent, notify_creator, category_name) 
     values ('All Risks (any one policy) exceeds Senior Underwriter limit', 5,  'An application has been submitted with All Risks (any one policy) coverage that requires Underwriting Manager review.', 'ALLRISKS_SUM_HX_UWMGR', null, 1, 1, 'ALLRISKS')^

/* Add rights to the new task activity */
execute procedure temp_configure_task_activity_rights('ALLRISKS_SUM_HX_UW', 'AG', 'VIEW')^
execute procedure temp_configure_task_activity_rights('ALLRISKS_SUM_HX_UW', 'UW', 'VIEW')^
execute procedure temp_configure_task_activity_rights('ALLRISKS_SUM_HX_UW', 'UWSR', 'VIEW')^
execute procedure temp_configure_task_activity_rights('ALLRISKS_SUM_HX_UW', 'MGMTSR', 'VIEW')^
execute procedure temp_configure_task_activity_rights('ALLRISKS_SUM_HX_UW', 'UWMGR', 'VIEW')^
execute procedure temp_configure_task_activity_rights('ALLRISKS_SUM_HX_UW', 'UW', 'EDIT')^
execute procedure temp_configure_task_activity_rights('ALLRISKS_SUM_HX_UW', 'UWSR', 'EDIT')^
execute procedure temp_configure_task_activity_rights('ALLRISKS_SUM_HX_UW', 'MGMTSR', 'EDIT')^
execute procedure temp_configure_task_activity_rights('ALLRISKS_SUM_HX_UW', 'UWMGR', 'EDIT')^

execute procedure temp_configure_task_activity_rights('ALLRISKS_SUM_HX_UWMGR', 'AG', 'VIEW')^
execute procedure temp_configure_task_activity_rights('ALLRISKS_SUM_HX_UWMGR', 'UW', 'VIEW')^
execute procedure temp_configure_task_activity_rights('ALLRISKS_SUM_HX_UWMGR', 'UWSR', 'VIEW')^
execute procedure temp_configure_task_activity_rights('ALLRISKS_SUM_HX_UWMGR', 'MGMTSR', 'VIEW')^
execute procedure temp_configure_task_activity_rights('ALLRISKS_SUM_HX_UWMGR', 'UWMGR', 'VIEW')^
execute procedure temp_configure_task_activity_rights('ALLRISKS_SUM_HX_UWMGR', 'MGMTSR', 'EDIT')^
execute procedure temp_configure_task_activity_rights('ALLRISKS_SUM_HX_UWMGR', 'UWMGR', 'EDIT')^


execute procedure temp_create_rule_without_notify('AuthorizationLimitAllRisksSumHX', 'All Risks (any one policy) exceeds authorized limit')^
execute procedure temp_create_rule_with_notify('AuthorizationLimitAllRisksSumHX', 'All Risks (any one policy) exceeds authorized limit')^

drop procedure temp_create_rule_without_notify^
drop procedure temp_create_rule_with_notify^
drop procedure tmp_create_limits^
drop procedure temp_configure_task_activity_rights^

set term ;^

insert into applied_scripts (name, description, script_date)
     values ('210811DC03', 'MHM-105 add rule for allrisk sum and auth limit', '2021-Aug-11');