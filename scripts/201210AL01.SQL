SET TERM ^;


delete from user_roles_rights_dtl
  where role_id in (1,3) and security_key = "AG"^

commit^

INSERT INTO applied_scripts(NAME, DESCRIPTION, SCRIPT_DATE)
VALUES ("201210AL01", "RT-371 remove broker identity default seniorUW", "12/10/2020")^

SET TERM ;^

COMMIT WORK;
