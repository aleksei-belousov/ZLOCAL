FUNCTION Z_HELLO.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"----------------------------------------------------------------------
DATA X(20) TYPE C VALUE 'Hello, World!'.
X = 'Hello, ABAP!'.

DATA P1 TYPE P.
DATA P2 TYPE P.
DATA P3 TYPE P.
DATA S(20) TYPE C.
P1 = 2.
P2 = 2.
P3 = P1 * P2. " As a result P3 should be equal to 4
S = 'Hello, World!'.

DATA it_tab TYPE TABLE OF I_COMPANYCODE.
DATA wa_tab TYPE I_COMPANYCODE.

SELECT * FROM I_COMPANYCODE INTO TABLE @it_tab.
LOOP AT it_tab INTO wa_tab.
ENDLOOP.

*Use of Table MARA is not permitted. See object documentation for replacement.
*DATA it_mara TYPE TABLE OF mara.
*SELECT * FROM mara INTO TABLE it_mara.
* yet you can see mara structure by clicking on "mara" and pressing <f2>

* This variant of the command "MESSAGE" is not allowed in the restricted language scope.
*MESSAGE 'Hello, World!' TYPE 'S'.

* This variant of the command "WRITE" is not allowed in the restricted language scope.
*WRITE 'Hello, World'.

ENDFUNCTION.
