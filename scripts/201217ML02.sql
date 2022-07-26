set term ^;

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Glass exceeds Broker limit',
    TASK_MESSAGE = 'A transaction has been submitted with glass coverage that requires Underwriter review.'
WHERE (ACTIVITY_NAME = 'GLASS_UW')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Glass exceeds Underwriter limit',
    TASK_MESSAGE = 'A transaction has been submitted with glass coverage that requires Senior Underwriter review.'
WHERE (ACTIVITY_NAME = 'GLASS_UWSR')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Glass exceeds Underwriting Manager limit',
    TASK_MESSAGE = 'A transaction has been submitted with glass coverage that requires Senior Management review.'
WHERE (ACTIVITY_NAME = 'GLASS_MGMTSR')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Employer''s Liability exceeds Underwriting Manager limit',
    TASK_MESSAGE = 'A transaction has been submitted with employer''s liability coverage that requires Senior Management review.'
WHERE (ACTIVITY_NAME = 'EMPLOYERLIABILITY_MGMTSR')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Employer''s Liability aggregate exceeds Underwriting Manager limit',
    TASK_MESSAGE = 'A transaction has been submitted with employer''s liability coverage that requires Senior Management review.'
WHERE (ACTIVITY_NAME = 'EMPLOYERLIABILITYAGGREGATE_MGMTSR')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Public Liability exceeds Broker limit',
    TASK_MESSAGE = 'A transaction has been submitted with public liability coverage that requires Underwriter review.'
WHERE (ACTIVITY_NAME = 'PUBLICLIABILITY_UW')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Public Liability exceeds Underwriting Manager limit',
    TASK_MESSAGE = 'A transaction has been submitted with public liability coverage that requires Senior Management review.'
WHERE (ACTIVITY_NAME = 'PUBLICLIABILITY_MGMTSR')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Products Liability exceeds Underwriter limit',
    TASK_MESSAGE = 'A transaction has been submitted with products liability coverage that requires Senior Underwriter review.'
WHERE (ACTIVITY_NAME = 'PRODUCTSLIABILITY_UWSR')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Products Liability exceeds Underwriting Manager limit',
    TASK_MESSAGE = 'A transaction has been submitted with products liability coverage that requires Senior Management review.'
WHERE (ACTIVITY_NAME = 'PRODUCTSLIABILITY_MGMTSR')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Money in Locked Safe or Strongroom Outside Business Hours exceeds Broker limit',
    TASK_MESSAGE = 'A transaction has been submitted with money in locked safe or strongroom outside business hours coverage that requires Underwriter review.'
WHERE (ACTIVITY_NAME = 'MONEYLOCKEDSAFE_UW')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Money in Locked Safe or Strongroom Outside Business Hours exceeds Underwriting Manager limit',
    TASK_MESSAGE = 'A transaction has been submitted with money in locked safe or strongroom outside business hours coverage that requires Senior Management review.'
WHERE (ACTIVITY_NAME = 'MONEYLOCKEDSAFE_MGMTSR')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Money on the Premises During Business Hours/Transit exceeds Broker limit',
    TASK_MESSAGE = 'A transaction has been submitted with money on the premises during business hours/transit coverage that requires Underwriter review.'
WHERE (ACTIVITY_NAME = 'MONEYINTRANSIT_UW')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Money on the Premises During Business Hours/Transit exceeds Underwriter limit',
    TASK_MESSAGE = 'A transaction has been submitted with money on the premises during business hours/transit coverage that requires Senior Underwriter review.'
WHERE (ACTIVITY_NAME = 'MONEYINTRANSIT_UWSR')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Goods in Transit exceeds Underwriter limit',
    TASK_MESSAGE = 'A transaction has been submitted with goods in transit coverage that requires Senior Underwriter review.'
WHERE (ACTIVITY_NAME = 'GOODSINTRANSIT_UWSR')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Goods in Transit exceeds Underwriting Manager limit',
    TASK_MESSAGE = 'A transaction has been submitted with goods in transit coverage that requires Senior Management review.'
WHERE (ACTIVITY_NAME = 'GOODSINTRANSIT_MGMTSR')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Food Spoilage exceeds Broker limit',
    TASK_MESSAGE = 'A transaction has been submitted with food spoilage coverage that requires Underwriter review.'
WHERE (ACTIVITY_NAME = 'DETERIORATIONOFSTOCK_UW')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Food Spoilage exceeds Underwriter limit',
    TASK_MESSAGE = 'A transaction has been submitted with food spoilage coverage that requires Senior Underwriter review.'
WHERE (ACTIVITY_NAME = 'DETERIORATIONOFSTOCK_UWSR')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Machinery Breakdown - Electronic Equipment exceeds Broker limit',
    TASK_MESSAGE = 'A transaction has been submitted with machinery breakdown - electronic equipment coverage that requires Underwriter review.'
WHERE (ACTIVITY_NAME = 'MACHINERY_UW')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Machinery Breakdown - Electronic Equipment exceeds Underwriter limit',
    TASK_MESSAGE = 'A transaction has been submitted with machinery breakdown - electronic equipment coverage that requires Senior Underwriter review.'
WHERE (ACTIVITY_NAME = 'MACHINERY_UWSR')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Theft Full Loss exceeds Broker limit',
    TASK_MESSAGE = 'A transaction has been submitted with theft Full Loss coverage that requires Underwriter review.'
WHERE (ACTIVITY_NAME = 'THEFTFULL_UW')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Theft Full Loss exceeds Underwriter limit',
    TASK_MESSAGE = 'A transaction has been submitted with theft Full Loss coverage that requires Senior Underwriter review.'
WHERE (ACTIVITY_NAME = 'THEFTFULL_UWSR')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Theft First Loss exceeds Broker limit',
    TASK_MESSAGE = 'A transaction has been submitted with Theft First Loss coverage that requires Underwriter review.'
WHERE (ACTIVITY_NAME = 'THEFTFIRST_UW')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Theft First Loss exceeds Underwriter limit',
    TASK_MESSAGE = 'A transaction has been submitted with Theft First Loss coverage that requires Senior Underwriter review.'
WHERE (ACTIVITY_NAME = 'THEFTFIRST_UWSR')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Terrorism exceeds Underwriting Manager limit',
    TASK_MESSAGE = 'A transaction has been submitted with Terrorism coverage that requires Senior Management review.'
WHERE (ACTIVITY_NAME = 'TERRORISM_MGMTSR')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Personal Accident exceeds Broker limit',
    TASK_MESSAGE = 'A transaction has been submitted with Personal Accident coverage that requires Underwriter review.'
WHERE (ACTIVITY_NAME = 'PERSONALACCIDENT_UW')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Personal Accident exceeds Underwriter limit',
    TASK_MESSAGE = 'A transaction has been submitted with Personal Accident coverage that requires Senior Underwriter review.'
WHERE (ACTIVITY_NAME = 'PERSONALACCIDENT_UWSR')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Personal Accident exceeds Underwriting Manager limit',
    TASK_MESSAGE = 'A transaction has been submitted with Personal Accident coverage that requires Senior Management review.'
WHERE (ACTIVITY_NAME = 'PERSONALACCIDENT_MGMTSR')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'All Risks (Portable Equipment) exceeds Broker limit',
    TASK_MESSAGE = 'A transaction has been submitted with All Risks coverage that requires Underwriter review.'
WHERE (ACTIVITY_NAME = 'ALLRISKS_UW')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'All Risks (Portable Equipment) exceeds Underwriter limit',
    TASK_MESSAGE = 'A transaction has been submitted with All Risks coverage that requires Senior Underwriter review.'
WHERE (ACTIVITY_NAME = 'ALLRISKS_UWSR')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'All Risks (Portable Equipment) exceeds Underwriting Manager limit',
    TASK_MESSAGE = 'A transaction has been submitted with All Risks coverage that requires Senior Management review.'
WHERE (ACTIVITY_NAME = 'ALLRISKS_MGMTSR')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Section I - Contents exceeds Broker limit',
    TASK_MESSAGE = 'A transaction has been submitted with Section I - Contents that requires Underwriter review.'
WHERE (ACTIVITY_NAME = 'DWELLINGCONTENTS_UW')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Public Liability exceeds Underwriter limit',
    TASK_MESSAGE = 'A transaction has been submitted with public liability coverage that requires Senior Underwriter review.'
WHERE (ACTIVITY_NAME = 'PUBLICLIABILITY_UWSR')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Public Liability exceeds Senior Underwriter limit',
    TASK_MESSAGE = 'A transaction has been submitted with public liability coverage that requires Underwriting Manager review.'
WHERE (ACTIVITY_NAME = 'PUBLICLIABILITY_UWMGR')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Money on the Premises During Business Hours/Transit exceeds Senior Underwriter limit',
    TASK_MESSAGE = 'A transaction has been submitted with money on the premises during business hours/transit coverage that requires Underwriting Manager review.'
WHERE (ACTIVITY_NAME = 'MONEYINTRANSIT_UWMGR')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Money on the Premises During Business Hours/Transit exceeds Underwriting Manager limit',
    TASK_MESSAGE = 'A transaction has been submitted with money on the premises during business hours/transit coverage that requires Senior Management review.'
WHERE (ACTIVITY_NAME = 'MONEYINTRANSIT_MGMTSR')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Goods in Transit exceeds Broker limit',
    TASK_MESSAGE = 'A transaction has been submitted with goods in transit coverage that requires Underwriter review.'
WHERE (ACTIVITY_NAME = 'GOODSINTRANSIT_UW')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Business Interruption exceeds Broker limit',
    TASK_MESSAGE = 'A transaction has been submitted with Business Interruption that requires Underwriter review.'
WHERE (ACTIVITY_NAME = 'BUSINESSINTERRUPT_UW')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Buildings/Rent exceeds Broker limit',
    TASK_MESSAGE = 'A transaction has been submitted with Buildings/Rent that requires Underwriter review.'
WHERE (ACTIVITY_NAME = 'BUILDINGSRENT_UW')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Fire exceeds Underwriter limit',
    TASK_MESSAGE = 'A transaction has been submitted with Fire that requires Senior Underwriter review.'
WHERE (ACTIVITY_NAME = 'FIRE_UWSR')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Fire exceeds Senior Underwriter limit',
    TASK_MESSAGE = 'A transaction has been submitted with Fire that requires Underwriting Manager review.'
WHERE (ACTIVITY_NAME = 'FIRE_UWMGR')^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Fire exceeds Underwriting Manager limit',
    TASK_MESSAGE = 'A transaction has been submitted with Fire that requires Senior Management review.'
WHERE (ACTIVITY_NAME = 'FIRE_MGMTSR')^

COMMIT WORK^

create procedure tmp_delete_unused_task
as
    declare variable var_activity_id integer;
begin
    select activity_id 
    from TASK_ACTIVITY
    where ACTIVITY_NAME = 'MONEYINTRANSIT_UWSR' rows 1
    into :var_activity_id;

    delete from task_activity_groups_link
    where activity_id = :var_activity_id;

    delete from task_activity_rights
    where activity_id = :var_activity_id;

    delete from TASK_ACTIVITY
    where activity_id = :var_activity_id;
end^

execute procedure tmp_delete_unused_task^

commit work^

drop procedure tmp_delete_unused_task^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("201217ML02", "BCSB-1417 - inserting notify on create/complete", "2020-DEC-17");