set term ^;

update status_defs
   set system_stamp = valltrim(system_stamp) || "|SUBMITTED"
 where statusdef_id in (17, 18) ^

commit ^

insert into applied_scripts (name, description, script_date)
    values ("200918jb01", "BCSB-535 Add submitted system_stamp", "2020-SEPT-18") ^
set term;^
commit work;