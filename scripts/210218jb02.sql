set term ^;

create procedure tmp_set_company_config
as
	declare variable var_cat_id      integer;
	declare variable var_config_id   integer;
	declare variable var_section_id  integer;
	declare variable var_value_id    integer;
begin
	select category_id
	  from company_config_category
	 where upper(description) like '%NEW BUSINESS%'
	  into :var_cat_id;
	  
	for select config_id
	      from company_config_master
		 where category_id = :var_cat_id
		   and line in ('RP', 'SP', 'OP')
		   and name = 'POLICYTERM'
		  into :var_config_id
	do
	begin
		select section_id
		  from company_config_sections
		 where config_id = :var_config_id
		   and name = 'SETTINGS'
		  into :var_section_id;
		  
		select value_id
		  from company_config_values
		 where section_id = :var_section_id
		   and config_key = 'SHORTTERM'
		  into :var_value_id;
		  
		execute procedure u_model_company_config_value(:var_value_id, :var_section_id, 'SHORTTERM', 'TRUE', 'LIST', 0, 0, 'FALSE', 'Allow user to set expiry date', '', '', null);
	end
end^

commit^

execute procedure tmp_set_company_config^

commit^

drop procedure tmp_set_company_config^

set term ;^

insert into applied_scripts (name, description, script_date)
     values ('210218jb02', 'BCSB-1676 Set config for expiry date', '2021-FEB-18');