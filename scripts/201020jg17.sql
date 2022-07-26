delete from rating_methods where line = 'RP' and method_code = 'FOPERACC24';

insert into applied_scripts (name, description, script_date)
        values ('201020jg17', 'BCSB-727 - Removing extra instructions, methods, and maps', '2020-October-20');

commit work;
