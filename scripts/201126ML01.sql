set term ^;

create procedure tmp_change_source_code
as
    declare variable var_code_id        integer;
    declare variable var_rule_detail_id integer;
begin
    select out_code_id
      from i_model_custom_source_code('AuthorizationLimitMachineryUngrouped', 'Machinery Breakdown - Electronic Equipment exceeds authorized limit', '', 1, 'TODAY', 'AUTHORIZE')
      into :var_code_id;

    for select rd.rule_detail_id
          from rule_details rd
          join custom_source_code csc on csc.code_id = rd.code_id
          join rule_master_detail_link rmdl on rmdl.rule_detail_id = rd.rule_detail_id
          join rule_master rm on rm.rule_master_id = rmdl.rule_master_id
         where csc.name = 'AuthorizationLimitMachinery'
           and rm.line = 'SP'
          into :var_rule_detail_id
    do
    begin
        update rule_details
           set code_id = :var_code_id
         where rule_detail_id = :var_rule_detail_id;
    end
end^

execute procedure tmp_change_source_code^

commit work^

drop procedure tmp_change_source_code^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("201126ML01", "RT-341 - machinery all instances for SP", "2020-NOV-26");