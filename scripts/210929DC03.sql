set term ^;

create procedure tmp_insert_override
as
    declare variable var_rule_detail_id    integer;
    declare variable var_override_type_id  integer;
    declare variable var_security_right_id integer;
    declare variable var_task_activity_id  integer;
begin
    select rule_override_type_id
      from rule_override_type
     where name = 'NOTICE' rows 1
      into :var_override_type_id;

    select activity_id
      from task_activity
     where activity_name = "TASKAPP"
      into :var_task_activity_id;

    for select rule_detail_id
          from custom_source_code csc
          join rule_details rd on rd.code_id = csc.code_id
          join rule_master_detail_link rmdl on rd.rule_detail_id = rmdl.rule_detail_id
          join rule_categories rc on rc.rule_category_id = rmdl.rule_category_id
         where csc.name in ('Prequal_CV', 'Prequal_MF', 'Prequal_MY', 'Prequal_HR', 'Prequal_PC')
           and rc.rule_code = "UNDERWRITING"
          into :var_rule_detail_id
    do
    begin
        select id
          from ais_security
         where right_key = 'UW' rows 1
          into :var_security_right_id;

        insert into rule_override_identity (
                     rule_detail_id, security_id, rule_override_type_id)
             values (:var_rule_detail_id, :var_security_right_id, :var_override_type_id);

        select id
          from ais_security
         where right_key = 'UWSR' rows 1
          into :var_security_right_id;

        insert into rule_override_identity (
                     rule_detail_id, security_id, rule_override_type_id)
             values (:var_rule_detail_id, :var_security_right_id, :var_override_type_id);

        select id
          from ais_security
         where right_key = 'UWMGR' rows 1
          into :var_security_right_id;

        insert into rule_override_identity (
                     rule_detail_id, security_id, rule_override_type_id)
             values (:var_rule_detail_id, :var_security_right_id, :var_override_type_id);

        select id
          from ais_security
         where right_key = 'MGMTSR' rows 1
          into :var_security_right_id;

        insert into rule_override_identity (
                     rule_detail_id, security_id, rule_override_type_id)
             values (:var_rule_detail_id, :var_security_right_id, :var_override_type_id);

    end
end^

create procedure tmp_insert_override_notify
as
    declare variable var_rule_detail_id    integer;
    declare variable var_override_type_id  integer;
    declare variable var_security_right_id integer;
    declare variable var_task_activity_id  integer;
begin
    select rule_override_type_id
      from rule_override_type
     where name = 'NOTICE' rows 1
      into :var_override_type_id;

    select activity_id
      from task_activity
     where activity_name = "TASKAPP"
      into :var_task_activity_id;

    for select rule_detail_id
          from custom_source_code csc
          join rule_details rd on rd.code_id = csc.code_id
          join rule_master_detail_link rmdl on rd.rule_detail_id = rmdl.rule_detail_id
          join rule_categories rc on rc.rule_category_id = rmdl.rule_category_id
         where csc.name in ('Prequal_CV', 'Prequal_MF', 'Prequal_MY', 'Prequal_HR', 'Prequal_PC')
           and rc.rule_code = "UNDERWRITING_NOTIFY"
          into :var_rule_detail_id
    do
    begin
        select id
          from ais_security
         where right_key = 'UW' rows 1
          into :var_security_right_id;

        insert into rule_override_identity (
                     rule_detail_id, security_id, rule_override_type_id)
             values (:var_rule_detail_id, :var_security_right_id, :var_override_type_id);

        select id
          from ais_security
         where right_key = 'UWSR' rows 1
          into :var_security_right_id;

        insert into rule_override_identity (
                     rule_detail_id, security_id, rule_override_type_id)
             values (:var_rule_detail_id, :var_security_right_id, :var_override_type_id);

        select id
          from ais_security
         where right_key = 'UWMGR' rows 1
          into :var_security_right_id;

        insert into rule_override_identity (
                     rule_detail_id, security_id, rule_override_type_id)
             values (:var_rule_detail_id, :var_security_right_id, :var_override_type_id);

        select id
          from ais_security
         where right_key = 'MGMTSR' rows 1
          into :var_security_right_id;

        insert into rule_override_identity (
                     rule_detail_id, security_id, rule_override_type_id)
             values (:var_rule_detail_id, :var_security_right_id, :var_override_type_id);

        insert into rule_details_task_link (
                     rule_detail_id, activity_id)
             values (:var_rule_detail_id, :var_task_activity_id);
    end
end^

execute procedure tmp_insert_override^

commit work^

drop procedure tmp_insert_override^

execute procedure tmp_insert_override_notify^

commit work^

drop procedure tmp_insert_override_notify^

set term ;^

insert into applied_scripts (name, description, script_date)
     values ('210929DC03', 'MHM-151 override motor prequal for UW', '2021-Sep-29');

