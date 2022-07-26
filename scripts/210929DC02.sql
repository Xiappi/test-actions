set term ^;
 
create procedure temp_add_custom_rule_without_notify(
  in_rule_name  varchar(100) character set none,
  in_rule_msg   varchar(255) character set none,
  in_rule_code  varchar(30) character set none,
  in_line       varchar(2) character set none)
as
    declare variable var_category_id         integer;
    declare variable var_code_id             integer;
    declare variable var_detail_id           integer;
    declare variable var_source_code_type_id integer;
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
     where rule_code = :in_rule_code 
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
        values (:var_detail_id, :var_category_id, :in_line);
 
    suspend;
end^

create procedure temp_add_custom_rule_with_notify(
  in_rule_name  varchar(100) character set none,
  in_rule_msg   varchar(255) character set none,
  in_rule_code  varchar(30) character set none,
  in_line       varchar(2) character set none)
as
    declare variable var_category_id         integer;
    declare variable var_code_id             integer;
    declare variable var_detail_id           integer;
    declare variable var_book_id             integer;    
begin
 
    select csc.code_id
      from custom_source_code csc
     where csc.name = :in_rule_name
      into :var_code_id;
 
    select rule_category_id 
      from rule_categories 
     where rule_code = :in_rule_code 
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
        values (:var_detail_id, :var_category_id, :in_line);
 
    suspend;
end^
 
execute procedure temp_add_custom_rule_without_notify('Prequal_CV', "{PREQUAL_WARNING}", "UNDERWRITING", "CV")^
execute procedure temp_add_custom_rule_with_notify('Prequal_CV', "{PREQUAL_WARNING}", "UNDERWRITING_NOTIFY", "CV")^

execute procedure temp_add_custom_rule_without_notify('Prequal_MF', "{PREQUAL_WARNING}", "UNDERWRITING", "MF")^
execute procedure temp_add_custom_rule_with_notify('Prequal_MF', "{PREQUAL_WARNING}", "UNDERWRITING_NOTIFY", "MF")^

execute procedure temp_add_custom_rule_without_notify('Prequal_MY', "{PREQUAL_WARNING}", "UNDERWRITING", "MY")^
execute procedure temp_add_custom_rule_with_notify('Prequal_MY', "{PREQUAL_WARNING}", "UNDERWRITING_NOTIFY", "MY")^

execute procedure temp_add_custom_rule_without_notify('Prequal_HR', "{PREQUAL_WARNING}", "UNDERWRITING", "HR")^
execute procedure temp_add_custom_rule_with_notify('Prequal_HR', "{PREQUAL_WARNING}", "UNDERWRITING_NOTIFY", "HR")^

execute procedure temp_add_custom_rule_without_notify('Prequal_PC', "{PREQUAL_WARNING}", "UNDERWRITING", "PC")^
execute procedure temp_add_custom_rule_with_notify('Prequal_PC', "{PREQUAL_WARNING}", "UNDERWRITING_NOTIFY", "PC")^
 
drop procedure temp_add_custom_rule_without_notify^
drop procedure temp_add_custom_rule_with_notify^
 
set term ;^

insert into applied_scripts (name, description, script_date)
     values ('210929DC3', 'MHM-151 add rule for motor prequal', '2021-Sep-29');
