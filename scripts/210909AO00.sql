set term ^;

insert into task_activity (
             task_title, default_number_of_days_due, task_message, activity_name, web_link, notify_agent,
             notify_creator, category_name)
     values ('One or more insureds are on the caution list', 5,
             'An application has been submitted with one or more insureds on the caution list.', 'CAUTIONLIST', '', 1,
             1, 'CAUTIONLST')^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("210909AO00", "MHM-365 - caution list rules", "2021-SEP-09");