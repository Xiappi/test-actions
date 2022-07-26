set term ^ ;

DROP TRIGGER POLICY_USER_FIELDS_ADDED^

DROP TRIGGER POLICY_USER_FIELDS_CHANGED^

commit^

set term ;^

insert into applied_scripts (name, description, script_date)
     values ('200527ro02', 'PS-319 - remove Genius triggers', '2020-MAY-27');