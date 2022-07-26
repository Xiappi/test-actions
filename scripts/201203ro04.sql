set term ^;

update task_activity ta
set ta.task_title = "Underwriter Review",
    ta.task_message = "A transaction has been submitted that requires Underwriter review."
where ta.activity_name = "TASKAPP"^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("201203ro04", "BCSB-1397 - modify TASKAPP activity", "2020-DEC-03");
