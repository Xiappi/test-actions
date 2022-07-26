set term ^;

create procedure tmp_remove_uw_authorization_limits (
    in_rule_name    varchar(100),
    in_line         varchar(2),
    in_security_key varchar(10))
as
    declare variable var_auth_limit_id integer;
    declare variable var_activity_id   integer;
    declare variable var_task_id       integer;
begin
    for select auth.auth_limit_id
          from rule_details rd
          join rule_master_detail_link link
                     on link.rule_detail_id = rd.rule_detail_id
          join rule_master rm
                     on rm.rule_master_id = link.rule_master_id
          join rule_authorization_limits_link auth_link
                     on auth_link.rule_detail_id = rd.rule_detail_id
          join rule_authorization_limits auth
                     on auth.auth_limit_id = auth_link.auth_limit_id
          join rule_authorization_limits_identity auth_id
                     on auth_id.auth_limit_id = auth.auth_limit_id
          join ais_security secure
                     on secure.id = auth_id.security_id
         where rm.line = :in_line
           and rd.name = :in_rule_name
           and secure.right_key = :in_security_key
          into :var_auth_limit_id
    do
    begin
        delete from rule_authorization_limits_identity auth_identity
         where auth_identity.auth_limit_id = :var_auth_limit_id;

        delete from rule_unauthorized_task_link auth_task
         where auth_task.auth_limit_id = :var_auth_limit_id;

        delete from rule_authorization_limits_link auth_rule
         where auth_rule.auth_limit_id = :var_auth_limit_id;

        delete from rule_authorization_limits auth
         where auth.auth_limit_id = :var_auth_limit_id;
    end

    for select ta.activity_id
          from task_activity ta
         where not exists(select 1
                            from rule_unauthorized_task_link tl
                           where tl.activity_id = ta.activity_id)
           and not exists(select 1
                            from rule_details_task_link rl
                           where rl.activity_id = ta.activity_id)
           and not exists(select 1
                            from workflow_level_task_link wl
                           where wl.activity_id = ta.activity_id)
           and ta.activity_name not in ('TASKMTC', 'TASKRENEW', 'TASKAPP')
          into :var_activity_id
    do
    begin
        delete from task_activity_groups_link gl
         where gl.activity_id = :var_activity_id;

        /* delete notes linked to task */
        for select tw.task_id
              from task_workqueue tw
             where activity_id = :var_activity_id
              into :var_task_id
        do
        begin
            delete from task_notes_link tnl
             where tnl.task_id = :var_task_id;
        end

        delete from task_workqueue tw
         where tw.activity_id = :var_activity_id;

        delete from task_activity_rights tr
         where tr.activity_id = :var_activity_id;

        delete from task_activity_rights_audit tra
         where tra.activity_id = :var_activity_id;

        delete from task_activity
         where activity_id = :var_activity_id;
    end
end^

create procedure tmp_update_uw_authorization_limits (
    in_rule_name    varchar(100),
    in_line         varchar(2),
    in_security_key varchar(10),
    from_limit      integer)
as
    declare variable var_auth_limit_id integer;
    declare variable var_activity_id   integer;
begin
    for select auth.auth_limit_id
          from rule_details rd
          join rule_master_detail_link link
                     on link.rule_detail_id = rd.rule_detail_id
          join rule_master rm
                     on rm.rule_master_id = link.rule_master_id
          join rule_authorization_limits_link auth_link
                     on auth_link.rule_detail_id = rd.rule_detail_id
          join rule_authorization_limits auth
                     on auth.auth_limit_id = auth_link.auth_limit_id
          join rule_authorization_limits_identity auth_id
                     on auth_id.auth_limit_id = auth.auth_limit_id
          join ais_security secure
                     on secure.id = auth_id.security_id
         where rm.line = :in_line
           and rd.name = :in_rule_name
           and secure.right_key = :in_security_key
          into :var_auth_limit_id
    do
    begin
        update rule_authorization_limits
           set from_limit = :from_limit
         where auth_limit_id = :var_auth_limit_id;
    end
end^

commit work^

execute procedure tmp_remove_uw_authorization_limits('AuthorizationLimitEmployersLiability', 'RP', 'UW')^
execute procedure tmp_remove_uw_authorization_limits('AuthorizationLimitEmployersLiability_Notify', 'RP', 'UW')^
execute procedure tmp_remove_uw_authorization_limits('AuthorizationLimitEmployersLiabilityAggregate', 'RP', 'UW')^
execute procedure tmp_remove_uw_authorization_limits('AuthorizationLimitEmployersLiabilityAggregate_Notify', 'RP', 'UW')^

execute procedure tmp_remove_uw_authorization_limits('AuthorizationLimitProductsLiability', 'RP', 'UW')^
execute procedure tmp_remove_uw_authorization_limits('AuthorizationLimitProductsLiability_Notify', 'RP', 'UW')^

execute procedure tmp_update_uw_authorization_limits('AuthorizationLimitPublicLiability', 'RP', 'UW', 500001)^
execute procedure tmp_update_uw_authorization_limits('AuthorizationLimitPublicLiability_Notify', 'RP', 'UW', 500001)^
update task_activity
   set task_title = 'Public Liability exceeds 500,000',
       task_message =  'An application has been submitted with public liability coverage over 500,000 that needs your review.'
 where activity_name = 'PUBLICLIABILITY_UW'^


commit work^

drop procedure tmp_remove_uw_authorization_limits^
drop procedure tmp_update_uw_authorization_limits^

set term ;^

insert into applied_scripts (name, description, script_date)
     values ('201113ML01', 'RT-310 - Modify broker authority for RP', '2020-NOV-13');