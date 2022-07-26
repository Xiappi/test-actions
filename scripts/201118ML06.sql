set term ^;

create procedure tmp_clone_rules (
    from_line_code varchar(2),
    to_line_code   varchar(2),
    category_name  varchar(30))
as
    declare variable var_category_id    integer;

    declare variable var_from_master_id integer;
    declare variable var_to_master_id   integer;

    declare variable var_from_detail_id integer;
    declare variable var_to_detail_id   integer;
begin
    select rule_category_id
      from rule_categories
     where rule_code = :category_name rows 1
      into :var_category_id;

    select rule_master_id
      from rule_master
     where line = :from_line_code
       and rule_category_id = :var_category_id
      into :var_from_master_id;

    /* create rule_master entry for new line */
    var_to_master_id = gen_id(gen_rule_master_id, 1);
    insert into rule_master (rule_master_id, line, rule_category_id)
         values (:var_to_master_id, :to_line_code, :var_category_id);

    for select rule_detail_id
          from rule_master_detail_link
         where rule_master_id = :var_from_master_id
          into :var_from_detail_id
    do
    begin
        /* clone rule_detail */
        var_to_detail_id = gen_id(gen_rule_detail_id, 1);
        insert into rule_details (rule_detail_id, code_id, fail_message, rule_active, effective_book_id, expired_book_id, sequence)
        select :var_to_detail_id,
               code_id,
               fail_message,
               rule_active,
               effective_book_id,
               expired_book_id,
               sequence
          from rule_details
         where rule_detail_id = :var_from_detail_id;

         /* clone rule_detail link */
         insert into rule_master_detail_link (rule_master_id, rule_detail_id)
              values (:var_to_master_id, :var_to_detail_id);
    end
end^

commit work^

execute procedure tmp_clone_rules('RP', 'SP', 'AUTHORIZATION_LIMITS')^
execute procedure tmp_clone_rules('RP', 'SP', 'AUTHORIZATION_LIMITS_NOTIFY')^

execute procedure tmp_clone_rules('RP', 'OP', 'AUTHORIZATION_LIMITS')^
execute procedure tmp_clone_rules('RP', 'OP', 'AUTHORIZATION_LIMITS_NOTIFY')^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("201118ML06", "RT-178 - auth rule cleanup", "2020-NOV-18");