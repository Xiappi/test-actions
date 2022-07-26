set term ^;

create procedure update_generator_id
as
    declare variable igeneratorid integer;
    declare variable itempvalue   integer;
begin
    /* Replace the field and table values with the ones required for your scenario */
    select max(rator_master_id)
      from rator_master
      into :igeneratorid;

    /* Replace the generator name with the one required for your scenario */
    itempvalue = gen_id(gen_rator_master_id, (:igeneratorid - gen_id(gen_rator_master_id, 0)));
end^

set term ;^

commit;

execute procedure update_generator_id;
drop procedure update_generator_id;

INSERT INTO applied_scripts(NAME, DESCRIPTION, SCRIPT_DATE)
VALUES ("201026jg02", "BCSB-935 - Fixing rating generator", "2020-OCT-26");

