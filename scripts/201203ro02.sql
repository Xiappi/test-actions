set term ^;
 
create procedure tmp_add_category_master_links (
    in_category_code varchar(50),
    in_line_code     varchar(2))
as
    declare variable var_category_id integer;
    declare variable var_line_key    varchar(2);
    declare variable var_master_id   integer;
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
        /* check to see if this master record already exists */
        select rm.rule_master_id
          from rule_master rm
          join rule_categories rc on rm.rule_category_id = rc.rule_category_id
         where rm.line = :in_line_code
           and rc.rule_code = :in_category_code
          into :var_master_id;

        if (var_master_id is null) then
        begin
            select out_master_id
              from i_model_rule_master(:in_line_code, :var_category_id)
              into :var_master_id;
        end
    end
end^
 
create procedure tmp_add_source_detail (
    in_line_code     varchar(2),
    in_rule_code     varchar(30))
as
    declare variable var_category_id integer;
    declare variable var_master_id   integer;
    declare variable var_code_id     integer;
    declare variable var_detail_id   integer;
begin
    select csc.code_id
      from custom_source_code csc
     where csc.name = 'Prequal_RP_OP_SP'
       and csc.source_code_type_id = 1
      into :var_code_id;
 
    if (:var_code_id is null) then
    begin
      select out_code_id
        from i_model_custom_source_code('Prequal_RP_OP_SP', "Prequalifying warning", '', 1, 'TODAY', 'VALIDATE')
        into :var_code_id;
    end
     
    select rule_category_id
      from rule_categories
     where rule_code = :in_rule_code rows 1
      into :var_category_id;
 
    select rule_master_id
      from rule_master
     where line = :in_line_code 
       and rule_category_id = :var_category_id
      into :var_master_id;
 
    select out_detail_id
      from i_model_rule_details(:var_master_id, "{PREQUAL_WARNING}", :var_code_id, 1, 'TODAY')
      into :var_detail_id;
end^
 
execute procedure tmp_add_category_master_links('UNDERWRITING', 'RP')^
execute procedure tmp_add_category_master_links('UNDERWRITING', 'SP')^
execute procedure tmp_add_category_master_links('UNDERWRITING', 'OP')^
commit work^
 
execute procedure tmp_add_source_detail('RP', 'UNDERWRITING')^
execute procedure tmp_add_source_detail('SP', 'UNDERWRITING')^
execute procedure tmp_add_source_detail('OP', 'UNDERWRITING')^
commit work^

execute procedure tmp_add_category_master_links('UNDERWRITING_NOTIFY', 'RP')^
execute procedure tmp_add_category_master_links('UNDERWRITING_NOTIFY', 'SP')^
execute procedure tmp_add_category_master_links('UNDERWRITING_NOTIFY', 'OP')^
commit work^
 
execute procedure tmp_add_source_detail('RP', 'UNDERWRITING_NOTIFY')^
execute procedure tmp_add_source_detail('SP', 'UNDERWRITING_NOTIFY')^
execute procedure tmp_add_source_detail('OP', 'UNDERWRITING_NOTIFY')^
commit work^
 
drop procedure tmp_add_category_master_links^
drop procedure tmp_add_source_detail^
 
set term ;^
 
insert into applied_scripts (name, description, script_date)
values ('201203ro02', 'BCSB-1397', '2020-DEC-17');
 
COMMIT WORK;

