set term ^;

create procedure tmp_insert_workflow_level_rules_link
as
    declare variable var_category_id       integer;
    declare variable var_workflow_level_id integer;
begin
    select rule_category_id
      from rule_categories
     where rule_code = 'AUTHORIZATION_LIMITS' rows 1
      into :var_category_id;

    select wl.workflow_level_id
      from workflow_master wm
      join workflow_levels wl on wl.workflow_id = wm.workflow_id
     where wm.name = 'QUOTE'
       and wl.workflow_level = 100 rows 1
      into :var_workflow_level_id;

    if (:var_category_id is not null and :var_workflow_level_id is not null) then
    begin
        insert into workflow_rules_link (workflow_level_id, rule_category_id, sequence)
             values (:var_workflow_level_id, :var_category_id, 0);
    end
end^

execute procedure tmp_insert_workflow_level_rules_link^

commit work^

drop procedure tmp_insert_workflow_level_rules_link^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("210128ML01", "BCSB-1603 - add auth rules to quoting workflow", "2021-JAN-28");