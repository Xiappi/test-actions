set term ^;

create procedure tmp_clone_policy_fee(in_line varchar(2))
as
    declare variable var_new_id      integer;
    declare variable var_reftable_id integer;
begin
    select rt.reftable_id
      from ref_table rt
     where rt.ref_code = 'POLICYFEE' 
       and rt.effective_date < 'TODAY' 
       and rt.expired_date > 'TODAY' 
       and rt.line = :in_line
       and rt.ref_key = '0'
      into :var_reftable_id;

    /* insert policyfee NEW */
    var_new_id = gen_id(REFTABLE_GEN, 1);
    insert into ref_table (reftable_id, ref_code, state, ref_key, ref_desc, rate_modifier, prior_modifier, qty, descr, endorsement, mobile_home,
                           form1, form2, form3, form4, form5, form6, form7, form8, form9, form10, qty_label, limit_label, desc_label,
                           list_label, limit, deduct, deduct_label, descr_list, def_deduct, cover_type, heat, exposed, min_limit,
                           max_limit, prompt_covl, field_default, photo, location, multi_option, basic_limit, form_type, liab_label,
                           show_type, one_only, gl_account, account_no, min_premium, list_labels, new_orig_comm, new_change_comm,
                           new_cancel_comm, renew_orig_comm, renew_change_comm, renew_cancel_comm, modifier_key, prompt_date,
                           next_key, sysdate, stats_flag, stat_entry, line, stats, square_footage, square_label,
                           rangekey_length, rangekey, round_prem, ded_code, fire_protection, protective_devices, covered_perils,
                           tie_down, vacancy, construction, form_status, rate_group, rate_order, round_type, discount_max,
                           max_premium, expired_date, status, multiple_version, book_id, rate_type, exp_book_id, farm_type,
                           max_liability, help_index, limit_value, limit_type, desc_required, list_required, square_required, rule_id,
                           building_classification, lookup_visible, lookup_type, lookup_coverage, lookup_label, min_qty, max_qty,
                           lookup_required, risk_no, classification_visible, classification_label, classification_required,
                           classification_category, classification_default, premium_type, num_field, num_label, num_required,
                           num_min_amt, num_max_amt, limit_value_2, num_data, char_data, primary_dwell_only, max_loss, max_loss_label,
                           max_loss_min, max_loss_max, field_label, classdef_ref_id, subclass_ref_id, propliab_ref_id, asldef_ref_id,
                           asldef_prop_ref_id, asldef_liab_ref_id, web_help, questionnaire_id, security_id)
         select :var_new_id, rt1.ref_code, rt1.state, 'MINPREM', rt1.ref_desc, 2.50, rt1.prior_modifier, rt1.qty, rt1.descr, rt1.endorsement, rt1.mobile_home, 
                rt1.form1, rt1.form2, rt1.form3, rt1.form4, rt1.form5, rt1.form6, rt1.form7, rt1.form8, rt1.form9, rt1.form10, rt1.qty_label, rt1.limit_label, rt1.desc_label, 
                rt1.list_label, rt1.limit, rt1.deduct, rt1.deduct_label, rt1.descr_list, rt1.def_deduct, rt1.cover_type, rt1.heat, rt1.exposed, rt1.min_limit, 
                rt1.max_limit, rt1.prompt_covl, rt1.field_default, rt1.photo, rt1.location, rt1.multi_option, rt1.basic_limit, rt1.form_type, rt1.liab_label, 
                rt1.show_type, rt1.one_only, rt1.gl_account, rt1.account_no, 21.22, rt1.list_labels, rt1.new_orig_comm, rt1.new_change_comm, 
                rt1.new_cancel_comm, rt1.renew_orig_comm, rt1.renew_change_comm, rt1.renew_cancel_comm, rt1.modifier_key, rt1.prompt_date, 
                rt1.next_key, rt1.sysdate, rt1.stats_flag, rt1.stat_entry, rt1.line, rt1.stats, rt1.square_footage, rt1.square_label, 
                rt1.rangekey_length, rt1.rangekey, rt1.round_prem, rt1.ded_code, rt1.fire_protection, rt1.protective_devices, rt1.covered_perils, 
                rt1.tie_down, rt1.vacancy, rt1.construction, rt1.form_status, rt1.rate_group, rt1.rate_order, rt1.round_type, rt1.discount_max, 
                rt1.max_premium, rt1.expired_date, rt1.status, rt1.multiple_version, rt1.book_id, 'FLAT', rt1.exp_book_id, rt1.farm_type, 
                rt1.max_liability, rt1.help_index, rt1.limit_value, rt1.limit_type, rt1.desc_required, rt1.list_required, rt1.square_required, rt1.rule_id, 
                rt1.building_classification, rt1.lookup_visible, rt1.lookup_type, rt1.lookup_coverage, rt1.lookup_label, rt1.min_qty, rt1.max_qty,
                rt1.lookup_required, rt1.risk_no, rt1.classification_visible, rt1.classification_label, rt1.classification_required, 
                rt1.classification_category, rt1.classification_default, rt1.premium_type, rt1.num_field, rt1.num_label, rt1.num_required, 
                rt1.num_min_amt, rt1.num_max_amt, rt1.limit_value_2, rt1.num_data, rt1.char_data, rt1.primary_dwell_only, rt1.max_loss, rt1.max_loss_label, 
                rt1.max_loss_min, rt1.max_loss_max, rt1.field_label, rt1.classdef_ref_id, rt1.subclass_ref_id, rt1.propliab_ref_id, rt1.asldef_ref_id, 
                rt1.asldef_prop_ref_id, rt1.asldef_liab_ref_id, rt1.web_help, rt1.questionnaire_id, rt1.security_id
           from ref_table rt1
          where rt1.reftable_id = :var_reftable_id;
end^

commit work^

execute procedure tmp_clone_policy_fee('RP')^
execute procedure tmp_clone_policy_fee('SP')^
execute procedure tmp_clone_policy_fee('OP')^

commit work^

commit work^

drop procedure tmp_clone_policy_fee^

set term ;^

insert into applied_scripts (name, description, script_date)
     values ('201102ML02', 'BCSB-1024 - new entry for special policyfee scenario', '2020-Nov-02');