set term ^;

create procedure tmp_workflow_rules(in_rule_code varchar(50), in_level integer)
as
    declare variable var_rule_category_id  integer;
    declare variable var_workflow_level_id integer;
begin
    select rc.rule_category_id
      from rule_categories rc
     where rc.rule_code = :in_rule_code rows 1
      into :var_rule_category_id;

    for select wl.workflow_level_id
          from workflow_levels wl
          join workflow_master wm on wm.workflow_id = wl.workflow_id
          where wl.workflow_level = :in_level
          into var_workflow_level_id
    do
    begin
        insert into workflow_rules_link (workflow_level_id, rule_category_id)
             values (:var_workflow_level_id, :var_rule_category_id);
    end
end^

execute procedure tmp_workflow_rules('AUTHORIZATION_LIMITS', 100)^
execute procedure tmp_workflow_rules('AUTHORIZATION_LIMITS_NOTIFY', 200)^

commit work^

drop procedure tmp_workflow_rules^

set term ;^

insert into applied_scripts (name, description, script_date)
     values ('200918ML03', 'RT-161 - auth level for glass coverage', '2020-Sept-18');