set term !;

update ref_table
   set ref_desc = '1st Interested Party'
 where ref_code = 'MORTINTTYP'
   and ref_key = 'MORT01'!
   
update ref_table
   set ref_desc = '2nd Interested Party'
 where ref_code = 'MORTINTTYP'
   and ref_key = 'MORT02'!
   
update ref_table
   set ref_desc = '3rd Interested Party'
 where ref_code = 'MORTINTTYP'
   and ref_key = 'MORT03'!

set term ;!

insert into applied_scripts (name, description, script_date)
     values ('201124jb01', 'BCSB-1262 Modify lien position description', '2020-NOV-24');