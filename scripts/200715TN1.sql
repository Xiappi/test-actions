/************************************************************/
/*                                                          */
/* SCRIPT NAME: 200715TN1                                   */
/* MKS #: BCSB-191                                          */
/* DESCRIPTION:                                             */
/*     Add groups to lines                                  */
/*                                                          */
/************************************************************/
/* CONNECT "" USER "" PASSWORD ""; */
SET TERM ^;

create procedure temp_coverages
as
    declare variable master_id integer;
    declare variable state     varchar(10);
    declare variable max_order integer;
begin
        /* RP */
        select max(group_order)
          from ref_group_master
         where state = 'MT'
           and line = "RP"
          into :max_order;

        max_order = :max_order + 1;
        master_id = gen_id(group_master_id_gen, 1);

        insert into ref_group_master (group_master_id, state, line, group_order, group_description, group_code, book_id,
                                      effective_date, expired_date)
            values (:master_id, 'MT', 'RP', :max_order, 'Coverages', "COVERAGES", 1, "1996-JAN-1",
                    "9999-DEC-31");

        max_order = :max_order + 1;
        master_id = gen_id(group_master_id_gen, 1);

        insert into ref_group_master (group_master_id, state, line, group_order, group_description, group_code, book_id,
                                      effective_date, expired_date)
            values (:master_id, 'MT', 'RP', :max_order, 'Underwriter Only', "UWONLY", 1, "1996-JAN-1",
                    "9999-DEC-31");

        /* OP */
        select max(group_order)
          from ref_group_master
         where state = 'MT'
           and line = "OP"
          into :max_order;

        max_order = :max_order + 1;
        master_id = gen_id(group_master_id_gen, 1);

        insert into ref_group_master (group_master_id, state, line, group_order, group_description, group_code, book_id,
                                      effective_date, expired_date)
            values (:master_id, 'MT', 'OP', :max_order, 'Coverages', "COVERAGES", 1, "1996-JAN-1",
                    "9999-DEC-31");

        max_order = :max_order + 1;
        master_id = gen_id(group_master_id_gen, 1);

        insert into ref_group_master (group_master_id, state, line, group_order, group_description, group_code, book_id,
                                      effective_date, expired_date)
            values (:master_id, 'MT', 'OP', :max_order, 'Underwriter Only', "UWONLY", 1, "1996-JAN-1",
                    "9999-DEC-31");

        /* SP */
        select max(group_order)
          from ref_group_master
         where state = 'MT'
           and line = "SP"
          into :max_order;

        max_order = :max_order + 1;
        master_id = gen_id(group_master_id_gen, 1);

        insert into ref_group_master (group_master_id, state, line, group_order, group_description, group_code, book_id,
                                      effective_date, expired_date)
            values (:master_id, 'MT', 'SP', :max_order, 'Coverages', "COVERAGES", 1, "1996-JAN-1",
                    "9999-DEC-31");

        max_order = :max_order + 1;
        master_id = gen_id(group_master_id_gen, 1);

        insert into ref_group_master (group_master_id, state, line, group_order, group_description, group_code, book_id,
                                      effective_date, expired_date)
            values (:master_id, 'MT', 'SP', :max_order, 'Underwriter Only', "UWONLY", 1, "1996-JAN-1",
                    "9999-DEC-31");


end^
commit^

execute procedure temp_coverages^
commit^

drop procedure temp_coverages^
commit^



INSERT INTO applied_scripts(NAME, DESCRIPTION, SCRIPT_DATE)
VALUES ("200715TN1", "Add groups to lines", "07/15/2020")^
SET TERM ;^
COMMIT WORK;
