set term ^;

update rule_details
   set rule_active = 0
 where name in ('AuthorizationLimitTheftFirstLoss', 'AuthorizationLimitTheftFirstLoss_Notify', 'AuthorizationLimitTheftFullLoss', 'AuthorizationLimitTheftFullLoss_Notify')^

set term ;^

insert into applied_scripts (name, description, script_date)
     values ('201108ML01', 'RT-305 - disabled theft rule', '2020-NOV-08');