set term ^ ;

create trigger WORKSHEET_MASTER_BI for WORKSHEET_MASTER
active BEFORE INSERT position 0
as
begin
    if(new.worksheet_master_id is null or new.worksheet_master_id = 0) then
        new.worksheet_master_id = gen_id(worksheet_master_id_gen, 1);
end^
commit^

create trigger worksheet_bi for worksheet
active before insert position 0
as
    declare variable var_worksheet_master_id integer;
begin
    if (new.worksheet_master_id is null or (new.worksheet_master_id = 0)) then
    begin
        select wm.worksheet_master_id
          from worksheet_master wm
         where wm.origin_id = new.origin_id
          into :var_worksheet_master_id;

          new.worksheet_master_id = :var_worksheet_master_id;
    end
end^
commit^

set term ; ^

insert into applied_scripts (name, description, script_date)
     values ('200903AO01', 'BCSB-377 - worksheet_master_id gen trigger', '2020-Sept-03');
