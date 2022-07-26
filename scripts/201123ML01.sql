set term ^;

alter procedure i_model_custom_source_code (
    in_name             varchar(100) character set none,
    in_description      varchar(512) character set none,
    in_code_id          blob sub_type 1 segment size 80,
    in_enabled          smallint,
    in_effective_date   date,
    in_source_code_type varchar(80))
returns (
    out_code_id integer)
as
    declare variable var_master_code_id      integer;
    declare variable var_book_id             integer;
    declare variable var_source_code_type_id integer;
    declare variable var_code_id             integer;
begin
    out_code_id = gen_id(gen_custom_code_id, 1);
    select max(book_id)
      from rate_book rb
     where rb.effective_date <= :in_effective_date
       and rb.expiry_date >= :in_effective_date
      into :var_book_id;
    select source_code_type_id
      from source_code_type s
     where s.source_code_type = :in_source_code_type
      into :var_source_code_type_id;

    insert into custom_source_code (
                 code_id, name, description, source_code, source_code_type_id)
         values (:out_code_id, :in_name, :in_description, :in_code_id, :var_source_code_type_id);

    select ccd.code_id
      from custom_source_code ccd
     where ccd.code_id = :out_code_id
      into :var_code_id;

    if (:var_code_id is not null) then
    begin
        suspend;
    end
end^

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

create procedure tmp_create_rule(in_line varchar(2))
as
    declare variable var_category_id   integer;
    declare variable var_master_id     integer;
    declare variable var_detail_id     integer;
    declare variable var_code_id       integer;
    declare variable var_auth_limit_id integer;
    declare variable var_activity_id   varchar(50);
begin
    select code_id
      from custom_source_code
     where name = 'AuthorizationLimitDwellingContents'
      into :var_code_id;
    
    /* Section I - Contents Rules that DON'T create tasks */
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
      from i_model_rule_details(:var_master_id, "Section I - Contents exceeds authorized limit", :var_code_id, 1, 'TODAY')
      into :var_detail_id;

    select out_auth_limit_id
      from tmp_create_limits(:var_detail_id, 250001, null, 'MGMTSR', 'UWSR', 'UW', 'UWMGR')
      into :var_auth_limit_id;

    /* Section I - Contents Rules that create tasks */
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
      from i_model_rule_details(:var_master_id, "Section I - Contents exceeds authorized limit", :var_code_id, 1, 'TODAY')
      into :var_detail_id;

    select out_auth_limit_id
      from tmp_create_limits(:var_detail_id, 250001, null, 'MGMTSR', 'UWSR', 'UW', 'UWMGR')
      into :var_auth_limit_id;

    select activity_id
      from task_activity
     where activity_name = 'DWELLINGCONTENTS_UW' rows 1
      into :var_activity_id;

    insert into rule_unauthorized_task_link (auth_limit_id, activity_id)
         values (:var_auth_limit_id, :var_activity_id);
end^

insert into task_activity (task_title, default_number_of_days_due, task_message, activity_name, web_link, notify_agent, notify_creator, category_name)
     values ("Section I - Contents exceeds Broker limit", 5, "An application has been submitted with Section I - Contents that requires Underwriter review.", 'DWELLINGCONTENTS_UW', null, 1, 1, 'CONTENTS')^

commit work^

execute procedure i_model_custom_source_code('AuthorizationLimitDwellingContents', "Section I - Contents exceeds authorized limit", '', 1, 'TODAY', 'AUTHORIZE')^

commit work^

execute procedure tmp_create_rule('OP')^
execute procedure tmp_create_rule('SP')^
execute procedure tmp_create_rule('RP')^

commit work^

execute procedure temp_create_view_activity_right('DWELLINGCONTENTS_UW', 'AG')^
execute procedure temp_create_view_activity_right('DWELLINGCONTENTS_UW', 'UW')^
execute procedure temp_create_view_activity_right('DWELLINGCONTENTS_UW', 'UWSR')^
execute procedure temp_create_view_activity_right('DWELLINGCONTENTS_UW', 'UWMGR')^
execute procedure temp_create_view_activity_right('DWELLINGCONTENTS_UW', 'MGMTSR')^

execute procedure temp_create_edit_activity_right('DWELLINGCONTENTS_UW', 'UW')^
execute procedure temp_create_edit_activity_right('DWELLINGCONTENTS_UW', 'UWSR')^
execute procedure temp_create_edit_activity_right('DWELLINGCONTENTS_UW', 'UWMGR')^
execute procedure temp_create_edit_activity_right('DWELLINGCONTENTS_UW', 'MGMTSR')^

commit work^

drop procedure tmp_create_rule^
drop procedure tmp_create_limits^
drop procedure temp_create_view_activity_right^
drop procedure temp_create_edit_activity_right^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("201123ML01", "RT-178 - inserted missing rules", "2020-NOV-23");