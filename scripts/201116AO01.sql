set term ^;

create procedure tmp_create_rule_ao
as
    declare variable var_category_id   integer;
    declare variable var_master_id     integer;
    declare variable var_detail_id     integer;
    declare variable var_code_id       integer;
    declare variable var_auth_limit_id integer;
    declare variable var_activity_id   varchar(50);
begin
    select out_code_id
      from i_model_custom_source_code('RP', 'UniqueStandardCoveragePerLocation', 'Duplicate coverage {coverage} on location {location}', '', 1, 'TODAY', 'VALIDATE')
      into :var_code_id;
    
    select rule_category_id
      from rule_categories
     where rule_code = 'VALIDATE_ITEM_ENTRY' rows 1
      into :var_category_id;

    select out_master_id
      from i_model_rule_master('RP', :var_category_id)
      into :var_master_id;
    
    select out_detail_id
      from i_model_rule_details(:var_master_id, 'UniqueStandardCoveragePerLocation', 'Duplicate coverage {coverage} on location {location}', :var_code_id, 1, 'TODAY', 1, 1, 1, 0)
      into :var_detail_id;

    select out_master_id
      from i_model_rule_master('SP', :var_category_id)
      into :var_master_id;
    
    select out_detail_id
      from i_model_rule_details(:var_master_id, 'UniqueStandardCoveragePerLocation', 'Duplicate coverage {coverage} on location {location}', :var_code_id, 1, 'TODAY', 1, 1, 1, 0)
      into :var_detail_id;

      select out_master_id
      from i_model_rule_master('OP', :var_category_id)
      into :var_master_id;
    
    select out_detail_id
      from i_model_rule_details(:var_master_id, 'UniqueStandardCoveragePerLocation', 'Duplicate coverage {coverage} on location {location}', :var_code_id, 1, 'TODAY', 1, 1, 1, 0)
      into :var_detail_id;
end^

execute procedure tmp_create_rule_ao^

drop procedure tmp_create_rule_ao^

set term ;^

insert into applied_scripts (name, description, script_date)
     values ('201116AO01', 'BCSB-1135 - soft rule for duplicate FC on locations', '2020-NOV-16');