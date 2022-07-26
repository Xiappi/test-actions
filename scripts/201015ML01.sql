set term ^;

                      
create procedure tmp_insert_custom_source_code
as
    declare variable var_custom_source_code_id integer;
    declare variable var_rule_master_id        integer;
    declare variable var_rule_details_id       integer;
    declare variable var_source_code_type_id   integer;
    declare variable var_category_id           integer;
    declare variable var_line_key              varchar(2);
begin
    select source_code_type_id
      from source_code_type
     where source_code_type = 'VALIDATE' rows 1
      into :var_source_code_type_id;

    select rc.rule_category_id
      from rule_categories rc
     where rc.rule_code = 'TAXESFEES' rows 1
      into :var_category_id;

    var_custom_source_code_id = gen_id(gen_custom_code_id, 1);
    var_rule_details_id = gen_id(gen_rule_detail_id, 1);

    insert into custom_source_code (code_id, name, description, source_code, source_code_type_id)
         values (:var_custom_source_code_id, 'CalculatePolicyFee', 'Failed to calculate Policy Fee', '', :var_source_code_type_id);

    insert into rule_details (name, rule_detail_id, fail_message, code_id, rule_active, effective_book_id, expired_book_id, applies_to_applications, applies_to_changes, applies_to_renewals, applies_to_claims)
         values ('CalculatePolicyFee', :var_rule_details_id, 'Failed to calculate Policy Fee', :var_custom_source_code_id, 1, 1, 999999999, 1, 1, 1, 0);

    for select distinct line_key
          from sps_model_rating_states_and_lines_all(0)
          where line_key in ('RP', 'OP', 'SP')
          into :var_line_key
    do
    begin
        select out_master_id
          from i_model_rule_master(:var_line_key, :var_category_id)
          into :var_rule_master_id;

        insert into rule_master_detail_link (rule_master_id, rule_detail_id)
             values (:var_rule_master_id, :var_rule_details_id);
    end
end^

execute procedure tmp_insert_custom_source_code^

commit work^

drop procedure tmp_insert_custom_source_code^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("201015ML01", "BCSB-766 - taxes/fees custom source code", "2020-10-15");