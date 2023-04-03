      * -----------------------
       IDENTIFICATION DIVISION.
       PROGRAM-ID. Final_Data_Split_Count.
       AUTHOR. Alex Blackmore.
       DATE-WRITTEN. 03-31-2023.

      * -----------------------
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      * Input file
           select input-file
               assign to "../../../../data/Valid-Data.dat"
                   organization is line sequential.

      * Outout s&l records
           select s-l-file
               assign to "../../../../data/S-L-Data.dat"
                   organization is line sequential.

      * Output return records
           select return-file
               assign to "../../../../data/Return-Data.dat"
                   organization is line sequential.

      * Output report
           select report-file
               assign to "../../../../output/Counts-Control-Totals.out"
                   organization is line sequential.

      * -----------------------
       DATA DIVISION.
       FILE SECTION.
      * Input file declaration
       fd input-file
           data record is input-line
               record contains 36 characters.

      * Input line
       01 input-line.
           05 il-trans-code                 pic x.
               88 il-trans-s-l              value 'S', 'L'.
               88 il-trans-s                value 'S'.
               88 il-trans-l                value 'L'.
               88 il-trans-r                value 'R'.
           05 il-trans-amt                  pic 9(5)V99.
           05 il-payment-type               pic xx.
               88 il-card                   value 'CA'.
               88 il-credit                 value 'CR'.
               88 il-debit                  value 'DB'.
           05 il-store-num                  pic 99.
               88 il-store-1                value 01.
               88 il-store-2                value 02.
               88 il-store-3                value 03.
               88 il-store-4                value 04.
               88 il-store-5                value 05.
               88 il-store-12               value 12.
           05 il-invoice-num1               pic x.
           05 il-invoice-num2               pic x.
           05 il-invoice-dash               pic x.
           05 il-invoice-valid-nums         pic 9(6).
           05 il-Sku-Code                   pic x(15).

      * S&L output file declaration
       fd s-l-file
           data record is sl-line
               record contains 36 characters.

      * sl-report-line
       01 sl-line                           pic x(36).

      * Returns output file declaration
       fd return-file
           data record is return-line
               record contains 36 characters.

      * Return line
       01 return-line                       pic x(36).

      * Report file declaration
       fd report-file
           data record is report-line
               record contains 89 characters.

      * Output line
       01 report-line                       pic x(89).

      * -----------------------
       WORKING-STORAGE SECTION.
      * Program headers
       01 ws-report-header-1.
           05 filler                        pic x(8)       value 
                                                "Group 15".
           05 filler                        pic xxx        value   
                                                " - ".
           05 filler                        pic x(5)       value 
                                                "Final".
           05 filler                        pic x          value
                                                spaces.
           05 filler                        pic x(10)      value
                                                "Assignment".

       01 ws-report-header-2.
           05 filler                        pic x(8)       value 
                                                "Members:".
           05 filler                        pic x          value
                                                spaces.
           05 filler                        pic x(15)      value
                                                "Martin Barber, ".
           05 filler                        pic x(15)      value
                                                "Robert Savoie, ".
           05 filler                        pic x(16)      value
                                                "Alex Blackmore, ".
           05 filler                        pic x(13)      value
                                                "Rhys Thompson".

       01 ws-report-header-3.
           05 filler                        pic x(12)      value   
                                                spaces.
           05 filler                        pic x(7)       value 
                                                "Counts ".
           05 filler                        pic x(4)       value   
                                                "and ".
           05 filler                        pic x(8)       value 
                                                "Control ".
           05 filler                        pic x(6)       value 
                                                "Total ".
           05 filler                        pic x(6)       value 
                                                "Report".

       01 ws-report-header-4.
           05 filler                        pic xx         value   
                                                spaces.
           05 filler                        pic x(5)       value 
                                                "Sales".
           05 filler                        pic xxx        value   
                                                " & ".
           05 filler                        pic x(7)       value 
                                                "Layaway".

      * S & L output
       01 ws-sl-totals-1.
           05 filler                        pic x(6)           value 
                                                spaces.
           05 filler                        pic x(20)          value
                                                "Total S&L Records = ".
           05 sl-records                    pic 99             value   
                                                0.
           05 filler                        pic x(10)          value 
                                                spaces.
           05 filler                        pic x(20)          value
                                                "Total S&L Amount  = ".
           05 sl-amount                     pic ZZ,ZZZ,ZZ9.99  value
                                                0.

      * S output
       01 ws-s-totals.
           05 filler                        pic x(6)           value 
                                                spaces.
           05 filler                        pic x(20)          value
                                                "Total S Records   = ".
           05 s-records                     pic 99             value    
                                                0.
           05 filler                        pic x(10)          value 
                                                spaces.
           05 filler                        pic x(20)          value
                                                "Total S Amount    = ".
           05 s-amount                      pic ZZ,ZZZ,ZZ9.99 value
                                                0.

      * L output
       01 ws-l-totals.
           05 filler                        pic x(6)           value 
                                                spaces.
           05 filler                        pic x(20)          value
                                                "Total L Records   = ".
           05 l-records                     pic 99             value   
                                                0.
           05 filler                        pic x(10)          value 
                                                spaces.
           05 filler                        pic x(20)          value
                                                "Total L Amount    = ".
           05 l-amount                      pic ZZ,ZZZ,ZZ9.99  value   
                                                0.

      * S & L store output

      * Flags
       01 ws-flags.
           05 ws-eof                        pic x          value "N".
           05 ws-eof-Y                      pic x          value "Y".
           05 ws-eof-N                      pic x          value "N".

      * Totals
       01 ws-totals.
      * Record Counters
           05 ws-total-s-l                  pic 99             value 0.
           05 ws-total-s                    pic 99             value 0.
           05 ws-total-l                    pic 99             value 0.
           05 ws-total-r                    pic 99             value 0.

      * Amount Totals
           05 ws-total-s-l-amount           pic 9(8)v99        value 0.
           05 ws-total-s-amount             pic 9(8)v99        value 0.
           05 ws-total-l-amount             pic 9(8)v99        value 0.
           05 ws-total-r-amount             pic 9(8)v99        value 0.

      * Store record totals
           05 ws-total-01-records           pic 99             value 0.
           05 ws-total-02-records           pic 99             value 0.
           05 ws-total-03-records           pic 99             value 0.
           05 ws-total-04-records           pic 99             value 0.
           05 ws-total-05-records           pic 99             value 0.
           05 ws-total-12-records           pic 99             value 0.

      * Store Amount Totals
           05 ws-total-sl-01-amount         pic 9(8)v99        value 0.
           05 ws-total-sl-02-amount         pic 9(8)v99        value 0.
           05 ws-total-sl-03-amount         pic 9(8)v99        value 0.
           05 ws-total-sl-04-amount         pic 9(8)v99        value 0.
           05 ws-total-sl-05-amount         pic 9(8)v99        value 0.
           05 ws-total-sl-12-amount         pic 9(8)v99        value 0.

           05 ws-total-r-01-amount          pic 9(8)v99        value 0.
           05 ws-total-r-02-amount          pic 9(8)v99        value 0.
           05 ws-total-r-03-amount          pic 9(8)v99        value 0.
           05 ws-total-r-04-amount          pic 9(8)v99        value 0.
           05 ws-total-r-05-amount          pic 9(8)v99        value 0.
           05 ws-total-r-12-amount          pic 9(8)v99        value 0.

      * Payment Type
           05 ws-total-ca                   pic 99             value 0.
           05 ws-total-cd                   pic 99             value 0.
           05 ws-total-db                   pic 99             value 0.

      * -----------------------
       PROCEDURE DIVISION.
      * Main
       000-Main.
           perform 050-Open-Files.
           perform 100-Write-Headers.
           perform 200-Read-File.

           perform 250-Process-Lines
             until ws-eof equals ws-eof-Y.

           perform 800-Close-Files.

           GOBACK.

       050-Open-Files.
           open input input-file.
           open output s-l-file.
           open output return-file.
           open output report-file.

       100-Write-Headers.
           write report-line from ws-report-header-1.
           write report-line from ws-report-header-2.
           write report-line from spaces.
           write report-line from ws-report-header-3.
           write report-line from spaces.
           write report-line from ws-report-header-4.

       200-Read-File.
           read input-file
               at end
                   move ws-eof-Y to ws-eof.

       250-Process-Lines.
           if il-trans-s-l
      * Write the whole record to the sl file
               write sl-line from input-line

      * Add to the record & amount counts
               add 1                   to ws-total-s-l
               add il-trans-amt        to ws-total-s-l-amount

               if il-trans-s
                   add 1               to ws-total-s
                   add il-trans-amt    to ws-total-s-amount
               end-if
               if il-trans-l
                   add 1               to ws-total-l
                   add il-trans-amt    to ws-total-l-amount
               end-if

      * Add to store amount totals
               if il-store-1
                   add il-trans-amt    to ws-total-sl-01-amount
               end-if
               if il-store-2
                   add il-trans-amt    to ws-total-sl-02-amount
               end-if
               if il-store-3
                   add il-trans-amt    to ws-total-sl-03-amount
               end-if
               if il-store-4
                   add il-trans-amt    to ws-total-sl-04-amount
               end-if
               if il-store-5
                   add il-trans-amt    to ws-total-sl-05-amount
               end-if
               if il-store-12
                   add il-trans-amt    to ws-total-sl-12-amount
               end-if

      * Add to payment type totals
               if il-card
                   add 1               to ws-total-ca
               end-if
               if il-credit
                   add 1               to ws-total-cd
               end-if
               if il-debit
                   add 1               to ws-total-db
               end-if
           end-if.

           if il-trans-r
      * Write the whole record to the r file
               write return-line from input-line

      * Add to the record & amount counts
               add 1                   to ws-total-r
               add il-trans-amt        to ws-total-r-amount

      * Add to store record & amount totals
               if il-store-1
                   add 1               to ws-total-01-records
                   add il-trans-amt    to ws-total-r-01-amount
               end-if
               if il-store-2
                   add 1               to ws-total-02-records
                   add il-trans-amt    to ws-total-r-02-amount
               end-if
               if il-store-3
                   add 1               to ws-total-03-records
                   add il-trans-amt    to ws-total-r-03-amount
               end-if
               if il-store-4
                   add 1               to ws-total-04-records
                   add il-trans-amt    to ws-total-r-04-amount
               end-if
               if il-store-5
                   add 1               to ws-total-05-records
                   add il-trans-amt    to ws-total-r-05-amount
               end-if
               if il-store-12
                   add 1               to ws-total-12-records
                   add il-trans-amt    to ws-total-r-12-amount
               end-if
           end-if.

      * Read input file if not at end
           if ws-eof equal ws-eof-N
               perform 200-Read-File
           end-if.

       800-Close-Files.
           close input-file.
           close s-l-file.
           close return-file.
           close report-file.

       END PROGRAM Final_Data_Split_Count.