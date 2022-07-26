set term ^;

create procedure temp_create_view_activity_right (in_activity_name varchar(25), in_view_right_key varchar(10))
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

create procedure temp_create_edit_activity_right (in_activity_name varchar(25), in_edit_right_key varchar(10))
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


/* PUBLIC LIABILITY */
insert into task_activity (task_title, default_number_of_days_due, task_message, activity_name, web_link, notify_agent, notify_creator, category_name)
     values ("Public Liability exceeds Underwriter limit", 5, "An application has been submitted with public liability coverage that requires Senior Underwriter review.", 'PUBLICLIABILITY_UWSR', null, 1, 1, 'PUBLIAB')^ 
insert into task_activity (task_title, default_number_of_days_due, task_message, activity_name, web_link, notify_agent, notify_creator, category_name)
     values ("Public Liability exceeds Senior Underwriter limit", 5, "An application has been submitted with public liability coverage that requires Underwriting Manager review.", 'PUBLICLIABILITY_UWMGR', null, 1, 1, 'PUBLIAB')^ 
execute procedure temp_create_view_activity_right('PUBLICLIABILITY_UWSR', 'AG')^
execute procedure temp_create_view_activity_right('PUBLICLIABILITY_UWSR', 'UW')^
execute procedure temp_create_view_activity_right('PUBLICLIABILITY_UWSR', 'UWSR')^
/*execute procedure temp_create_view_activity_right('PUBLICLIABILITY_UWSR', 'UWMGR')^*/
execute procedure temp_create_view_activity_right('PUBLICLIABILITY_UWSR', 'MGMTSR')^
execute procedure temp_create_edit_activity_right('PUBLICLIABILITY_UWSR', 'UWSR')^
execute procedure temp_create_edit_activity_right('PUBLICLIABILITY_UWSR', 'UWMGR')^
execute procedure temp_create_edit_activity_right('PUBLICLIABILITY_UWSR', 'MGMTSR')^

execute procedure temp_create_view_activity_right('PUBLICLIABILITY_UWMGR', 'AG')^
execute procedure temp_create_view_activity_right('PUBLICLIABILITY_UWMGR', 'UW')^
execute procedure temp_create_view_activity_right('PUBLICLIABILITY_UWMGR', 'UWSR')^
/*execute procedure temp_create_view_activity_right('PUBLICLIABILITY_UWMGR', 'UWMGR')^*/
execute procedure temp_create_view_activity_right('PUBLICLIABILITY_UWMGR', 'MGMTSR')^
execute procedure temp_create_edit_activity_right('PUBLICLIABILITY_UWMGR', 'UWMGR')^
execute procedure temp_create_edit_activity_right('PUBLICLIABILITY_UWMGR', 'MGMTSR')^


/* MONEY IN TRANSIT */
insert into task_activity (task_title, default_number_of_days_due, task_message, activity_name, web_link, notify_agent, notify_creator, category_name)
     values ("Money on the Premises During Business Hours/Transit exceeds Senior Underwriter limit", 5, "An application has been submitted with money on the premises during business hours/transit coverage that requires Underwriting Manager review.", 'MONEYINTRANSIT_UWMGR', null, 1, 1, 'MONEY')^
insert into task_activity (task_title, default_number_of_days_due, task_message, activity_name, web_link, notify_agent, notify_creator, category_name)
     values ("Money on the Premises During Business Hours/Transit exceeds Underwriting Manager limit", 5, "An application has been submitted with money on the premises during business hours/transit coverage that requires Senior Management review.", 'MONEYINTRANSIT_MGMTSR', null, 1, 1, 'MONEY')^
execute procedure temp_create_view_activity_right('MONEYINTRANSIT_UWMGR', 'AG')^
execute procedure temp_create_view_activity_right('MONEYINTRANSIT_UWMGR', 'UW')^
execute procedure temp_create_view_activity_right('MONEYINTRANSIT_UWMGR', 'UWSR')^
/*execute procedure temp_create_view_activity_right('MONEYINTRANSIT_UWMGR', 'UWMGR')^*/
execute procedure temp_create_view_activity_right('MONEYINTRANSIT_UWMGR', 'MGMTSR')^
execute procedure temp_create_edit_activity_right('MONEYINTRANSIT_UWMGR', 'UWMGR')^
execute procedure temp_create_edit_activity_right('MONEYINTRANSIT_UWMGR', 'MGMTSR')^
 
execute procedure temp_create_view_activity_right('MONEYINTRANSIT_MGMTSR', 'AG')^
execute procedure temp_create_view_activity_right('MONEYINTRANSIT_MGMTSR', 'UW')^
execute procedure temp_create_view_activity_right('MONEYINTRANSIT_MGMTSR', 'UWSR')^
/*execute procedure temp_create_view_activity_right('MONEYINTRANSIT_UWMGR', 'UWMGR')^*/
execute procedure temp_create_view_activity_right('MONEYINTRANSIT_MGMTSR', 'MGMTSR')^
execute procedure temp_create_edit_activity_right('MONEYINTRANSIT_MGMTSR', 'MGMTSR')^



/* GOODS */
insert into task_activity (task_title, default_number_of_days_due, task_message, activity_name, web_link, notify_agent, notify_creator, category_name)
     values ("Goods in Transit exceeds Broker limit", 5, "An application has been submitted with goods in transit coverage that requires Underwriter review.", 'GOODSINTRANSIT_UW', null, 1, 1, 'GOODS')^ 
execute procedure temp_create_view_activity_right('GOODSINTRANSIT_UW', 'AG')^
execute procedure temp_create_view_activity_right('GOODSINTRANSIT_UW', 'UW')^
execute procedure temp_create_view_activity_right('GOODSINTRANSIT_UW', 'UWSR')^
/*execute procedure temp_create_view_activity_right('GOODSINTRANSIT_UW', 'UWMGR')^*/
execute procedure temp_create_view_activity_right('GOODSINTRANSIT_UW', 'MGMTSR')^
execute procedure temp_create_edit_activity_right('GOODSINTRANSIT_UW', 'UW')^
execute procedure temp_create_edit_activity_right('GOODSINTRANSIT_UW', 'UWSR')^
execute procedure temp_create_edit_activity_right('GOODSINTRANSIT_UW', 'UWMGR')^
execute procedure temp_create_edit_activity_right('GOODSINTRANSIT_UW', 'MGMTSR')^


drop procedure temp_create_view_activity_right^
drop procedure temp_create_edit_activity_right^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("201119ML00", "RT-178 - inserting task activities for auth rule limits", "2020-NOV-19");