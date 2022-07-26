set term ^ ;

alter procedure s_model_map_items (
    in_policy_id  integer,
    in_fetch_type smallint,
    in_as_of_date date,
    in_batch_no   integer)
returns (
    out_item_number     integer,
    out_item_status     varchar(2) character set none,
    out_sequence        integer,
    out_description     varchar(255) character set none,
    out_ref_code        varchar(10) character set none,
    out_ref_key         varchar(10) character set none,
    out_reftable_id     integer,
    out_item_type       varchar(2) character set none,
    out_location        integer,
    out_deduct          integer,
    out_qty             integer,
    out_limit           integer,
    out_inclimit        integer,
    out_basic_limit     integer,
    out_memo            varchar(255) character set none,
    out_memo2           varchar(1024) character set none,
    out_lookup          integer,
    out_lookup_value    integer,
    out_classification  integer,
    out_num_field       numeric(15,4),
    out_manual_rate     numeric(15,2),
    out_risk            integer,
    out_squarefootage   integer,
    out_item_length     integer,
    out_item_width      integer,
    out_numstories      integer,
    out_construction    integer,
    out_fireprotection  integer,
    out_heat            integer,
    out_vacancy         integer,
    out_vacantfrom      date,
    out_vacantto        date,
    out_manualpremium   integer,
    out_yearbuilt       integer,
    out_rooftype        integer,
    out_rooflayers      integer,
    out_roofyear        integer,
    out_latitude        numeric(9,6),
    out_longitude       numeric(9,6),
    out_written_premium numeric(15,2),
    out_annual_premium  numeric(15,2),
    out_unique_id       integer,
    out_max_loss        integer)
AS
    declare variable var_unique_id integer;
    declare variable var_state     varchar(2) character set none;
    declare variable var_line      varchar(10) character set none;
    declare variable var_rate_date date;
begin
    suspend;
end^
commit^



alter procedure s_model_map_item (
    in_policy_id  integer,
    in_unique_id  integer,
    in_state      varchar(2) character set none,
    in_line       varchar(10) character set none,
    in_rate_date  date,
    in_as_of_date date)
returns (
    out_item_number     integer,
    out_item_status     varchar(2) character set none,
    out_sequence        integer,
    out_description     varchar(255) character set none,
    out_ref_code        varchar(10) character set none,
    out_ref_key         varchar(10) character set none,
    out_reftable_id     integer,
    out_item_type       varchar(2) character set none,
    out_location        integer,
    out_deduct          integer,
    out_qty             integer,
    out_limit           integer,
    out_inclimit        integer,
    out_basic_limit     integer,
    out_memo            varchar(255) character set none,
    out_memo2           varchar(1024) character set none,
    out_lookup          integer,
    out_lookup_value    integer,
    out_classification  integer,
    out_num_field       numeric(15,4),
    out_manual_rate     numeric(15,2),
    out_risk            integer,
    out_squarefootage   integer,
    out_item_length     integer,
    out_item_width      integer,
    out_numstories      integer,
    out_construction    integer,
    out_fireprotection  integer,
    out_heat            integer,
    out_vacancy         integer,
    out_vacantfrom      date,
    out_vacantto        date,
    out_manualpremium   integer,
    out_yearbuilt       integer,
    out_rooftype        integer,
    out_rooflayers      integer,
    out_roofyear        integer,
    out_latitude        numeric(9,6),
    out_longitude       numeric(9,6),
    out_written_premium numeric(15,2),
    out_annual_premium  numeric(15,2),
    out_unique_id       integer,
    out_max_loss        integer)
AS
    declare variable var_roof_type_key  varchar(10);
    declare variable var_roof_type_code varchar(10);
    declare variable var_form_type      varchar(10);
    declare variable var_item_batch_no  integer;
    declare variable var_item_origin_id integer;
begin
    suspend;
end^
commit^

set term ; ^

insert into applied_scripts (name, description, script_date)
     values ('200908AO01', 'BCSB-395 - fetch items drop depends', '2020-Sept-08');
