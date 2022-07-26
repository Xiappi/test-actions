set term ^;

create procedure tmp_create_rule
as
    declare variable var_category_id   integer;
    declare variable var_master_id     integer;
    declare variable var_detail_id     integer;
    declare variable var_code_id       integer;
    declare variable var_auth_limit_id integer;
    declare variable var_activity_id   varchar(50);
begin
    select out_code_id
      from i_model_custom_source_code('RP', 'BusinessInterruption', 'Business Interruption Auto Included Coverage', '', 1, 'TODAY', 'AUTHORIZE')
      into :var_code_id;
    
    select rule_category_id
      from rule_categories
     where rule_code = 'VALIDATE_DWELLING_COV_ENTRY' rows 1
      into :var_category_id;

    select out_master_id
      from i_model_rule_master('RP', :var_category_id)
      into :var_master_id;
    
    select out_detail_id
      from i_model_rule_details(:var_master_id, 'BusinessInterruption', 'Business Interruption Auto Included Coverage', :var_code_id, 1, 'TODAY', 1, 1, 1, 0)
      into :var_detail_id;

    select out_master_id
      from i_model_rule_master('SP', :var_category_id)
      into :var_master_id;
    
    select out_detail_id
      from i_model_rule_details(:var_master_id, 'BusinessInterruption', 'Business Interruption Auto Included Coverage', :var_code_id, 1, 'TODAY', 1, 1, 1, 0)
      into :var_detail_id;
end^

execute procedure tmp_create_rule^

drop procedure tmp_create_rule^

set term ;^

insert into applied_scripts (name, description, script_date)
     values ('201008jg01', 'BCSB-188 - Creating soft rules for Business Interruption', '2020-Oct-08');