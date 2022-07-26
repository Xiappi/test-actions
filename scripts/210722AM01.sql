SET TERM ^;

create procedure temp_coverages_210722AM01(
  in_line varchar(10)
)
as
    declare variable master_id integer;
    declare variable max_order integer;
begin
    /* Max order doesn't matter because we will set them at the end */
    max_order = 1;

    /* Coverages */
    master_id = gen_id(group_master_id_gen, 1);

    insert into ref_group_master (group_master_id, state, line, group_order, group_description, group_code, book_id,
                                  effective_date, expired_date)
        values (:master_id, 'MT', :in_line, :max_order, 'Coverages', "COVERAGES", 1, "1996-JAN-1",
                "9999-DEC-31");    

    /* System Coverages */
    master_id = gen_id(group_master_id_gen, 1);

    insert into ref_group_master (group_master_id, state, line, group_order, group_description, group_code, user_right, book_id,
                                  effective_date, expired_date)
        values (:master_id, 'MT', :in_line, :max_order, 'System Coverages', "SYSTEMCOVS", 'SYSTEMCOV' , 1, "1996-JAN-1",
                "9999-DEC-31"); 


    /* Underwriter Only */
    master_id = gen_id(group_master_id_gen, 1);

    insert into ref_group_master (group_master_id, state, line, group_order, group_description, group_code, user_right, book_id,
                                  effective_date, expired_date)
        values (:master_id, 'MT', :in_line, :max_order, 'Underwriter Only', "UWONLY", 'UW' , 1, "1996-JAN-1",
                "9999-DEC-31");

end^

execute procedure temp_coverages_210722AM01('HX')^
execute procedure temp_coverages_210722AM01('CV')^
execute procedure temp_coverages_210722AM01('MF')^
execute procedure temp_coverages_210722AM01('MY')^
execute procedure temp_coverages_210722AM01('PC')^
execute procedure temp_coverages_210722AM01('TX')^

create procedure temp_update_group_order_210722AM01
as
    declare variable master_id integer;
begin
      
    /* Update System Coverages for RP, SP, OP*/
    master_id = gen_id(group_master_id_gen, 1);

    insert into ref_group_master (group_master_id, state, line, group_order, group_description, group_code, user_right, book_id,
                                  effective_date, expired_date)
        values (:master_id, 'MT', 'RP', 1, 'System Coverages', "SYSTEMCOVS", 'SYSTEMCOV' , 1, "1996-JAN-1",
                "9999-DEC-31"); 

    master_id = gen_id(group_master_id_gen, 1);

    insert into ref_group_master (group_master_id, state, line, group_order, group_description, group_code, user_right, book_id,
                                  effective_date, expired_date)
        values (:master_id, 'MT', 'SP', 1, 'System Coverages', "SYSTEMCOVS", 'SYSTEMCOV' , 1, "1996-JAN-1",
                "9999-DEC-31");         
    
    master_id = gen_id(group_master_id_gen, 1);

    insert into ref_group_master (group_master_id, state, line, group_order, group_description, group_code, user_right, book_id,
                                  effective_date, expired_date)
        values (:master_id, 'MT', 'OP', 1, 'System Coverages', "SYSTEMCOVS", 'SYSTEMCOV' , 1, "1996-JAN-1",
                "9999-DEC-31"); 
        
    /* Update group ordering */
    update ref_group_master
       set group_order = 1
     where group_code = "COVERAGES";

    update ref_group_master
       set group_order = 2
     where group_code = "UWONLY";

    update ref_group_master
       set group_order = 3
     where group_code = "SYSTEMCOVS";

    update ref_group_master
       set group_order = 4
     where group_code = "REPLTYPES";


end^

execute procedure temp_update_group_order_210722AM01^
drop procedure temp_update_group_order_210722AM01^
drop procedure temp_coverages_210722AM01^

INSERT INTO applied_scripts(NAME, DESCRIPTION, SCRIPT_DATE)
VALUES ("210722AM01", "MHM-561 - create new coverage groups", "2021-JUL-22")^

SET TERM ;^
commit work;



