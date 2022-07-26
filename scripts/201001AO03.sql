set term ^;

UPDATE LOCATION_PROPERTIES
SET    DESCRIPTION_LINE_2_VISIBLE = 'Y',
       DESCRIPTION_LINE_2_LABEL = 'Street name',
       DESCRIPTION_LINE_2_REQ = 'Q'^

set term ;^

insert into applied_scripts (name, description, script_date)
     values ('201001AO03', 'BCSB-635 - location desc_line_2 props init', '2020-OCT-1');