set term ^;

create procedure tmp_add_category_master_links (
    in_category_code varchar(50),
    in_line_code     varchar(2))
as
    declare variable var_category_id integer;
    declare variable var_line_key varchar(2);
    declare variable var_master_id integer;
begin
    select rule_category_id
      from rule_categories
     where rule_code = :in_category_code
      into :var_category_id;

    /* insert for all lines if no line was specified */
    if (:in_line_code is null) then
    begin
        for select distinct line_key
              from sps_model_rating_states_and_lines_all(0)
              into :var_line_key
        do
        begin
            select out_master_id
              from i_model_rule_master(:var_line_key, :var_category_id)
              into :var_master_id;
        end
    end
    else
    begin
        select out_master_id
          from i_model_rule_master(:in_line_code, :var_category_id)
          into :var_master_id;
    end
end^

create procedure tmp_add_source_detail (
    in_line_code     varchar(2))
as
    declare variable var_category_id integer;
    declare variable var_master_id   integer;
    declare variable var_code_id     integer;
    declare variable var_detail_id   integer;
begin
    select csc.code_id
      from custom_source_code csc
     where csc.name = 'DwellingOnLocationSMELines'
       and csc.source_code_type_id = 1
      into :var_code_id;

    if (:var_code_id is null) then
    begin
      select out_code_id
        from i_model_custom_source_code('XX', 'DwellingOnLocationSMELines', "Property Damage is already covered at this Location. Please choose a new Location.", '', 1, 'TODAY', 'VALIDATE')
        into :var_code_id;
    end
    
    select rule_category_id
      from rule_categories
     where rule_code = 'VALIDATE_DWELLING_CHAR_ENTRY' rows 1
      into :var_category_id;

    select rule_master_id
      from rule_master
     where line = :in_line_code 
       and rule_category_id = :var_category_id
      into :var_master_id;

    select out_detail_id
      from i_model_rule_details(:var_master_id, 'DwellingOnLocationSMELines', "Property Damage is already covered at this Location. Please choose a new Location.", :var_code_id, 1, 'TODAY', 1, 1, 1, 0)
      into :var_detail_id;
end^

execute procedure tmp_add_category_master_links('VALIDATE_DWELLING_CHAR_ENTRY', 'RP')^
execute procedure tmp_add_category_master_links('VALIDATE_DWELLING_CHAR_ENTRY', 'OP')^
execute procedure tmp_add_category_master_links('VALIDATE_DWELLING_CHAR_ENTRY', 'SP')^
commit work^

execute procedure tmp_add_source_detail('RP')^
execute procedure tmp_add_source_detail('OP')^
execute procedure tmp_add_source_detail('SP')^
commit work^

drop procedure tmp_add_category_master_links^
drop procedure tmp_add_source_detail^

set term ;^

insert into applied_scripts (name, description, script_date)
values ('201116ro01', 'BCSB-1132-add dwelling location SME lines rule', '2020-NOV-16');

COMMIT WORK;