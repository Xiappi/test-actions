set term ^;

create procedure temp_create_view_activity_right (in_activity_name varchar(50), in_view_right_key varchar(10))
as
    declare variable var_task_id            integer;
    declare variable var_view_right_id      integer;
begin
    select activity_id
      from task_activity
     where activity_name = :in_activity_name
      into :var_task_id;

      select asec.id
      from ais_security asec
     where asec.right_key = :in_view_right_key
      into :var_view_right_id;

    /* insert VIEW permissions */
    if(:var_view_right_id is not null) then
    begin
        insert into task_activity_rights (activity_id, security_level_key, security_key_id)
             values (:var_task_id, 'VIEW', :var_view_right_id);
    end
end^

create procedure temp_create_edit_activity_right (in_activity_name varchar(50), in_edit_right_key varchar(10))
as
    declare variable var_task_id            integer;
    declare variable var_edit_right_id      integer;
begin
    select activity_id
      from task_activity
     where activity_name = :in_activity_name
      into :var_task_id;

      select asec.id
      from ais_security asec
     where asec.right_key = :in_edit_right_key
      into :var_edit_right_id;

    /* insert EDIT permissions */
    if(:var_edit_right_id is not null) then
    begin
        insert into task_activity_rights (activity_id, security_level_key, security_key_id)
             values (:var_task_id, 'EDIT', :var_edit_right_id);
    end
end^

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
      from i_model_custom_source_code('RP', 'AuthorizationLimitGoodsInTransit', "Goods in Transit exceeds authorized limit", '', 1, 'TODAY', 'AUTHORIZE')
      into :var_code_id;
    
    /* Goods in Transit Rules that DON'T create tasks */
    select rule_category_id
      from rule_categories
     where rule_code = 'AUTHORIZATION_LIMITS' rows 1
      into :var_category_id;

    select rule_master_id
      from rule_master 
     where line = 'RP' 
       and rule_category_id = :var_category_id
      into :var_master_id;
    
    select out_detail_id
      from i_model_rule_details(:var_master_id, 'AuthorizationLimitGoodsInTransit', "Goods in Transit exceeds authorized limit", :var_code_id, 1, 'TODAY', 1, 1, 1, 0)
      into :var_detail_id;

    select out_auth_limit_id
      from tmp_create_limits(:var_detail_id, 10001, 25000, 'MGMTSR', 'UWSR', null, null)
      into :var_auth_limit_id;

    select out_auth_limit_id
      from tmp_create_limits(:var_detail_id, 25001, 587500, 'MGMTSR', null, null, null)
      into :var_auth_limit_id;

    /* Goods in Transit Rules that create tasks */
    select rule_category_id
      from rule_categories
     where rule_code = 'AUTHORIZATION_LIMITS_NOTIFY' rows 1
      into :var_category_id;

    select rule_master_id
      from rule_master 
     where line = 'RP' 
       and rule_category_id = :var_category_id
      into :var_master_id;

    select out_detail_id
      from i_model_rule_details(:var_master_id, 'AuthorizationLimitGoodsInTransit_Notify', "Goods in Transit exceeds authorized limit", :var_code_id, 1, 'TODAY', 1, 1, 1, 0)
      into :var_detail_id;

    select out_auth_limit_id
      from tmp_create_limits(:var_detail_id, 10001, 25000, 'UWSR', 'MGMTSR', null, null)
      into :var_auth_limit_id;

    select activity_id
      from task_activity
     where activity_name = 'GOODSINTRANSIT_UWSR' rows 1
      into :var_activity_id;

    insert into rule_unauthorized_task_link (auth_limit_id, activity_id)
         values (:var_auth_limit_id, :var_activity_id);

    select out_auth_limit_id
      from tmp_create_limits(:var_detail_id, 25001, 587500, 'MGMTSR', null, null, null)
      into :var_auth_limit_id;

    select activity_id
      from task_activity
     where activity_name = 'GOODSINTRANSIT_MGMTSR' rows 1
      into :var_activity_id;

    insert into rule_unauthorized_task_link (auth_limit_id, activity_id)
         values (:var_auth_limit_id, :var_activity_id);
end^

insert into task_activity (task_title, default_number_of_days_due, task_message, activity_name, web_link, notify_agent, notify_creator, category_name)
     values ("Goods in Transit exceeds 10,000", 5, "An application has been submitted with goods in transit coverage over 10,000 that needs your review.", 'GOODSINTRANSIT_UWSR', null, 1, 1, 'GOODS')^
 
insert into task_activity (task_title, default_number_of_days_due, task_message, activity_name, web_link, notify_agent, notify_creator, category_name) 
     values ("Goods in Transit exceeds 25,000", 5,  "An application has been submitted with goods in transit coverage over 25,000 that needs your review.", 'GOODSINTRANSIT_MGMTSR', null, 1, 1, 'GOODS')^

commit work^

execute procedure tmp_create_rule^

commit work^

execute procedure temp_create_view_activity_right('GOODSINTRANSIT_UW', 'AG')^
execute procedure temp_create_view_activity_right('GOODSINTRANSIT_UW', 'UW')^
execute procedure temp_create_view_activity_right('GOODSINTRANSIT_UW', 'UWSR')^
execute procedure temp_create_view_activity_right('GOODSINTRANSIT_UW', 'MGMTSR')^
execute procedure temp_create_edit_activity_right('GOODSINTRANSIT_UW', 'UW')^
execute procedure temp_create_edit_activity_right('GOODSINTRANSIT_UW', 'UWSR')^
execute procedure temp_create_edit_activity_right('GOODSINTRANSIT_UW', 'MGMTSR')^

execute procedure temp_create_view_activity_right('GOODSINTRANSIT_UWSR', 'AG')^
execute procedure temp_create_view_activity_right('GOODSINTRANSIT_UWSR', 'UW')^
execute procedure temp_create_view_activity_right('GOODSINTRANSIT_UWSR', 'UWSR')^
execute procedure temp_create_view_activity_right('GOODSINTRANSIT_UWSR', 'MGMTSR')^
execute procedure temp_create_edit_activity_right('GOODSINTRANSIT_UWSR', 'UWSR')^
execute procedure temp_create_edit_activity_right('GOODSINTRANSIT_UWSR', 'MGMTSR')^

execute procedure temp_create_view_activity_right('GOODSINTRANSIT_MGMTSR', 'AG')^
execute procedure temp_create_view_activity_right('GOODSINTRANSIT_MGMTSR', 'UW')^
execute procedure temp_create_view_activity_right('GOODSINTRANSIT_MGMTSR', 'UWSR')^
execute procedure temp_create_view_activity_right('GOODSINTRANSIT_MGMTSR', 'MGMTSR')^
execute procedure temp_create_edit_activity_right('GOODSINTRANSIT_MGMTSR', 'MGMTSR')^

commit work^

drop procedure tmp_create_rule^
drop procedure tmp_create_limits^
drop procedure temp_create_view_activity_right^
drop procedure temp_create_edit_activity_right^

set term ;^

insert into applied_scripts (name, description, script_date)
     values ('201020ML05', 'RT-161 - auth level for goods in transit', '2020-Sept-20');