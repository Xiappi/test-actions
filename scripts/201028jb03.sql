set term ^ ;

create procedure temp_insert_value_201028jb03
as
    declare variable var_category_id          integer;
    declare variable var_config_master_id     integer;
    declare variable var_config_section_id    integer;
    declare variable var_config_value_id      integer;
    declare variable var_line                 varchar(255);
    declare variable var_config_value_list_id integer;
begin
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
           and name = 'LOCATION'
           and line = :var_line
          into :var_config_master_id;
        
        if (var_config_master_id is null) then
        begin
            select out_id
              from i_model_company_config_master('LOCATION', 'Locations', 'Configure location rules such as multi-state rating support', :var_category_id, :var_line)
              into :var_config_master_id;
        end
        
        select section_id
          from company_config_sections
         where config_id = :var_config_master_id
           and name = 'OTHER'
          into :var_config_section_id;
        
        if (var_config_section_id is null) then
        begin
            select out_id
              from i_model_company_config_section(:var_config_master_id, 'OTHER', 'Other locations', 'Configure other locations behavior')
              into :var_config_section_id;
        end
        
        select out_id
          from i_model_company_config_value(:var_config_section_id, 'STATETYPE', 'ALLSTATES', 'LIST', 0, 0, 'ALLSTATES', 'Set state/province selection', '', '', null)
          into :var_config_value_id;
        
        select out_id
          from i_model_company_config_value_list(:var_config_value_id, 'All licensed states or provinces', 'MULTISTATE')
          into :var_config_value_list_id;
        
        select out_id
          from i_model_company_config_value_list(:var_config_value_id, 'Policy state or province only', 'POLICYSTATE')
          into :var_config_value_list_id;
        
        select out_id
          from i_model_company_config_value_list(:var_config_value_id, 'All states or provinces', 'ALLSTATES')
          into :var_config_value_list_id;
    end
end^

commit^

execute procedure temp_insert_value_201028jb03^

commit^

drop procedure temp_insert_value_201028jb03^

commit^

set term ; ^

insert into applied_scripts (name, description, script_date)
     values ('201028jb03', 'BCSB-959 company config for oth locs', '2020-October-28');
