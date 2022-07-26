set term ^;

create procedure temp_add_ais_right (
    in_module_name  varchar(20) character set none,
    in_right_key    varchar(10) character set none,
    in_description  varchar(255) character set none)
as
  declare variable var_module_id    integer;
  declare variable var_right_id     integer;
begin
    var_right_id = gen_id(ais_security_gen, 1);

    select asm.id
        from ais_security_modules asm
    where asm.module = :in_module_name
        into :var_module_id;

    insert into ais_security (module_id, id, right_key, description)
       values (:var_module_id, :var_right_id, :in_right_key, :in_description);

end^

commit^

execute procedure temp_add_ais_right('UNDERWRITE', 'INTERNCOV', 'Company Internal Coverage')^

commit^

drop procedure temp_add_ais_right^

set term ;^

insert into applied_scripts (name, description, script_date)
     values ('210713DC01', 'MHM-218 add new ais right', '2021-Jul-13');