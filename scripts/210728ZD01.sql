update question
   set ANSWER_LIST = "[{'Selected': true, 'Text': '-- Select --', 'Value': '' }, {'Selected': false, 'Text': 'Balzan (whole locality)', 'Value': 'BALZAN' }, {'Selected': false, 'Text': 'Valley Road / Triq Il-Wied at Birkirkara / B\'Kara and Msida', 'Value': 'VALLEY_ROAD' }, {'Selected': false, 'Text': 'The Strand / Triq Ix-Xatt at Ta\' Xbiex and Gzira', 'Value': 'STRAND' }, {'Selected': false, 'Text': 'Spinola Bay area i.e. St. George\'s Road / Triq San Gorg and George Borg Olivier Street / Troq Gorg Borg Olivier at St. Julians / San Giljan', 'Value': 'SPINOLA' }, {'Selected': false, 'Text': 'Triq ix-Xatt and Triq iz-Zonqor / Zonqor Road at Marsaskala / M\'Skala', 'Value': 'TRIQ_IX' }, {'Selected': false, 'Text': 'St George\'s Street / Triq San Gorg at Birzebbugia / B\'Bugia', 'Value': 'ST_GEORGE' }, {'Selected': false, 'Text': 'Xatt is-Sajjieda at Marsaxlokk / M\'Xlokk', 'Value': 'XATT_IS' }, {'Selected': false, 'Text': 'Xatt il-Pwales / Triq il-Pwales / Pwales Road at Xemxija forming part of San Pawl il-Bahar / St. Paul\'s Bay ', 'Value': 'XATT_IL' }, {'Selected': true, 'Text': 'No', 'Value': 'NONE' }]"
 where name = "LOCATED";

update question
   set text = "<hr class='mb-0'>"
 where name = "PAGE_BREAK";

insert into applied_scripts (name, description, script_date)
     values ("210728ZD01", "MHM-327 Changed wording of none answer", "2021-JUL-28");
commit work;