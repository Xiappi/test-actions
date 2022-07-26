set term ^;

create procedure tmp_insert_override
as
    declare variable var_rule_detail_id     integer;
    declare variable var_override_type_id   integer;
    declare variable var_security_right_id  integer;
begin
    select id
      from ais_security
     where right_key = 'AG' rows 1
      into :var_security_right_id;

    select rule_override_type_id
      from rule_override_type
     where name = 'SILENT' rows 1
      into :var_override_type_id;

    for select rule_detail_id
          from custom_source_code csc
          join rule_details rd on rd.code_id = csc.code_id
         where csc.name in ('AuthorizationLimitFireOP', 'AuthorizationLimitFireRP', 'AuthorizationLimitFireSP')
          into :var_rule_detail_id
    do 
    begin
        insert into rule_override_identity(rule_detail_id, security_id, rule_override_type_id)
             values (:var_rule_detail_id, :var_security_right_id, :var_override_type_id);
    end
end^

execute procedure tmp_insert_override^

commit work^

drop procedure tmp_insert_override^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("201127ML01", "RT-342 - override fire for brokers", "2020-NOV-27");