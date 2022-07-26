set term ^;

create procedure tmp_add_source_detail (
    in_line_code     varchar(2))
as
    declare variable var_category_id      integer;
    declare variable var_code_id          integer;
    declare variable var_code_type_id     integer;
    declare variable var_detail_id        integer;
begin
    select csc.code_id
      from custom_source_code csc
     where csc.name = 'UnderwritingPropertyDamageAtLeastOne'
       and csc.source_code_type_id = 1
      into :var_code_id;

    select sct.source_code_type_id
      from source_code_type sct
      where sct.source_code_type = 'VALIDATE' rows 1
      into :var_code_type_id;

    if (:var_code_id is null) then
    begin
      select out_id
        from i_model_custom_source_code('UnderwritingPropertyDamageAtLeastOne', "Property Damage coverage must be added", '', :var_code_type_id)
        into :var_code_id;
    end
    
    select rule_category_id
      from rule_categories
     where rule_code = 'UNDERWRITING' rows 1
      into :var_category_id;

    select out_id
      from i_model_rule_detail(1, "Property Damage coverage must be added", :var_code_id)
      into :var_detail_id;

    insert into rule_master_detail_link(rule_detail_id, rule_category_id, line)
         values (:var_detail_id, :var_category_id, :in_line_code);
end^

execute procedure tmp_add_source_detail('RP')^
commit work^
execute procedure tmp_add_source_detail('SP')^
commit work^
execute procedure tmp_add_source_detail('OP')^
commit work^

drop procedure tmp_add_source_detail^

set term ;^

insert into applied_scripts (name, description, script_date)
values ('210222jb01', 'BCSB-1742 Add rule requiring property damage cov', '2021-FEB-22');

COMMIT WORK;
