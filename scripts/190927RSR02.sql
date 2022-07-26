delete from driver_fields_master;

set term ^;

create procedure temp_migrate_driver_fields
as
    declare variable var_master_id     integer;
    declare variable var_line          varchar(10) character set none;
    declare variable var_book_id       integer;
    declare variable var_detail_id     integer;
    declare variable var_order         integer;
    declare variable var_name          varchar(20) character set none;
    declare variable var_label         varchar(160) character set none;
    declare variable var_required      varchar(10) character set none;
    declare variable var_data_type     varchar(10) character set none;
    declare variable var_limit_type    varchar(10) character set none;
    declare variable var_max_length    integer;
    declare variable var_display_width integer;
    declare variable var_min_value     numeric(15,4);
    declare variable var_max_value     numeric(15,4);
    declare variable var_in_list       varchar(1) character set none;
    declare variable var_max_rate_date timestamp;
    declare variable var_old_field_name varchar(20);
    declare variable var_lookup_code   varchar(10);
begin
    var_in_list = 'N';

    select max(effective_date)
      from rate_book
      into :var_max_rate_date;

    select rb.book_id
      from rate_book rb
     order by rb.book_id rows 1
      into :var_book_id;

    for select rtl.ref_key
          from ref_table rtl
         where rtl.ref_code = 'LINE'
           and rtl.state = 'MT'
           and rtl.ref_key in ('PC', 'MF')
           and :var_max_rate_date between rtl.effective_date and rtl.expired_date
          into :var_line
    do
    begin
        var_master_id = gen_id(gen_driver_fields_master_id, 1);
        var_order = 1;

        insert into driver_fields_master (driver_fields_master_id, line, book_id)
            values (:var_master_id, :var_line, :var_book_id);

        for select rt.rangekey,
                   rt.ref_desc,
                   rt.desc_required,
                   rt.limit_type
              from ref_table rt
             where rt.ref_code = 'DRVCHAR'
               and rt.state = 'MT'
               and rt.line = :var_line
               and :var_max_rate_date between rt.effective_date and rt.expired_date
               and rt.rangekey not in ('AGE', 'YEARS_LICENSED', 'FNAME', 'LNAME', 'SEX', 'DATE_OF_BIRTH', 'MARITALSTATUS', "USER_DEF_DD5", "USER_DEF_DD6")
          order by rt.rangekey
              into :var_old_field_name,
                   :var_label,
                   :var_required,
                   :var_limit_type
        do
        begin
            var_display_width = 0;
            var_max_length = 0;
            var_data_type = '';
            var_name = :var_old_field_name;
            var_lookup_code = '';

            if (:var_name = 'DATE_LICENSED') then
            begin
                var_data_type = 'DATE';
                var_name = 'LICENSE_DATE';
            end
            else if (:var_name = 'LICENSE_NO') then
            begin
                var_display_width = 20;
                var_max_length = 20;
                var_data_type = 'STRING';
            end
            else if (:var_name = 'STATE_LICENSE') then
            begin
                var_display_width = 20;
                var_max_length = 20;
                var_data_type = 'STRING';
                var_name = 'LICENSE_STATE';
            end
            else if (:var_name = 'USER_DEF1') then
            begin
                var_display_width = 30;
                var_max_length = 30;
                var_data_type = 'STRING';
                var_name = 'OCCUPATION';
            end
            else if (:var_name = 'USER_DEF4') then
            begin
                var_display_width = 30;
                var_max_length = 30;
                var_data_type = 'STRING';
                var_name = 'MIDDLE_INITIAL';
            end
            else if (:var_name = 'USER_DEF5') then
            begin
                var_display_width = 30;
                var_max_length = 30;
                var_data_type = 'STRING';
                var_name = 'SUFFIX';
            end

            var_detail_id = gen_id(gen_driver_fields_detail_id, 1);

            insert into driver_fields_detail (driver_fields_master_id, driver_fields_detail_id, display_order, name,
                                              label, required, data_type, limit_type, max_length, display_width,
                                              in_list, old_field_name, lookup_code)
                values (:var_master_id, :var_detail_id, :var_order, :var_name, :var_label, :var_required,
                        :var_data_type, :var_limit_type, :var_max_length, :var_display_width, :var_in_list,
                        :var_old_field_name, :var_lookup_code);

            var_order = :var_order + 1;
        end
    end
end^

commit^

execute procedure temp_migrate_driver_fields^
commit^

drop procedure temp_migrate_driver_fields^
commit^

insert into applied_scripts (name, description, script_date) 
values ("190927RSR02", "AIS-29837 Migrate driver fields for PC & MF", "2019-SEP-27")^

set term;^
commit work;