set term ^;

create procedure tmp_insert_rule
as
    declare variable var_code_id            integer;
    declare variable var_detail_id          integer;
    declare variable var_category_id        integer;
    declare variable var_code_type_id       integer;
    declare variable var_book_id            integer;
begin
    select rule_category_id
      from rule_categories
     where rule_code = 'VALIDATE_LOCATION_ENTRY'
      rows 1
      into :var_category_id;

    select source_code_type_id
      from source_code_type
     where source_code_type = 'VALIDATE' 
      rows 1
      into :var_code_type_id;

    select max(book_id)
      from rate_book rb
     where rb.effective_date <= 'TODAY'
       and rb.expiry_date >= 'TODAY'
      rows 1
      into :var_book_id;

    var_code_id = gen_id(gen_custom_code_id, 1);
    insert into custom_source_code (code_id, name, description, source_code, source_code_type_id)
         values (:var_code_id, 'MapLocationLatLngToDwellingForLocation', 'Map Location LatLng to associated Property Damage.', '', :var_code_type_id);

    var_detail_id = gen_id(gen_rule_detail_id, 1);
    insert into rule_details (rule_detail_id, code_id, fail_message, rule_active, effective_book_id, expired_book_id, sequence)
         values (:var_detail_id, :var_code_id, 'Map Location LatLng to associated Property Damage.', 1, :var_book_id, null, 0);

    insert into rule_master_detail_link (rule_detail_id, rule_category_id, line)
         values (:var_detail_id, :var_category_id, 'HX');

    insert into rule_master_detail_link (rule_detail_id, rule_category_id, line)
         values (:var_detail_id, :var_category_id, 'RP');

    insert into rule_master_detail_link (rule_detail_id, rule_category_id, line)
         values (:var_detail_id, :var_category_id, 'SP');

    insert into rule_master_detail_link (rule_detail_id, rule_category_id, line)
         values (:var_detail_id, :var_category_id, 'OP');
end^

execute procedure tmp_insert_rule^

commit work^

drop procedure tmp_insert_rule^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("210902AO01", "MHM-869 - location map loc latlng to dwelling", "2021-SEP-02");