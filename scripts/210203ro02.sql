set term ^;

/* Add DEFAULT filter to non-ACH. This will link them
   to the ref_billing.billing_method_filter field */
update ref_table
set farm_type = "|DEFAULT|"
where ref_code = "BILL"
  and farm_type = ""^

/* fix the piping on the ACH filter */
update ref_billing
set billing_method_filter = "|ACH|DEFAULT|"^

update ref_table
set farm_type = "|EXPORT|ACH|SHED|"
where ref_code = "BILL"
  and farm_type like "%ACH%"^

commit work^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("210203ro02", "FUE-511 update billing filters (ArgusMT)", "2021-FEB-03");
