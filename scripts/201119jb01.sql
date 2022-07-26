set term ^;

create procedure temp_location_201119
as
    declare variable var_category_id         integer;
    declare variable var_code_id             integer;
    declare variable var_master_id           integer;
    declare variable var_detail_id           integer;
begin
    /* add new at least one location rule */
    select out_code_id
      from i_model_custom_source_code('XX', 'LocationAtLeastOne', 'There must be at least one location', '', 1, 'TODAY', 'VALIDATE')
      into :var_code_id;

    /* get category id */
    select rule_category_id
	  from rule_categories
	 where rule_code = 'UNDERWRITING'
	  into :var_category_id;

    /* get master entry that will link to this category */
    select rule_master_id
	  from rule_master
	 where line = 'RP'
	   and rule_category_id = :var_category_id
	  into :var_master_id;

    /* Add detail entry that links to new rule source code */
    select out_detail_id
      from i_model_rule_details(:var_master_id, 'There must be at least one location', :var_code_id, 1, 'TODAY')
      into :var_detail_id;

    /* get master entries and link them to the rule for SP */
	if (exists (select rule_master_id
				  from rule_master
				 where line = 'SP'
				   and rule_category_id = :var_category_id)) then
	begin
		select rule_master_id
		  from rule_master
		 where line = 'SP'
		   and rule_category_id = :var_category_id
		  into :var_master_id;
	end
	else
	begin
		select out_master_id
          from i_model_rule_master('SP', :var_category_id)
          into :var_master_id;
	end
    
	insert into rule_master_detail_link (rule_master_id, rule_detail_id)
         values (:var_master_id, :var_detail_id);

	/* get master entries and link them to the rule for OP */
    if (exists (select rule_master_id
				  from rule_master
				 where line = 'OP'
				   and rule_category_id = :var_category_id)) then
	begin
		select rule_master_id
		  from rule_master
		 where line = 'OP'
		   and rule_category_id = :var_category_id
		  into :var_master_id;
	end
	else
	begin
		select out_master_id
          from i_model_rule_master('OP', :var_category_id)
          into :var_master_id;
	end

    insert into rule_master_detail_link (rule_master_id, rule_detail_id)
         values (:var_master_id, :var_detail_id);
		 
	/* get master entries and link them to the rule for BC */
	if (exists (select rule_master_id
				  from rule_master
				 where line = 'BC'
				   and rule_category_id = :var_category_id)) then
	begin
		select rule_master_id
		  from rule_master
		 where line = 'BC'
		   and rule_category_id = :var_category_id
		  into :var_master_id;
	end
	else
	begin
		select out_master_id
          from i_model_rule_master('BC', :var_category_id)
          into :var_master_id;
	end

    insert into rule_master_detail_link (rule_master_id, rule_detail_id)
         values (:var_master_id, :var_detail_id);

    suspend;
end^

execute procedure temp_location_201119^

drop procedure temp_location_201119^

set term ;^

insert into applied_scripts (name, description, script_date)
     values ('201119jb01', 'BCSB-946 add at least one location rule', '2020-NOV-19');