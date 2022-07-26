set term ^;

create procedure tmp_remove_links
as
    declare variable var_workflow_level_id integer;
begin
    for select wl.workflow_level_id
          from workflow_master wm
          join workflow_levels wl
                     on wl.workflow_id = wm.workflow_id
         where wm.name in ('CHANGE', 'RENEWAL', 'APPLICATION')
          into :var_workflow_level_id
    do
    begin
        delete from workflow_level_task_link
         where workflow_level_id = :var_workflow_level_id;
    end
end^

commit^

execute procedure tmp_remove_links^

commit^

drop procedure tmp_remove_links^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("200925ML01", "RT-161 - removing workflow task links", "09/25/2020");