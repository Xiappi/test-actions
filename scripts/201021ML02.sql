set term ^;

create procedure tmp_create_rule_links (
    in_category_name varchar(50),
    in_line          varchar(2))
as
    declare variable var_category_id integer;
    declare variable var_master_id   integer;
    declare variable var_detail_id   integer;
begin
    select rule_category_id
      from rule_categories
     where rule_code = :in_category_name rows 1
      into :var_category_id;

    var_master_id = gen_id(gen_rule_master_id, 1);
    insert into rule_master (rule_master_id, line, rule_category_id)
         values (:var_master_id, :in_line, :var_category_id);

    for select rule_detail_id
          from rule_details
         where name in (
            'AuthorizationLimitGlass',
            'AuthorizationLimitEmployersLiability', 
            'AuthorizationLimitEmployersLiabilityAggregate', 
            'AuthorizationLimitPublicLiability', 
            'AuthorizationLimitProductsLiability', 
            'AuthorizationLimitMoneyLockedSafe', 
            'AuthorizationLimitMoneyInTransit', 
            'AuthorizationLimitGoodsInTransit',             
            'AuthorizationLimitDeteriorationOfStock',
            'AuthorizationLimitMachinery',             
            'AuthorizationLimitTheftFullLoss',            
            'AuthorizationLimitTheftFirstLoss', 
            'AuthorizationLimitTerrorism',             
            'AuthorizationLimitPersonalAccident')
          into :var_detail_id
    do
    begin
        insert into rule_master_detail_link (
                     rule_master_id, rule_detail_id)
             values (:var_master_id, :var_detail_id);
    end
end^

commit work^

execute procedure tmp_create_rule_links('AUTHORIZATION_LIMITS', 'OP')^
execute procedure tmp_create_rule_links('AUTHORIZATION_LIMITS', 'SP')^
execute procedure tmp_create_rule_links('AUTHORIZATION_LIMITS_NOTIFY', 'OP')^
execute procedure tmp_create_rule_links('AUTHORIZATION_LIMITS_NOTIFY', 'SP')^

commit work^

drop procedure tmp_create_rule_links^

set term ;^

insert into applied_scripts (name, description, script_date)
     values ('201021ML02', 'RT-161 - auth level for OP + SP', '2020-Sept-21');