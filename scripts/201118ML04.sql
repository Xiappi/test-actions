set term ^;

create procedure tmp_delete_rules_for_sp_op(in_category_name varchar(30))
as
     declare variable var_master_id     integer;
     declare variable var_category_id   integer;
begin
     select rule_category_id
       from rule_categories 
      where rule_code = :in_category_name
       rows 1
       into :var_category_id;

     for select rule_master_id
           from rule_master
          where line <> 'RP'
            and rule_category_id = :var_category_id
           into :var_master_id
     do begin
          delete 
            from rule_master_detail_link
           where rule_master_id = :var_master_id;

          delete 
            from rule_master
           where rule_master_id = :var_master_id;
     end
end^

create procedure tmp_delete_authorization_limits
as
begin
     delete from rule_authorization_limits_link;
     delete from rule_authorization_limits_identity;
     delete from rule_unauthorized_task_link;
     delete from rule_authorization_limits;
end^

commit work^

execute procedure tmp_delete_rules_for_sp_op('AUTHORIZATION_LIMITS')^
execute procedure tmp_delete_rules_for_sp_op('AUTHORIZATION_LIMITS_NOTIFY')^
execute procedure tmp_delete_authorization_limits^

commit work^

drop procedure tmp_delete_rules_for_sp_op^
drop procedure tmp_delete_authorization_limits^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("201118ML04", "RT-178 - auth rule cleanup", "2020-NOV-18");