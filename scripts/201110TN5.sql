
SET TERM ^;

update company c
set c.char_data = '2020-DEC-01'
where c.control_key = 'QUOTEDAYS'
and c.state = 'MT'
and c.line in ('RP', 'OP', 'SP')^


COMMIT^

INSERT INTO applied_scripts(NAME, DESCRIPTION, SCRIPT_DATE)
VALUES ("201110TN5", "Update the default date on QUOTEDAYS config", "11/10/2020")^
SET TERM ;^
COMMIT WORK;