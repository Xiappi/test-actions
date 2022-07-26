set term ^;

create procedure tmp_insert_auth_limit (
    line_code        varchar(2),
    code_name        varchar(100),
    from_limit       integer,
    to_limit         integer,
    notify_task_name varchar(50),
    security_key1    varchar(10),
    security_key2    varchar(10),
    security_key3    varchar(10),
    security_key4    varchar(10))
as
    declare variable var_auth_limit_id integer;
    declare variable var_detail_id     integer;
    declare variable var_security_id   integer;
    declare variable var_activity_id   integer;
begin
    for select rd.rule_detail_id
          from rule_categories rc
          join rule_master rm
                     on rm.rule_category_id = rc.rule_category_id
          join rule_master_detail_link rmdl
                     on rmdl.rule_master_id = rm.rule_master_id
          join rule_details rd
                     on rd.rule_detail_id = rmdl.rule_detail_id
          join custom_source_code csc
                     on csc.code_id = rd.code_id
         where (   (rc.rule_code = 'AUTHORIZATION_LIMITS' and :notify_task_name is null) 
                or (rc.rule_code = 'AUTHORIZATION_LIMITS_NOTIFY' and :notify_task_name is not null))
           and csc.name = :code_name
           and rm.line = :line_code
          into :var_detail_id
    do
    begin
        var_auth_limit_id = gen_id(gen_auth_limit_id, 1);

        insert into rule_authorization_limits (auth_limit_id, from_limit, to_limit)
             values (:var_auth_limit_id, :from_limit, :to_limit);

        insert into rule_authorization_limits_link (rule_detail_id, auth_limit_id)
             values (:var_detail_id, :var_auth_limit_id);

        select id
          from ais_security
         where right_key = :security_key1 rows 1
          into :var_security_id;

        insert into rule_authorization_limits_identity (auth_limit_id, security_id)
             values (:var_auth_limit_id, :var_security_id);

        if (:security_key2 is not null) then
        begin
            select id
              from ais_security
             where right_key = :security_key2 rows 1
              into :var_security_id;

            insert into rule_authorization_limits_identity (auth_limit_id, security_id)
                 values (:var_auth_limit_id, :var_security_id);
        end

        if (:security_key3 is not null) then
        begin
            select id
              from ais_security
             where right_key = :security_key3 rows 1
              into :var_security_id;

            insert into rule_authorization_limits_identity (auth_limit_id, security_id)
                 values (:var_auth_limit_id, :var_security_id);
        end

        if (:security_key4 is not null) then
        begin
            select id
              from ais_security
             where right_key = :security_key4 rows 1
              into :var_security_id;

            insert into rule_authorization_limits_identity (auth_limit_id, security_id)
                 values (:var_auth_limit_id, :var_security_id);
        end

        if (:notify_task_name is not null) then
        begin
            select activity_id
              from task_activity
             where activity_name = :notify_task_name
              into :var_activity_id;

            insert into rule_unauthorized_task_link (auth_limit_id, activity_id)
                 values (:var_auth_limit_id, :var_activity_id);
        end
    end
end^

execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitGlass', 2001, 25000, 'GLASS_UW', 'UW', 'UWSR', 'UWMGR', 'MGMTSR')^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitGlass', 2001, 25000, null, 'UW', 'UWSR', 'UWMGR', 'MGMTSR')^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitGlass', 25001, 175000, 'GLASS_UWSR', 'UWSR', 'UWMGR', 'MGMTSR', null)^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitGlass', 25001, 175000, null, 'UWSR', 'UWMGR', 'MGMTSR', null)^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitGlass', 175001, 250000, 'GLASS_MGMTSR', 'MGMTSR', null, null, null)^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitGlass', 175001, 250000, null, 'MGMTSR', null, null, null)^


execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitEmployersLiability', 2500001, 5000000, 'EMPLOYERLIABILITY_MGMTSR', 'MGMTSR', null, null, null)^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitEmployersLiability', 2500001, 5000000, null, 'MGMTSR', null, null, null)^

execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitEmployersLiabilityAggregate', 5000001, 10000000, 'EMPLOYERLIABILITYAGGREGATE_MGMTSR', 'MGMTSR', null, null, null)^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitEmployersLiabilityAggregate', 5000001, 10000000, null, 'MGMTSR', null, null, null)^


execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitPublicLiability', 500001, 2000000, 'PUBLICLIABILITY_UW', 'UW', 'UWSR', 'UWMGR', 'MGMTSR')^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitPublicLiability', 500001, 2000000, null, 'UW', 'UWSR', 'UWMGR', 'MGMTSR')^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitPublicLiability', 2000001, 2500000, 'PUBLICLIABILITY_UWSR', 'UWSR', 'UWMGR', 'MGMTSR', null)^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitPublicLiability', 2000001, 2500000, null, 'UWSR', 'UWMGR', 'MGMTSR', null)^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitPublicLiability', 2500001, 3000000, 'PUBLICLIABILITY_UWMGR', 'UWMGR', 'MGMTSR', null, null)^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitPublicLiability', 2500001, 3000000, null, 'UWMGR', 'MGMTSR', null, null)^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitPublicLiability', 3000001, 5000000, 'PUBLICLIABILITY_MGMTSR', 'MGMTSR', null, null, null)^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitPublicLiability', 3000001, 5000000, null, 'MGMTSR', null, null, null)^


execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitMoneyLockedSafe', 2501, 25000, 'MONEYLOCKEDSAFE_UW', 'UW', 'UWSR', 'UWMGR', 'MGMTSR')^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitMoneyLockedSafe', 2501, 25000, null, 'UW', 'UWSR', 'UWMGR', 'MGMTSR')^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitMoneyLockedSafe', 25001, 250000, 'MONEYLOCKEDSAFE_MGMTSR', 'MGMTSR', null, null, null)^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitMoneyLockedSafe', 25001, 250000, null, 'MGMTSR', null, null, null)^


execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitMoneyInTransit', 2501, 50000, 'MONEYINTRANSIT_UW', 'UW', 'UWSR', 'UWMGR', 'MGMTSR')^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitMoneyInTransit', 2501, 50000, null, 'UW', 'UWSR', 'UWMGR', 'MGMTSR')^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitMoneyInTransit', 50001, 75000, 'MONEYINTRANSIT_UWMGR', 'UWMGR', 'MGMTSR', null, null)^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitMoneyInTransit', 50001, 75000, null, 'UWMGR', 'MGMTSR', null, null)^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitMoneyInTransit', 75001, 250000, 'MONEYINTRANSIT_MGMTSR', 'MGMTSR', null, null, null)^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitMoneyInTransit', 75001, 250000, null, 'MGMTSR', null, null, null)^


execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitGoodsInTransit', 1501, 10000, 'GOODSINTRANSIT_UW', 'UW', 'UWSR', 'UWMGR', 'MGMTSR')^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitGoodsInTransit', 1501, 10000, null, 'UW', 'UWSR', 'UWMGR', 'MGMTSR')^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitGoodsInTransit', 10001, 25000, 'GOODSINTRANSIT_UWSR', 'UWSR', 'UWMGR', 'MGMTSR', null)^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitGoodsInTransit', 10001, 25000, null, 'UWSR', 'UWMGR', 'MGMTSR', null)^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitGoodsInTransit', 25001, 587000, 'GOODSINTRANSIT_MGMTSR', 'MGMTSR', null, null, null)^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitGoodsInTransit', 25001, 587000, null, 'MGMTSR', null, null, null)^


execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitDeteriorationOfStock', 1001, 25000, 'DETERIORATIONOFSTOCK_UW', 'UW', 'UWSR', 'UWMGR', 'MGMTSR')^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitDeteriorationOfStock', 1001, 25000, null, 'UW', 'UWSR', 'UWMGR', 'MGMTSR')^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitDeteriorationOfStock', 25001, 40000, 'DETERIORATIONOFSTOCK_UWSR', 'UWSR', 'UWMGR', 'MGMTSR', null)^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitDeteriorationOfStock', 25001, 40000, null, 'UWSR', 'UWMGR', 'MGMTSR', null)^


execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitMachinery', 2501, 250000, 'MACHINERY_UW', 'UW', 'UWSR', 'UWMGR', 'MGMTSR')^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitMachinery', 2501, 250000, null, 'UW', 'UWSR', 'UWMGR', 'MGMTSR')^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitMachinery', 250001, 5000000, 'MACHINERY_UWSR', 'UWSR', 'UWMGR', 'MGMTSR', null)^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitMachinery', 250001, 5000000, null, 'UWSR', 'UWMGR', 'MGMTSR', null)^


execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitTerrorism', 1, 500000, 'TERRORISM_MGMTSR', 'MGMTSR', null, null, null)^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitTerrorism', 1, 500000, null, 'MGMTSR', null, null, null)^


execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitPersonalAccident', 1, 500000, 'PERSONALACCIDENT_UW', 'UW', 'UWSR', 'UWMGR', 'MGMTSR')^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitPersonalAccident', 1, 500000, null, 'UW', 'UWSR', 'UWMGR', 'MGMTSR')^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitPersonalAccident', 500001, 1175000, 'PERSONALACCIDENT_UWSR', 'UWSR', 'UWMGR', 'MGMTSR', null)^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitPersonalAccident', 500001, 1175000, null, 'UWSR', 'UWMGR', 'MGMTSR', null)^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitPersonalAccident', 1175001, 2500000, 'PERSONALACCIDENT_MGMTSR', 'MGMTSR', null, null, null)^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitPersonalAccident', 1175001, 2500000, null, 'MGMTSR', null, null, null)^


execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitAllRisks', 1, 50000, 'ALLRISKS_UW', 'UW', 'UWSR', 'UWMGR', 'MGMTSR')^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitAllRisks', 1, 50000, null, 'UW', 'UWSR', 'UWMGR', 'MGMTSR')^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitAllRisks', 50001, 250000, 'ALLRISKS_UWSR', 'UWSR', 'UWMGR', 'MGMTSR', null)^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitAllRisks', 50001, 250000, null, 'UWSR', 'UWMGR', 'MGMTSR', null)^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitAllRisks', 250001, 1250000, 'ALLRISKS_MGMTSR', 'MGMTSR', null, null, null)^
execute procedure tmp_insert_auth_limit('RP', 'AuthorizationLimitAllRisks', 250001, 1250000, null, 'MGMTSR', null, null, null)^

commit work^

drop procedure tmp_insert_auth_limit^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("201119ML02", "RT-178 - updating RP auth rule limits", "2020-NOV-19");