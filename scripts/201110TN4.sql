
SET TERM ^;


CREATE PROCEDURE INSERTCOMPANY
AS
    DECLARE VARIABLE BOOK_ID  INTEGER;
    DECLARE VARIABLE STATE    VARCHAR(10);
    DECLARE VARIABLE LINE     VARCHAR(10);
BEGIN
    SELECT MIN(BOOK_ID) FROM RATE_BOOK INTO :BOOK_ID;

    for SELECT DISTINCT REF_KEY, STATE
          FROM REF_TABLE
         WHERE REF_CODE = 'LINE'
           AND STATE <> 'XX'
           AND REF_KEY in ('RP', 'OP', 'SP')
    into :line, :state
    do begin
        INSERT INTO COMPANY
            (CONTROL_KEY,ENTRY_TYPE,STATE,ENTRY_DESC,CHAR_DATA,NUM_DATA,EFFECTIVE,CONTEXT_ID,LINE,CONTROL_TYPE,REPORTNAME,INVREPORTNAME,EXPIRED_DATE,BOOK_ID,COMPANY_ID,STATUS)
        VALUES
            ('TABLE','QUOTEDAYS',:state,'Quote effective date range by role','',0,'01/01/2001',0,:line,'N',NULL,NULL,'12/31/9999',:BOOK_ID,gen_id(COMPANY_ID_GEN,1),'');
        INSERT INTO COMPANY
            (CONTROL_KEY,ENTRY_TYPE,STATE,ENTRY_DESC,CHAR_DATA,NUM_DATA,NUMDATA2,EFFECTIVE,CONTEXT_ID,LINE,CONTROL_TYPE,REPORTNAME,INVREPORTNAME,EXPIRED_DATE,BOOK_ID,COMPANY_ID,STATUS)
        VALUES
            ('QUOTEDAYS','UW',:state,'Underwriter valid effective days','01/01/2017',365,365,'01/01/2001',0,:line,'N',NULL,NULL,'12/31/9999',:BOOK_ID,gen_id(COMPANY_ID_GEN,1),'');
        INSERT INTO COMPANY
            (CONTROL_KEY,ENTRY_TYPE,STATE,ENTRY_DESC,CHAR_DATA,NUM_DATA,NUMDATA2,EFFECTIVE,CONTEXT_ID,LINE,CONTROL_TYPE,REPORTNAME,INVREPORTNAME,EXPIRED_DATE,BOOK_ID,COMPANY_ID,STATUS)
        VALUES
            ('QUOTEDAYS','AG',:state,'Agent valid effective days','01/01/2017',30,180,'01/01/2001',0,:line,'N',NULL,NULL,'12/31/9999',:BOOK_ID,gen_id(COMPANY_ID_GEN,1),'');
    end

END^

COMMIT^

EXECUTE PROCEDURE INSERTCOMPANY^

COMMIT^

DROP PROCEDURE INSERTCOMPANY^

COMMIT^

INSERT INTO applied_scripts(NAME, DESCRIPTION, SCRIPT_DATE)
VALUES ("201110TN4", "Prevent quotes for invalid date", "11/10/2020")^
SET TERM ;^
COMMIT WORK;