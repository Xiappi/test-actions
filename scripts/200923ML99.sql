set term ^;

update address
   set federal_id = upper(federal_id),
       addl_fedid = upper(addl_fedid)^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("200923ML99", "BCSB-585 uppercasing federal_id", "09/23/2020");