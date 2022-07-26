SET TERM ^;

create procedure temp_disable_allow_print_config
as
    declare variable var_config_id  integer;
    declare variable var_section_id integer;
begin
    for select config_id
          from company_config_master
         where name = 'AGENT'
           and line in ('OP', 'RP', 'SP')
          into :var_config_id
    do
    begin
        for select section_id
              from company_config_sections
             where config_id = :var_config_id
              into :var_section_id
        do
        begin
            update company_config_values
               set config_value = 'FALSE'
             where config_key = 'ALLOWPRINT'
               and section_id = :var_section_id;
        end
    end
end^

COMMIT^

execute procedure temp_disable_allow_print_config^

COMMIT^

drop procedure temp_disable_allow_print_config^

COMMIT^

INSERT INTO applied_scripts(NAME, DESCRIPTION, SCRIPT_DATE)
    VALUES ("210118DM02", "BCSB-1327 Disable print button for SME lines", "2021-JAN-18")^

SET TERM ;^

