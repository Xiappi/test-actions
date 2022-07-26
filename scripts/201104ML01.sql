set term ^;

create procedure tmp_remove_rule
as
    declare variable var_code_id   integer;
    declare variable var_detail_id integer;
    declare variable var_link_id   integer;
begin   
    select rmdl.id,
           rmdl.rule_detail_id,
           rd.code_id
      from rule_master_detail_link rmdl
      join rule_details rd on rd.rule_detail_id = rmdl.rule_detail_id
      join custom_source_code csc on csc.code_id = rd.code_id
     where rd.name = 'UnderwritingGlassOver250K'
      into  :var_link_id,
            :var_detail_id,
            :var_code_id;

    if(:var_link_id is not null) then
    begin
        delete from rule_master_detail_link
        where id = :var_link_id;
    end
    if(:var_detail_id is not null) then
    begin
        delete from rule_details
        where rule_detail_id = :var_detail_id;
    end
    if(:var_code_id is not null) then
    begin
        delete from custom_source_code
        where code_id = :var_code_id;
    end
end^

commit work^

execute procedure tmp_remove_rule^

commit work^

drop procedure tmp_remove_rule^

set term ;^

insert into applied_scripts (name, description, script_date)
     values ('201104ML01', 'BCSB-1059 - removed old unused auth rule if it exists', '2020-NOV-04');