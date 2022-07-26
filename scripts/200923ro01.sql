set term ^ ;

create procedure temp_insert_value_200923ro01
as
    declare variable var_category_id          integer;
    declare variable var_config_master_id     integer;
    declare variable var_config_section_id    integer;
    declare variable var_config_value_id      integer;
    declare variable var_line                 varchar(255);
    declare variable var_config_value_list_id integer;
begin
    /* the Business Select line already has this configuration */
    for select distinct alltrim(ref_key)
          from ref_table
         where ref_code = 'LINE'
           and expired_date > 'NOW'
           and ref_key <> 'BC'
          into :var_line
    do
    begin
        var_category_id = null;
        var_config_master_id = null;
        var_config_section_id = null;
        var_config_value_id = null;
        var_config_value_list_id = null;
    
        select category_id
          from company_config_category
         where description = 'New Business and Renewals'
          into :var_category_id;
        
        if (var_category_id is null) then
        begin
            select out_id
              from i_model_company_config_category('New Business and Renewals')
              into :var_category_id;
        end
        
        select config_id
          from company_config_master
         where category_id = :var_category_id
           and name = 'ADDRESS'
           and line = :var_line
          into :var_config_master_id;
        
        if (var_config_master_id is null) then
        begin
            select out_id
              from i_model_company_config_master('ADDRESS', 'Policy Holder Address', 'Configure required fields for primary and secondary insured', :var_category_id, :var_line)
              into :var_config_master_id;
        end
        
        select section_id
          from company_config_sections
         where config_id = :var_config_master_id
           and name = 'PRIMARY'
          into :var_config_section_id;
        
        if (var_config_section_id is null) then
        begin
            select out_id
              from i_model_company_config_section(:var_config_master_id, 'PRIMARY', 'Primary insured', 'Configure fields to be required when entering a quote or application')
              into :var_config_section_id;
        end
        
        select out_id
          from i_model_company_config_value(:var_config_section_id, 'SININD', 'N', 'LIST', 0, 0, 'FALSE', 'SSN is required for (individuals/non-commercial)', '', '', null)
          into :var_config_value_id;
        
        select out_id
          from i_model_company_config_value_list(:var_config_value_id, 'Quote', 'Q')
          into :var_config_value_list_id;
        
        select out_id
          from i_model_company_config_value_list(:var_config_value_id, 'Application', 'A')
          into :var_config_value_list_id;
        
        select out_id
          from i_model_company_config_value_list(:var_config_value_id, 'None', 'N')
          into :var_config_value_list_id;
        
        select out_id
          from i_model_company_config_value(:var_config_section_id, 'SINBUS', 'N', 'LIST', 0, 0, 'N', 'SSN is required for (business/partnerships)', '', '', null)
          into :var_config_value_id;
        
        select out_id
          from i_model_company_config_value_list(:var_config_value_id, 'Quote', 'Q')
          into :var_config_value_list_id;
        
        select out_id
          from i_model_company_config_value_list(:var_config_value_id, 'Application', 'A')
          into :var_config_value_list_id;
        
        select out_id
          from i_model_company_config_value_list(:var_config_value_id, 'None', 'N')
          into :var_config_value_list_id;
    end
end^

commit^

execute procedure temp_insert_value_200923ro01^

commit^

drop procedure temp_insert_value_200923ro01^

commit^

set term ; ^

insert into applied_scripts (name, description, script_date)
     values ('200923ro01', 'BCSB-552 Add SSN required config for Indiv', '2020-September-23');
