       identification division.

      *Program:    Final_EditFile
      *Author:     Group 15
      *Date:       March 25th, 2023
      *Comment:    This assignment will sort errors and non-errors.

       program-id. Final_EditFile.

      *
       environment division.
      *
       input-output section.
       file-control.
      *
      *Extract the file to read for the documentation
           select input-file
               assign to "../../../../data/project8.dat"
               organization is line sequential.

      *This is where the file will be output to
           select report-file
               assign to "../../../../output/Error-Report.out"
               organization is line sequential.

      *This is where the file will be output to
           select invalid-data-file
               assign to "../../../../data/Invalid-Data.dat"
               organization is line sequential.

      *This is where the file will be output to
           select valid-data-file
               assign to "../../../../data/Valid-Data.dat"
               organization is line sequential.

      *
       data division.
       file section.
       fd input-file
           data record is input-rec
           record contains 36 characters.
      *
      *This is the input information to be extracted
       01 input-rec.
           05 ir-trans-code              pic x.
               88 input-trans-valid      value 'L', 'R', 'S'.
           05 ir-trans-amt               pic 9(5)V99.
           05 ir-payment-type            pic xx.
               88 input-type-valid       value 'CA', 'CR', 'DB'.
           05 ir-store-num               pic 99.
               88 input-num-valid        value 01, 02, 03, 04, 05, 12.
           05 ir-invoice-num1            pic x.
               88 input-valid-1          value 'A', 'B', 'C', 'D', 'E'.
           05 ir-invoice-num2            pic x.
               88 input-valid-2          value 'A', 'B', 'C', 'D', 'E'.
           05 ir-invoice-dash            pic x.
               88 input-valid-inv1       value '-'.
           05 ir-invoice-valid-nums      pic 9(6).
               88 input-inva-nums-low    value 0 thru 99999.
               88 input-valid-nums       value 100000 thru 900000.
               88 input-inva-nums-high   value 900001 thru 999999.
           05 ir-Sku-Code                pic x(15).
      *

      *This is your Output line
       fd report-file
           data record is report-line
           record contains 89 characters.
      *
       01 report-line                  pic x(89).

      *If file is not valid. This file will store the information
       fd invalid-data-file
           data record is invalid-data-line
           record contains 36 characters.
      *
       01 invalid-data-line            pic x(36).

      *If File is Valid. This file will store the information
       fd valid-data-file
           data record is valid-data-line
           record contains 36 characters.
      *
       01 valid-data-line              pic x(36).

      *
       working-storage section.
      *
      *Username Heading of the entire file
       01 ws-heading-main-title.   
           05 filler                   pic x(27)   value
                                         "Group 15 - Final Assignment".
           05 filler                   pic x(3)    value " - ".
           05 filler                   pic x(59).

       01 ws-heading-names.
           05 filler                   pic x(8)    value "Members:".
           05 filler                   pic x       value space.
           05 filler                   pic x(29)   value
                                       "Martin Barber, Robert Savoie,".
           05 filler                   pic x(30)   value
                                       " Alex Blackmore, Rhys Thompson".
           05 filler                   pic x(21).
      *

      *Main Title
       01 ws-heading-title.
           05 filler                   pic x(32)   value spaces.
           05 filler                   pic x(19)   value
                                       "Invalid Report".
           05 filler                   pic x(24)   value spaces.
           05 filler                   pic x(14)   value spaces.

      *

      *Heading row 1
       01 ws-Header1.
           05 filler                     pic x(5)  value "Error".
           05 filler                     pic x(4)  value spaces.
           05 filler                     pic x(11) value "Transaction".
           05 filler                     pic x(2)  value spaces.
           05 filler                     pic x(11) value "Transaction".
           05 filler                     pic x(3)  value spaces.
           05 filler                     pic x(7)  value "Payment".
           05 filler                     pic x(4)  value spaces.
           05 filler                     pic x(5)  value "Store".
           05 filler                     pic x(5)  value spaces.
           05 filler                     pic x(7)  value "Invoice".
           05 filler                     pic x(12) value spaces.
           05 filler                     pic x(6)  value "SKU".
           05 filler                     pic x(1)  value spaces.

       01 ws-Header2.
           05 filler                     pic x(6)  value "Number".
           05 filler                     pic x(6)  value spaces.
           05 filler                     pic x(4)  value "Code".
           05 filler                     pic x(8)  value spaces.
           05 filler                     pic x(6)  value "Amount".
           05 filler                     pic x(7)  value spaces.
           05 filler                     pic x(4)  value "Type".
           05 filler                     pic x(7)  value spaces.
           05 filler                     pic x(6)  value "Num".
           05 filler                     pic x(3)  value spaces.
           05 filler                     pic x(6)  value "Number".
           05 filler                     pic x(13) value spaces.
           05 filler                     pic x(4)  value "Code".

       01 ws-Display-Errors.
           05 filler                     pic x(2)  value spaces.
           05 ws-disp-error-num          pic ZZ9.
           05 filler                     pic x(9)  value spaces.
           05 ws-Err-trans-code          pic x.
           05 ws-code-star               pic x.
           05 filler                     pic x(7)  value spaces.
           05 ws-trans-amt               pic x(7).
           05 ws-trans-amt-star          pic x.
           05 filler                     pic x(5)  value spaces.
           05 ws-pay-type                pic xx.
           05 ws-pay-star                pic x.
           05 filler                     pic x(7)  value spaces.
           05 ws-store-num               pic 99.
           05 ws-store-star              pic x.
           05 filler                     pic x(5)  value spaces.
           05 ws-Inv-num1                pic x.
           05 ws-Inv-num2                pic x.
           05 ws-Inv-dash                pic x.
           05 ws-Inv-num3                pic 9(6).
           05 ws-Inv-star                pic x.
           05 filler                     pic x(5)  value spaces.
           05 ws-Sku-Code                pic x(15).
           05 ws-sku-star                pic x.

       01 ws-Display-Error-Msg.
           05 filler                     pic x(18) value spaces.
           05 filler                     pic x     value "-".
           05 filler                     pic x     value space.
           05 ws-error-desc              pic x(49).
           05 filler                     pic x(20) value spaces.

       01 ws-error-notifications.
           05 ws-notify-tran-code        pic 9     value 0.
           05 ws-notify-tran-amt         pic 9     value 0.
           05 ws-notify-pay-type         pic 9     value 0.
           05 ws-notify-store-num        pic 9     value 0.
           05 ws-notify-inv1             pic 9     value 0.
           05 ws-notify-inv2             pic 9     value 0.
           05 ws-notify-inv-dash         pic 9     value 0.
           05 ws-notify-inv-dbl          pic 9     value 0.
           05 ws-notify-inv-num          pic 9     value 0.
           05 ws-notify-sku              pic 9     value 0.

       01 ws-counters.
           05 ws-total-records           pic 999   value 000.
           05 ws-total-invalid           pic 999   value 000.
           05 ws-total-valid             pic 999   value 000.
           05 ws-counter                 pic 99.
           05 ws-error-num               pic 999   value 000.

      *CONSTANTS
       77 ws-per-page                    pic 99    value 10.
       77 ws-Err-Tran-Code               pic x(26) value
                                         "INCORRECT TRANSACTION CODE".
       77 ws-Err-Trans-Amt               pic x(47) value
                       "TRANSACTION AMT NOT NUMERIC. THERE IS A LETTER".
       77 ws-Err-Pay-Type                pic x(18) value
                                         "WRONG PAYMENT TYPE".
       77 ws-Err-Store-Num               pic x(18) value
                                         "WRONG STORE NUMBER".
       77 ws-Err-Inv-Let1                pic x(45) value
                        "FIRST INVOICE NUMBER MUST BE A CORRECT LETTER".
       77 ws-Err-Inv-Let2                pic x(46) value
                       "SECOND INVOICE NUMBER MUST BE A CORRECT LETTER".
       77 ws-Err-Inv-Dash                pic x(35) value
                                  "THIRD INVOICE NUMBER MUST BE A DASH".
       77 ws-Err-Inv-Double              pic x(33) value
                                    "FIRST 2 LETTERS MUST BE DIFFERENT".
       77 ws-Err-Inv-Num                 pic x(28) value
                                         "INVOICE NUMBER INCORRECT".
       77 ws-Err-SKU                     pic x(25) value
                                         "SKU CODE CAN NOT BE EMPTY".

      *End of File Flags
       77 ws-eof-flag                    pic x     value "n".
       77 ws-eof-Y                       pic x     value "y".
       77 ws-eof-N                       pic x     value "n".

       01 ws-Final-Display-Info.
           05 ws-Records.
               10 filler                 pic x(16) value
                                         "Records Checked".
               10 filler                 pic x(8)  value spaces.
               10 filler                 pic x     value "-".
               10 filler                 pic x     value space.
               10 ws-Records-count       pic ZZ9.
               10 filler                 pic x(60) value spaces.

           05 ws-Valid.
               10 filler                 pic x(13) value
                                         "Valid Records".
               10 filler                 pic x(11) value spaces.
               10 filler                 pic x     value "-".
               10 filler                 pic x     value space.
               10 ws-Valid-Count         pic ZZ9.
               10 filler                 pic x(60) value spaces.

           05 ws-Invalid.
               10 filler                 pic x(15) value
                                         "Invalid Records".
               10 filler                 pic x(9)  value spaces.
               10 filler                 pic x     value "-".
               10 filler                 pic x     value space.
               10 ws-Invalid-Count       pic ZZ9.
               10 filler                 pic x(60) value spaces.


       procedure division.
       000-main.

           perform 50-Open-Files.
           perform 150-Write-Name-Header.
           perform 100-Read-Page-Line.
           perform 200-Write-Header.
           perform 400-Validate-All-Records
             until ws-eof-flag equals ws-eof-Y.
           write report-line from spaces.

           perform 700-Print-Final-Count.
           perform 800-Close-Files.

           goback.

      *************************************************************
       50-Open-Files.
           open input input-file.
           open output report-file.
           open output invalid-data-file.
           open output valid-data-file.
           move ws-eof-N to ws-eof-flag.

      *************************************************************

      *This will store the input line to a Invalid file
       65-Store-Invalid-File.
           move input-rec to invalid-data-line.
           write invalid-data-line.

      *************************************************************

      *This will store the input line to a valid file
       80-Store-Valid-File.
           move input-rec to valid-data-line.
           write valid-data-line.

      *************************************************************

      *This will read the next line in the file
       100-Read-Page-Line.
           read input-file
               at end
                   move ws-eof-Y to ws-eof-flag.

      *************************************************************

      *This will write my name at the top of the report.
       150-Write-Name-Header.
           write report-line from spaces.
           move ws-heading-main-title  to report-line.
           write report-line.
           move ws-heading-names       to report-line
           write report-line before advancing 2 lines.

      *************************************************************

      *THis will write the header
       200-Write-Header.
           write report-line from ws-heading-title before advancing 2
             lines.
           write report-line from ws-Header1.
           write report-line from ws-Header2 before advancing 2 lines.

      *************************************************************

      *This will print all the information for the pages display.
       300-Print-Information.

      **************************************************************

      *Run all the checks for all the different errors that can occur.
       400-Validate-All-Records.
      *    MOVE DATA TO DISPLAY LINE
           add 1 to ws-total-records.
           perform 450-Move-Data-Over.
      *    VALIDATION CHECKS
           perform 500-Check-Trans-Code.
           perform 510-Check-Trans-Amt.
           perform 520-Check-Pay-Type.
           perform 530-Check-Store-Number.
           perform 540-Check-All-Inv.
           perform 550-Check-SKU.
           perform 600-Check-If-An-Error.
           perform 100-Read-Page-Line.

      **************************************************************

       450-Move-Data-Over.
           move ir-trans-code          to ws-Err-trans-code.
           move ir-trans-amt           to ws-trans-amt.
           move ir-payment-type        to ws-pay-type.
           move ir-store-num           to ws-store-num.
           move ir-invoice-num1        to ws-Inv-num1.
           move ir-invoice-num2        to ws-Inv-num2.
           move ir-invoice-dash        to ws-Inv-dash.
           move ir-invoice-valid-nums  to ws-Inv-num3.
           move ir-Sku-Code            to ws-Sku-Code.


      *Check Transaction Code
       500-Check-Trans-Code.
           if input-trans-valid then
               move 0      to ws-notify-tran-code
               move spaces to ws-code-star
           else
               move 1      to ws-notify-tran-code
               move "*"    to ws-code-star
           end-if.


      **************************************************************

      *Check Transaction Amount
       510-Check-Trans-Amt.
           if ir-trans-amt is numeric
               move 0      to ws-notify-tran-amt
               move spaces to ws-trans-amt-star
           else
               move 1      to ws-notify-tran-amt
               move "*"    to ws-trans-amt-star
           end-if.


      **************************************************************

      *Check the Payment Type
       520-Check-Pay-Type.
           if input-type-valid then
               move 0      to ws-notify-pay-type
               move spaces to ws-pay-star
           else
               move 1      to ws-notify-pay-type
               move "*"    to ws-pay-star
           end-if.

      **************************************************************

      *Check if the store number is Valid
       530-Check-Store-Number.
           if input-num-valid then
               move 0      to ws-notify-store-num
               move spaces to ws-store-star
           else
               move 1      to ws-notify-store-num
               move "*"    to ws-store-star
           end-if.


      **************************************************************

      *Check the first Inventory Number
       540-Check-All-Inv.
      *CHECK SEPERATELY TO GET ALL ERRORS
           if not input-valid-1 then
               move 1      to ws-notify-inv1
           else
               move 0      to ws-notify-inv1
           end-if.

           if not input-valid-2 then
               move 1      to ws-notify-inv2
           else
               move 0      to ws-notify-inv2
           end-if.

           if not input-valid-inv1 then
               move 1      to ws-notify-inv-dash
           else
               move 0      to ws-notify-inv-dash
           end-if.

           if ir-invoice-num1 = ir-invoice-num2 then
               move 1      to ws-notify-inv-dbl
           else
               move 0      to ws-notify-inv-dbl
           end-if.

           if input-inva-nums-low or input-inva-nums-high or 
             ir-invoice-valid-nums not numeric then
               move 1      to ws-notify-inv-num
           else
               move 0      to ws-notify-inv-num
           end-if.

           if ws-notify-inv1 = 1       or ws-notify-inv2 = 1    or
             ws-notify-inv-dash = 1    or ws-notify-inv-dbl = 1 or
             ws-notify-inv-num = 1 then
               move "*"    to ws-Inv-star
           end-if.

           if ws-notify-inv1 = 0    and ws-notify-inv2 = 0     and
             ws-notify-inv-dash = 0 and ws-notify-inv-dbl = 0  and
             ws-notify-inv-num = 0 then
               move space  to ws-Inv-star
           end-if.
 

      **************************************************************


      *Checking if the Sku exists or is blank.
       550-Check-SKU.
           if ir-Sku-Code equals spaces then
               move 1      to ws-notify-sku
               move "*"    to ws-sku-star
           else
               move 0      to ws-notify-sku
               move spaces to ws-sku-star
           end-if.

      **************************************************************

       600-Check-If-An-Error.
           perform 625-Check-If-Valid.
           perform 650-Check-If-Invalid.

      **************************************************************

       625-Check-If-Valid.
           if ws-notify-tran-code = 0  and ws-notify-tran-amt = 0  and
             ws-notify-pay-type = 0    and ws-notify-store-num = 0 and
             ws-notify-inv1 = 0        and ws-notify-inv2 = 0      and
             ws-notify-inv-dash = 0    and ws-notify-inv-dbl = 0   and
             ws-notify-inv-num = 0     and ws-notify-sku = 0       then
      *        VALID CHECK
               perform 80-Store-Valid-File
               add 1 to ws-total-valid
               subtract 1 from ws-counter
           end-if.

      **************************************************************

       650-Check-If-Invalid.
           if ws-notify-tran-code = 1  or ws-notify-tran-amt = 1   or
             ws-notify-pay-type = 1    or ws-notify-store-num = 1  or
             ws-notify-inv1 = 1        or ws-notify-inv2 = 1       or
             ws-notify-inv-dash = 1    or ws-notify-inv-dbl = 1    or
             ws-notify-inv-num = 1     or ws-notify-sku = 1        then
      *        INVALID CHECK
               perform 65-Store-Invalid-File
               add 1             to ws-total-invalid
               add 1             to ws-error-num
               move ws-error-num to ws-disp-error-num
               write report-line from ws-Display-Errors after advancing
                 1 line
               perform 675-Print-All-Errors
           end-if.

      **************************************************************

       675-Print-All-Errors.
           if ws-notify-tran-code = 1 then
               move ws-Err-Tran-Code to ws-error-desc
               write report-line from ws-Display-Error-Msg
           end-if.

           if ws-notify-tran-amt = 1 then
               move ws-Err-Trans-Amt to ws-error-desc
               write report-line from ws-Display-Error-Msg
           end-if.

           if ws-notify-pay-type = 1 then
               move ws-Err-Pay-Type    to ws-error-desc
               write report-line from ws-Display-Error-Msg
           end-if.

           if ws-notify-store-num = 1 then
               move ws-Err-Store-Num   to ws-error-desc
               write report-line from ws-Display-Error-Msg
           end-if.

           if ws-notify-inv1 = 1 then
               move ws-Err-Inv-Let1    to ws-error-desc
               write report-line from ws-Display-Error-Msg
           end-if.

           if ws-notify-inv2 = 1 then
               move ws-Err-Inv-Let2    to ws-error-desc
               write report-line from ws-Display-Error-Msg
           end-if.

           if ws-notify-inv-dash = 1 then
               move ws-Err-Inv-Dash    to ws-error-desc
               write report-line from ws-Display-Error-Msg
           end-if.

           if ws-notify-inv-dbl = 1 then
               move ws-Err-Inv-Double  to ws-error-desc
               write report-line from ws-Display-Error-Msg
           end-if.

           if ws-notify-inv-num = 1 then
               move ws-Err-Inv-Num     to ws-error-desc
               write report-line from ws-Display-Error-Msg
           end-if.

           if ws-notify-sku = 1 then
               move ws-Err-SKU         to ws-error-desc
               write report-line from ws-Display-Error-Msg
           end-if.

      **************************************************************

      *This will print all the final counts for the entire report
       700-Print-Final-Count.
           move ws-total-records   to ws-Records-count.
           move ws-total-valid     to ws-Valid-Count.
           move ws-total-invalid   to ws-Invalid-Count.

           move "----------------" to report-line.
           write report-line.

           write report-line from ws-Records   before advancing 2 lines.
           write report-line from ws-Valid     before advancing 2 lines.
           write report-line from ws-Invalid   before advancing 2 lines.

      **************************************************************

      *This will close the files
       800-Close-Files.
           close input-file.
           close report-file.
           close valid-data-file.
           close invalid-data-file.

      **************************************************************

       end program Final_EditFile.