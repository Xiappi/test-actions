set term ^;

update task_activity set notify_agent = 1^

update task_activity set notify_creator = 1^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("210707DC02", "AIS-35980 configure email notif on task complete", "2021-Jul-07");
