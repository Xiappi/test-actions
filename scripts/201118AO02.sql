set term ^;

create procedure temp_autoincludes_master
as
    declare variable var_category_id         integer;
    declare variable var_code_id             integer;
    declare variable var_master_id           integer;
    declare variable var_detail_id           integer;
begin

    /* add new autoinclude rule in the AUTOINCLUDE category */
    select out_code_id
      from i_model_custom_source_code('RP', 'AddStandardCoveragePerLocationWithDwelling', 'Auto-include standard coverages on locations associated with dwellings', '', 1, 'TODAY', 'AUTOINCLUDE')
      into :var_code_id;

    /* get category id */
    select rule_category_id from rule_categories where rule_code = 'AUTOINCLUDE_DWELLING_RULES' into :var_category_id;

    /* create master entry that will link to this category */
    select out_master_id
      from i_model_rule_master('RP', :var_category_id)
      into :var_master_id;

    /* Add detail entry that links to new rule source code */
    select out_detail_id
      from i_model_rule_details(:var_master_id, 'AddStandardCoveragePerLocationWithDwelling', 'Auto-include standard coverages on locations associated with dwellings', :var_code_id, 1, 'TODAY', 1, 1, 1, 0)
      into :var_detail_id;

    /* create similar master entries and link them to the rule for other lines */
    select out_master_id
      from i_model_rule_master('SP', :var_category_id)
      into :var_master_id;

    insert into rule_master_detail_link (rule_master_id, rule_detail_id)
         values (:var_master_id, :var_detail_id);

    select out_master_id
      from i_model_rule_master('OP', :var_category_id)
      into :var_master_id;

    insert into rule_master_detail_link (rule_master_id, rule_detail_id)
         values (:var_master_id, :var_detail_id);

    /* get category id */
    select rule_category_id from rule_categories where rule_code = 'AUTOINCLUDE_ITEM_RULES' into :var_category_id;

    /* create master entries that will link to this category */
    select out_master_id
      from i_model_rule_master('RP', :var_category_id)
      into :var_master_id;
    select out_master_id
      from i_model_rule_master('SP', :var_category_id)
      into :var_master_id;
    select out_master_id
      from i_model_rule_master('OP', :var_category_id)
      into :var_master_id;

    suspend;
end^

execute procedure temp_autoincludes_master^

drop procedure temp_autoincludes_master^

set term ;^

insert into applied_scripts (name, description, script_date)
     values ('201118AO02', 'BCSB-1206 - auto-include rule for malta FC', '2020-NOV-18');