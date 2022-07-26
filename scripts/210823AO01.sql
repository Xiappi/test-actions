set term ^;

create procedure tmp_insert_submit_to_host_rule
as
    declare variable var_category_id         integer;
    declare variable var_code_id             integer;
    declare variable var_master_id           integer;
    declare variable var_detail_id           integer;
    declare variable var_source_code_type_id integer;
    declare variable var_status              integer;
    declare variable var_book_id             integer;    
begin
    select source_code_type_id
      from source_code_type
     where source_code_type = 'AUTOINCLUDE'
      into :var_source_code_type_id;
 
    var_code_id = gen_id(gen_custom_code_id, 1); 
    insert into custom_source_code (code_id, name, description, source_code, source_code_type_id)
         values (:var_code_id, 'AddCCTVDiscountAutoIncludeDwelling', 'Auto-include dwelling items cctv discount.', '', :var_source_code_type_id);
 
    select rule_category_id 
      from rule_categories 
     where rule_code = 'AUTOINCLUDE_DWELLING_RULES' 
      into :var_category_id;
 
    select max(book_id)
      from rate_book rb
     where rb.effective_date <= 'TODAY'
       and rb.expiry_date >= 'TODAY'
      into :var_book_id;
 
    var_detail_id = gen_id(gen_rule_detail_id, 1); 
    insert into rule_details(rule_detail_id, code_id, fail_message, rule_active, effective_book_id, sequence)
        values (:var_detail_id, :var_code_id, 'Auto-include dwelling items cctv discount.', 1, :var_book_id, 0);
 
    insert into rule_master_detail_link (rule_detail_id, rule_category_id, line)
        values (:var_detail_id, :var_category_id, 'HX');
end^

execute procedure tmp_insert_submit_to_host_rule^

commit work^

drop procedure tmp_insert_submit_to_host_rule^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("210823AO01", "MHM-729 - HX CCTV auto-include dwelling rule", "2021-AUG-23");
