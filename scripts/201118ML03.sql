set term ^;

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Glass exceeds Broker limit',
    TASK_MESSAGE = 'An application has been submitted with glass coverage that requires Underwriter review.',
    ACTIVITY_NAME = 'GLASS_UW'
WHERE activity_name = 'GLASS_10K'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Glass exceeds Underwriter limit',
    TASK_MESSAGE = 'An application has been submitted with glass coverage that requires Senior Underwriter review.',
    ACTIVITY_NAME = 'GLASS_UWSR'
WHERE activity_name = 'GLASS_25K'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Glass exceeds Senior Underwriter limit',
    TASK_MESSAGE = 'An application has been submitted with glass coverage that requires Senior Management review.',
    ACTIVITY_NAME = 'GLASS_MGMTSR'
WHERE activity_name = 'GLASS_175K'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Employer''s Liability exceeds Senior Underwriter limit',
    TASK_MESSAGE = 'An application has been submitted with employer''s liability coverage that requires Senior Management review.'
WHERE activity_name = 'EMPLOYERLIABILITY_MGMTSR'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Employer''s Liability aggregate exceeds Senior Underwriter limit',
    TASK_MESSAGE = 'An application has been submitted with employer''s liability coverage that requires Senior Management review.'
WHERE activity_name = 'EMPLOYERLIABILITYAGGREGATE_MGMTSR'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Public Liability exceeds Broker limit',
    TASK_MESSAGE = 'An application has been submitted with public liability coverage that requires Underwriter review.'
WHERE activity_name = 'PUBLICLIABILITY_UW'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Public Liability exceeds Senior Underwriter limit',
    TASK_MESSAGE = 'An application has been submitted with public liability coverage that requires Senior Management review.'
WHERE activity_name = 'PUBLICLIABILITY_MGMTSR'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Products Liability exceeds Underwriter limit',
    TASK_MESSAGE = 'An application has been submitted with products liability coverage that requires Senior Underwriter review.'
WHERE activity_name = 'PRODUCTSLIABILITY_UWSR'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Products Liability exceeds Senior Underwriter limit',
    TASK_MESSAGE = 'An application has been submitted with products liability coverage that requires Senior Management review.'
WHERE activity_name = 'PRODUCTSLIABILITY_MGMTSR'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Money in Locked Safe or Strongroom Outside Business Hours exceeds Broker limit',
    TASK_MESSAGE = 'An application has been submitted with money in locked safe or strongroom outside business hours coverage that requires Underwriter review.'
WHERE activity_name = 'MONEYLOCKEDSAFE_UW'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Money in Locked Safe or Strongroom Outside Business Hours exceeds Senior Underwriter limit',
    TASK_MESSAGE = 'An application has been submitted with money in locked safe or strongroom outside business hours coverage that requires Senior Management review.'
WHERE activity_name = 'MONEYLOCKEDSAFE_MGMTSR'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Money on the Premises During Business Hours/Transit exceeds Broker limit',
    TASK_MESSAGE = 'An application has been submitted with money on the premises during business hours/transit coverage that requires Underwriter review.'
WHERE activity_name = 'MONEYINTRANSIT_UW'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Money on the Premises During Business Hours/Transit exceeds Underwriter limit',
    TASK_MESSAGE = 'An application has been submitted with money on the premises during business hours/transit coverage that requires Senior Underwriter review.'
WHERE activity_name = 'MONEYINTRANSIT_UWSR'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Goods in Transit exceeds Underwriter limit',
    TASK_MESSAGE = 'An application has been submitted with goods in transit coverage that requires Senior Underwriter review.'
WHERE activity_name = 'GOODSINTRANSIT_UWSR'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Goods in Transit exceeds Senior Underwriter limit',
    TASK_MESSAGE = 'An application has been submitted with goods in transit coverage that requires Senior Management review.'
WHERE activity_name = 'GOODSINTRANSIT_MGMTSR'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Food Spoilage exceeds Broker limit',
    TASK_MESSAGE = 'An application has been submitted with food spoilage coverage that requires Underwriter review.'
WHERE activity_name = 'DETERIORATIONOFSTOCK_UW'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Food Spoilage exceeds Underwriter limit',
    TASK_MESSAGE = 'An application has been submitted with food spoilage coverage that requires Senior Underwriter review.'
WHERE activity_name = 'DETERIORATIONOFSTOCK_UWSR'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Machinery Breakdown - Electronic Equipment exceeds Broker limit',
    TASK_MESSAGE = 'An application has been submitted with machinery breakdown - electronic equipment coverage that requires Underwriter review.'
WHERE activity_name = 'MACHINERY_UW'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Machinery Breakdown - Electronic Equipment exceeds Underwriter limit',
    TASK_MESSAGE = 'An application has been submitted with machinery breakdown - electronic equipment coverage that requires Senior Underwriter review.'
WHERE activity_name = 'MACHINERY_UWSR'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Theft Full Loss exceeds Broker limit',
    TASK_MESSAGE = 'An application has been submitted with theft Full Loss coverage that requires Underwriter review.'
WHERE activity_name = 'THEFTFULL_UW'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Theft Full Loss exceeds Underwriter limit',
    TASK_MESSAGE = 'An application has been submitted with theft Full Loss coverage that requires Senior Underwriter review.'
WHERE activity_name = 'THEFTFULL_UWSR'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Theft First Loss exceeds Broker limit',
    TASK_MESSAGE = 'An application has been submitted with Theft First Loss coverage that requires Underwriter review.'
WHERE activity_name = 'THEFTFIRST_UW'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Theft First Loss exceeds Underwriter limit',
    TASK_MESSAGE = 'An application has been submitted with Theft First Loss coverage that requires Senior Underwriter review.'
WHERE activity_name = 'THEFTFIRST_UWSR'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Terrorism exceeds Senior Underwriter limit',
    TASK_MESSAGE = 'An application has been submitted with Terrorism coverage that requires Senior Management review.'
WHERE activity_name = 'TERRORISM_MGMTSR'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Personal Accident exceeds Broker limit',
    TASK_MESSAGE = 'An application has been submitted with Personal Accident coverage that requires Underwriter review.'
WHERE activity_name = 'PERSONALACCIDENT_UW'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Personal Accident exceeds Underwriter limit',
    TASK_MESSAGE = 'An application has been submitted with Personal Accident coverage that requires Senior Underwriter review.'
WHERE activity_name = 'PERSONALACCIDENT_UWSR'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'Personal Accident exceeds Senior Underwriter limit',
    TASK_MESSAGE = 'An application has been submitted with Personal Accident coverage that requires Senior Management review.'
WHERE activity_name = 'PERSONALACCIDENT_MGMTSR'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'All Risks (Portable Equipment) exceeds Broker limit',
    TASK_MESSAGE = 'An application has been submitted with All Risks coverage that requires Underwriter review.'
WHERE activity_name = 'ALLRISKS_UW'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'All Risks (Portable Equipment) exceeds Underwriter limit',
    TASK_MESSAGE = 'An application has been submitted with All Risks coverage that requires Senior Underwriter review.'
WHERE activity_name = 'ALLRISKS_UWSR'^

UPDATE TASK_ACTIVITY SET 
    TASK_TITLE = 'All Risks (Portable Equipment) exceeds Senior Underwriter limit',
    TASK_MESSAGE = 'An application has been submitted with All Risks coverage that requires Senior Management review.'
WHERE activity_name = 'ALLRISKS_MGMTSR'^

COMMIT WORK;

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("201118ML03", "RT-178 - auth rule cleanup", "2020-NOV-18");