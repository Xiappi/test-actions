set term ^;

create procedure tmp_fix_bad_data
as
    declare variable var_master_id   integer;
    declare variable var_category_id integer;
    declare variable var_link_id   integer;
begin
    select rule_category_id
      from rule_categories
     where rule_code = 'UNDERWRITING'
      into :var_category_id;

    select rule_master_id
      from rule_master
     where rule_category_id = :var_category_id
       and line = 'RP'
      into :var_master_id;

    if(:var_master_id is null) then 
    begin
        var_master_id = gen_id(gen_rule_master_id,1);
        insert into rule_master(rule_master_id, line, rule_category_id)
        values(:var_master_id, 'RP', :var_category_id);
    end

    select id
      from rule_master_detail_link rmdl
      join rule_details rd on rd.rule_detail_id = rmdl.rule_detail_id
      join custom_source_code csc on csc.code_id = rd.code_id
     where csc.name = 'LocationAtLeastOne_ArgusMT'
       and rule_master_id is null
      into :var_link_id;

    update rule_master_detail_link
       set rule_master_id = :var_master_id
     where id = :var_link_id;
end^

execute procedure tmp_fix_bad_data^

commit work^

drop procedure tmp_fix_bad_data^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("201214ML03", "AIS-34513 - fix null data in rule_master_detail_link", "2021-JAN-12");