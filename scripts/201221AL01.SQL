set term !;

update REF_TABLE RT
set FARM_TYPE = VALLTRIM(FARM_TYPE) || "|AUTO|"
where REF_CODE = "CANC" and
      STATE = "XX" and
      LINE = "XX" and
      (REF_DESC like "%DUI%" or REF_DESC like "%Accident%" or REF_DESC like "%Speed%" or REF_DESC like "%Violation%" or REF_DESC like "%Driving%") !

      commit !

insert into APPLIED_SCRIPTS (NAME, DESCRIPTION, SCRIPT_DATE) values ("201221AL01", "BCSB-1422 set filter on auto cancel reasons", "12/21/2020") !

set term ;!

commit work;
