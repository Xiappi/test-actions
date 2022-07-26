set term ^;

update ref_group_master
    set user_right = 'INTERNCOV'
where group_description = 'Underwriter Only'^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("210713DC03", "MHM-218 update cov group to interncov", "2021-Jul-13");