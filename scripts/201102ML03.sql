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
         select :var_new_id, rt1.ref_code, rt1.state, 'NEW', rt1.ref_desc, rt1.rate_modifier, rt1.prior_modifier, rt1.qty, rt1.descr, rt1.endorsement, rt1.mobile_home, 
                rt1.form1, rt1.form2, rt1.form3, rt1.form4, rt1.form5, rt1.form6, rt1.form7, rt1.form8, rt1.form9, rt1.form10, rt1.qty_label, rt1.limit_label, rt1.desc_label, 
                rt1.list_label, rt1.limit, rt1.deduct, rt1.deduct_label, rt1.descr_list, rt1.def_deduct, rt1.cover_type, rt1.heat, rt1.exposed, rt1.min_limit, 
                rt1.max_limit, rt1.prompt_covl, rt1.field_default, rt1.photo, rt1.location, rt1.multi_option, rt1.basic_limit, rt1.form_type, rt1.liab_label, 
                rt1.show_type, rt1.one_only, rt1.gl_account, rt1.account_no, 10.00, rt1.list_labels, rt1.new_orig_comm, rt1.new_change_comm, 
                rt1.new_cancel_comm, rt1.renew_orig_comm, rt1.renew_change_comm, rt1.renew_cancel_comm, rt1.modifier_key, rt1.prompt_date, 
                rt1.next_key, rt1.sysdate, rt1.stats_flag, rt1.stat_entry, rt1.line, rt1.stats, rt1.square_footage, rt1.square_label, 
                rt1.rangekey_length, rt1.rangekey, rt1.round_prem, rt1.ded_code, rt1.fire_protection, rt1.protective_devices, rt1.covered_perils, 
                rt1.tie_down, rt1.vacancy, rt1.construction, rt1.form_status, rt1.rate_group, rt1.rate_order, rt1.round_type, rt1.discount_max, 
                rt1.max_premium, rt1.expired_date, rt1.status, rt1.multiple_version, rt1.book_id, rt1.rate_type, rt1.exp_book_id, rt1.farm_type, 
                rt1.max_liability, rt1.help_index, rt1.limit_value, rt1.limit_type, rt1.desc_required, rt1.list_required, rt1.square_required, rt1.rule_id, 
                rt1.building_classification, rt1.lookup_visible, rt1.lookup_type, rt1.lookup_coverage, rt1.lookup_label, rt1.min_qty, rt1.max_qty,
                rt1.lookup_required, rt1.risk_no, rt1.classification_visible, rt1.classification_label, rt1.classification_required, 
                rt1.classification_category, rt1.classification_default, rt1.premium_type, rt1.num_field, rt1.num_label, rt1.num_required, 
                rt1.num_min_amt, rt1.num_max_amt, rt1.limit_value_2, rt1.num_data, rt1.char_data, rt1.primary_dwell_only, rt1.max_loss, rt1.max_loss_label, 
                rt1.max_loss_min, rt1.max_loss_max, rt1.field_label, rt1.classdef_ref_id, rt1.subclass_ref_id, rt1.propliab_ref_id, rt1.asldef_ref_id, 
                rt1.asldef_prop_ref_id, rt1.asldef_liab_ref_id, rt1.web_help, rt1.questionnaire_id, rt1.security_id
           from ref_table rt1
          where rt1.reftable_id = :var_reftable_id;
    
    
    /* insert policyfee CHANGE */
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
         select :var_new_id, rt2.ref_code, rt2.state, 'CHANGE', rt2.ref_desc, rt2.rate_modifier, rt2.prior_modifier, rt2.qty, rt2.descr, rt2.endorsement, rt2.mobile_home, 
                rt2.form1, rt2.form2, rt2.form3, rt2.form4, rt2.form5, rt2.form6, rt2.form7, rt2.form8, rt2.form9, rt2.form10, rt2.qty_label, rt2.limit_label, rt2.desc_label, 
                rt2.list_label, rt2.limit, rt2.deduct, rt2.deduct_label, rt2.descr_list, rt2.def_deduct, rt2.cover_type, rt2.heat, rt2.exposed, rt2.min_limit, 
                rt2.max_limit, rt2.prompt_covl, rt2.field_default, rt2.photo, rt2.location, rt2.multi_option, rt2.basic_limit, rt2.form_type, rt2.liab_label, 
                rt2.show_type, rt2.one_only, rt2.gl_account, rt2.account_no, 5, rt2.list_labels, rt2.new_orig_comm, rt2.new_change_comm, 
                rt2.new_cancel_comm, rt2.renew_orig_comm, rt2.renew_change_comm, rt2.renew_cancel_comm, rt2.modifier_key, rt2.prompt_date, 
                rt2.next_key, rt2.sysdate, rt2.stats_flag, rt2.stat_entry, rt2.line, rt2.stats, rt2.square_footage, rt2.square_label, 
                rt2.rangekey_length, rt2.rangekey, rt2.round_prem, rt2.ded_code, rt2.fire_protection, rt2.protective_devices, rt2.covered_perils, 
                rt2.tie_down, rt2.vacancy, rt2.construction, rt2.form_status, rt2.rate_group, rt2.rate_order, rt2.round_type, rt2.discount_max, 
                rt2.max_premium, rt2.expired_date, rt2.status, rt2.multiple_version, rt2.book_id, rt2.rate_type, rt2.exp_book_id, rt2.farm_type, 
                rt2.max_liability, rt2.help_index, rt2.limit_value, rt2.limit_type, rt2.desc_required, rt2.list_required, rt2.square_required, rt2.rule_id, 
                rt2.building_classification, rt2.lookup_visible, rt2.lookup_type, rt2.lookup_coverage, rt2.lookup_label, rt2.min_qty, rt2.max_qty,
                rt2.lookup_required, rt2.risk_no, rt2.classification_visible, rt2.classification_label, rt2.classification_required, 
                rt2.classification_category, rt2.classification_default, rt2.premium_type, rt2.num_field, rt2.num_label, rt2.num_required, 
                rt2.num_min_amt, rt2.num_max_amt, rt2.limit_value_2, rt2.num_data, rt2.char_data, rt2.primary_dwell_only, rt2.max_loss, rt2.max_loss_label, 
                rt2.max_loss_min, rt2.max_loss_max, rt2.field_label, rt2.classdef_ref_id, rt2.subclass_ref_id, rt2.propliab_ref_id, rt2.asldef_ref_id, 
                rt2.asldef_prop_ref_id, rt2.asldef_liab_ref_id, rt2.web_help, rt2.questionnaire_id, rt2.security_id
           from ref_table rt2
          where rt2.reftable_id = :var_reftable_id;
    
    /* insert policyfee RENEW */
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
         select :var_new_id, rt3.ref_code, rt3.state, 'RENEW', rt3.ref_desc, rt3.rate_modifier, rt3.prior_modifier, rt3.qty, rt3.descr, rt3.endorsement, rt3.mobile_home, 
                rt3.form1, rt3.form2, rt3.form3, rt3.form4, rt3.form5, rt3.form6, rt3.form7, rt3.form8, rt3.form9, rt3.form10, rt3.qty_label, rt3.limit_label, rt3.desc_label, 
                rt3.list_label, rt3.limit, rt3.deduct, rt3.deduct_label, rt3.descr_list, rt3.def_deduct, rt3.cover_type, rt3.heat, rt3.exposed, rt3.min_limit, 
                rt3.max_limit, rt3.prompt_covl, rt3.field_default, rt3.photo, rt3.location, rt3.multi_option, rt3.basic_limit, rt3.form_type, rt3.liab_label, 
                rt3.show_type, rt3.one_only, rt3.gl_account, rt3.account_no, 10, rt3.list_labels, rt3.new_orig_comm, rt3.new_change_comm, 
                rt3.new_cancel_comm, rt3.renew_orig_comm, rt3.renew_change_comm, rt3.renew_cancel_comm, rt3.modifier_key, rt3.prompt_date, 
                rt3.next_key, rt3.sysdate, rt3.stats_flag, rt3.stat_entry, rt3.line, rt3.stats, rt3.square_footage, rt3.square_label, 
                rt3.rangekey_length, rt3.rangekey, rt3.round_prem, rt3.ded_code, rt3.fire_protection, rt3.protective_devices, rt3.covered_perils, 
                rt3.tie_down, rt3.vacancy, rt3.construction, rt3.form_status, rt3.rate_group, rt3.rate_order, rt3.round_type, rt3.discount_max, 
                rt3.max_premium, rt3.expired_date, rt3.status, rt3.multiple_version, rt3.book_id, rt3.rate_type, rt3.exp_book_id, rt3.farm_type, 
                rt3.max_liability, rt3.help_index, rt3.limit_value, rt3.limit_type, rt3.desc_required, rt3.list_required, rt3.square_required, rt3.rule_id, 
                rt3.building_classification, rt3.lookup_visible, rt3.lookup_type, rt3.lookup_coverage, rt3.lookup_label, rt3.min_qty, rt3.max_qty,
                rt3.lookup_required, rt3.risk_no, rt3.classification_visible, rt3.classification_label, rt3.classification_required, 
                rt3.classification_category, rt3.classification_default, rt3.premium_type, rt3.num_field, rt3.num_label, rt3.num_required, 
                rt3.num_min_amt, rt3.num_max_amt, rt3.limit_value_2, rt3.num_data, rt3.char_data, rt3.primary_dwell_only, rt3.max_loss, rt3.max_loss_label, 
                rt3.max_loss_min, rt3.max_loss_max, rt3.field_label, rt3.classdef_ref_id, rt3.subclass_ref_id, rt3.propliab_ref_id, rt3.asldef_ref_id, 
                rt3.asldef_prop_ref_id, rt3.asldef_liab_ref_id, rt3.web_help, rt3.questionnaire_id, rt3.security_id
           from ref_table rt3
          where rt3.reftable_id = :var_reftable_id;
end^

commit work^

execute procedure tmp_clone_policy_fee('RP')^
execute procedure tmp_clone_policy_fee('SP')^
execute procedure tmp_clone_policy_fee('OP')^

commit work^

/*  we're replacing the '0' entry with the 3 inserted records above ('NEW', 'CHANGE', 'RENEW')*/
delete
  from ref_table rt
 where rt.ref_code = 'POLICYFEE' 
   and rt.effective_date < 'TODAY' 
   and rt.expired_date > 'TODAY' 
   and rt.line in ('RP', 'SP', 'OP')
   and rt.ref_key = '0'^

commit work^

drop procedure tmp_clone_policy_fee^

set term ;^

insert into applied_scripts (name, description, script_date)
     values ('201102ML03', 'BCSB-1023 - 3 entries for policyfee (new, change, renew)', '2020-Nov-02');