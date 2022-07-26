set term ^;
 
create procedure temp_210824DC01(
  in_rule_name  varchar(100) character set none,
  in_rule_msg   varchar(255) character set none)
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
     where source_code_type = 'VALIDATE'
      into :var_source_code_type_id;
 
      var_code_id = gen_id(gen_custom_code_id, 1);
 
    insert into custom_source_code (code_id, name, description, source_code, source_code_type_id)
         values (:var_code_id, :in_rule_name, :in_rule_msg, '', :var_source_code_type_id);
 
    select rule_category_id 
      from rule_categories 
     where rule_code = 'VALIDATE_DWELLING_COV_ENTRY' 
      into :var_category_id;
 
    select max(book_id)
      from rate_book rb
     where rb.effective_date <= 'TODAY'
       and rb.expiry_date >= 'TODAY'
      into :var_book_id;
 
      var_detail_id = gen_id(gen_rule_detail_id, 1);
 
    insert into rule_details(rule_detail_id, code_id, fail_message, rule_active, effective_book_id, sequence)
        values (:var_detail_id, :var_code_id, :in_rule_msg, 1, :var_book_id, 0);
 
    insert into rule_master_detail_link (rule_detail_id, rule_category_id, line)
        values (:var_detail_id, :var_category_id, 'HX');
 
    suspend;
end^
 
execute procedure temp_210824DC01('DwellingReasonLookup', "Reasons is required for Discount/Load")^
 
drop procedure temp_210824DC01^
 
set term ;^

insert into applied_scripts (name, description, script_date)
     values ('210824DC01', 'MHM-734 add rules for dwelling discount/load', '2021-Aug-24');
