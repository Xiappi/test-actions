set term ^;

update location_properties
    set twnship_visible = 'N',
        city_visible = 'Y',
        city_req = 'Q',
        city_caption = 'Township / City'^

set term ;^

insert into applied_scripts (name, description, script_date)
     values ('201002AO01', 'BCSB-635 - location props tweaks', '2020-OCT-2');