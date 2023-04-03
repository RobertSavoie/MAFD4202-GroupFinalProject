       identification division.
       program-id. S_L_Processing.
       author. Group 15.
       date-written. Apr 3/2023.
      *
       input-output section.
       file-control.
      *
       select input-file
           assign to "../../../../data/S-L-Data.dat"
           organization is line sequential.
      *
       select output-file
           assign to "../../../../output/S-L-Report.out"
           organization is line sequential.
      *
       data division.
       file section.
       fd input-file
       data record is input-line
           record contains 36 characters.
      *input line
       01 input-line.
           05 il-trans-code            pic x.
               88 s-code                           value "S".
               88 l-code                           value "L".
           05 il-trans-amt             pic 9(5)v99.
           05 il-payment-type          pic xx.
               88 ca-type                          value "CA".
               88 cr-type                          value "CR".
               88 db-type                          value "DB".
           05 il-store-num             pic 99.
           05 il-invoice-num1          pic x.
           05 il-invoice-num2          pic x.
           05 il-invoice-dash          pic x.
           05 il-invoice-nums          pic 9(6).
           05 il-sku                   pic x(15).
      *
       fd output-file
           data record is output-line
           record contains 100 characters.
      *
       01 output-line                  pic x(100).
      *
       working-storage section.
      *
       01 ws-heading-main-title.
           05 filler                   pic x(27)   value
                                       "Group 15 - Final Assignment".
           05 filler                   pic x(3)    value " - ".
           05 filler                   pic x(70)   value spaces.
      *
       01 ws-heading-names.
           05 filler                   pic x(8)    value "Members:".
           05 filler                   pic x       value space.
           05 filler                   pic x(29)   value
                                       "Martin Barber, Robert Savoie,".
           05 filler                   pic x(30)   value
                                       " Alex Blackmore, Rhys Thompson".
           05 filler                   pic x(32)   value spaces.
      *
       01 ws-heading-title.
           05 filler                   pic x(45)   value spaces.
           05 filler                   pic x(10)   value "S&L Report".
           05 filler                   pic x(32)   value spaces.
           05 filler                   pic x(13)   value spaces.
      *
       01 ws-column-header1.
           05 filler                   pic x       value spaces.
           05 filler                   pic x(4)    value "Line".
           05 filler                   pic x(4)    value spaces.
           05 filler                   pic x(11)   value "Transaction".
           05 filler                   pic x(2)    value spaces.
           05 filler                   pic x(11)   value "Transaction".
           05 filler                   pic x(3)    value spaces.
           05 filler                   pic x(7)    value "Payment".
           05 filler                   pic x(4)    value spaces.
           05 filler                   pic x(5)    value "Store".
           05 filler                   pic x(8)    value spaces.
           05 filler                   pic x(7)    value "Invoice".
           05 filler                   pic x(12)   value spaces.
           05 filler                   pic x(3)    value "SKU".
           05 filler                   pic x(14)   value spaces.
           05 filler                   pic xxx     value "Tax".
           05 filler                   pic x       value spaces.
      *
       01 ws-column-header2.
           05 filler                   pic x       value spaces.
           05 filler                   pic xxx     value "Num".
           05 filler                   pic x(8)    value spaces.
           05 filler                   pic x(4)    value "Code".
           05 filler                   pic x(8)    value spaces.
           05 filler                   pic x(6)    value "Amount".
           05 filler                   pic x(7)    value spaces.
           05 filler                   pic x(4)    value "Type".
           05 filler                   pic x(7)    value spaces.
           05 filler                   pic x(6)    value "Num".
           05 filler                   pic x(6)    value spaces.
           05 filler                   pic x(6)    value "Number".
           05 filler                   pic x(13)   value spaces.
           05 filler                   pic x(4)    value "Code".
           05 filler                   pic x(12)   value spaces.
           05 filler                   pic x(5)    value "Owing".
      *
       01 ws-total-line1.
           05 filler                   pic x(21)   value
                                       "Total S&L  records : ".
           05 ws-total-sl-count        pic z9.
           05 filler                   pic x(9)    value spaces.
           05 filler                   pic x(21)   value
                                       "Total S    records : ".
           05 ws-total-s-count         pic z9.
           05 filler                   pic x(9)    value spaces.
           05 filler                   pic x(21)   value
                                       "Total L    records : ".
           05 ws-total-l-count         pic z9.
           05 filler                   pic x(13)   value spaces.
      *
       01 ws-total-line2.
           05 filler                   pic x(21)   value
                                       "Total CA   records : ".
           05 ws-total-ca-count        pic z9.
           05 filler                   pic x(9)    value spaces.
           05 filler                   pic x(21)   value
                                       "Total CR   records : ".
           05 ws-total-cr-count        pic z9.
           05 filler                   pic x(9)    value spaces.
           05 filler                   pic x(21)   value
                                       "Total DB   records : ".
           05 ws-total-db-count        pic z9.
           05 filler                   pic x(13)   value spaces.
      *
       01 ws-total-line3.
           05 filler                   pic x(21)   value
                                       "Total CA   percent : ".
           05 ws-total-ca-percent      pic z9.99.
           05 filler                   pic x       value "%".
           05 filler                   pic x(5)    value spaces.
           05 filler                   pic x(21)   value
                                       "Total CR   percent : ".
           05 ws-total-cr-percent      pic z9.99.
           05 filler                   pic x       value "%".
           05 filler                   pic x(5)    value spaces.
           05 filler                   pic x(21)   value
                                       "Total DB   percent : ".
           05 ws-total-db-percent      pic z9.99.
           05 filler                   pic x       value "%".
           05 filler                   pic x(5)    value spaces.
           05 filler                   pic x(4)    value spaces.
      *
       01 ws-total-line4.
           05 filler                   pic x(21)   value
                                       "Total Type percent : ".
           05 ws-total-type-percent    pic zz9.
           05 filler                   pic x       value "%".
           05 filler                   pic x(72)   value spaces.
      *
       01 ws-total-line5.
           05 filler                   pic x(28)   value
                                       "Most Transactions  : Store #".
           05 ws-most-transactions     pic 99.
           05 filler                   pic x(70)   value spaces.
      *
       01 ws-total-line6.
           05 filler                   pic x(21)   value
                                       "Total Tax Owed     : ".
           05 ws-total-tax-owing       pic z,zz9.99.
           05 filler                   pic x(71)   value spaces.
      *
       01 ws-record-line.
           05 filler                   pic x       value spaces.
           05 ws-line-number           pic z9.
           05 filler                   pic x(10)   value spaces.
           05 ws-trans-code            pic x       value spaces.
           05 filler                   pic x(8)    value spaces.
           05 ws-trans-amt             pic zz,zz9.99.
           05 filler                   pic x(7)    value spaces.
           05 ws-payment-type          pic xx      value spaces.
           05 filler                   pic x(9)    value spaces.
           05 ws-store-num             pic 99.
           05 filler                   pic x(6)    value spaces.
           05 ws-invoice-num1          pic x       value spaces.
           05 ws-invoice-num2          pic x       value spaces.
           05 ws-invoice-dash          pic x       value spaces.
           05 ws-invoice-nums          pic 9(9).
           05 filler                   pic x(5)    value spaces.
           05 ws-sku                   pic x(15)   value spaces.
           05 filler                   pic x(3)    value spaces.
           05 ws-tax-owing             pic z,zz9.99.
      *
      *eof constants
       77 eof-flag                     pic x       value "n".
       77 eof-y                        pic x       value "y".
      *
      *tables
       01 store-num-tbl.
           05 ws-element-one           pic 99 occurs 1 times.
               88 store-num-one                    value 01.
               88 store-num-two                    value 02.
               88 store-num-three                  value 03.
               88 store-num-four                   value 04.
               88 store-num-five                   value 05.
               88 store-num-twelve                 value 12.
      *
      *variables for doing math
       01 math-section.
           05 math-tax-owing           pic 9(6)v99.
           05 math-total-tax-owing     pic 9(6)v99.
           05 math-total-percent       pic 999v99.
           05 math-ca-percent          pic 999v9999.
           05 math-cr-percent          pic 999v9999.
           05 math-db-percent          pic 999v9999.
      *    
      *counters
       01 counters.
           05 cntr-line                pic 99      value 0.
           05 cntr-page                pic 99      value 0.
           05 cntr-sl-total            pic 99      value 0.
           05 cntr-s-total             pic 99      value 0.
           05 cntr-l-total             pic 99      value 0.
           05 cntr-cr                  pic 99      value 0.
           05 cntr-ca                  pic 99      value 0.
           05 cntr-db                  pic 99      value 0.
           05 cntr-store-1             pic 99      value 0.
           05 cntr-store-2             pic 99      value 0.
           05 cntr-store-3             pic 99      value 0.
           05 cntr-store-4             pic 99      value 0.
           05 cntr-store-5             pic 99      value 0.
           05 cntr-store-12            pic 99      value 0.
      *
      *constants
       77 const-lines-per-page         pic 99      value 20.
       77 const-tax-rate               pic 9v99    value 0.13.
      *
       procedure division.
       000-main.
      *
           perform 25-open-files.
           perform 50-read-input-file.
           perform 200-process-pages
             until eof-flag = eof-y.
           perform 340-calculate-percent.
           perform 360-calculate-most-trans.
           perform 125-print-footers.
           perform 75-close-files.
           goback.
      *
       25-open-files.
      *open files
      *
           open input input-file.
           open output output-file.
      *
       50-read-input-file.
      *read input file
      *
           read input-file
               at end
                   move eof-y to eof-flag.
       75-close-files.
      *closes files
      *
           close input-file
             output-file.
      *
       80-clear-artifacts.
      *clears output-line
      *
           move spaces to output-line.
      *
       100-print-page-headings.
      *prints page heading
      *
           if cntr-page > 0
               add 1 to cntr-page
               write output-line
                 from ws-heading-main-title
                 after advancing page
           else
               add 1 to cntr-page
               write output-line
                 from ws-heading-main-title
                 after advancing 1 lines
           end-if.
      *
           write output-line
             from ws-heading-names
             before advancing 2 lines.
      *
           write output-line
             from ws-heading-title
             before advancing 2 lines.
      *
           write output-line
             from ws-column-header1.
      *
           write output-line
             from ws-column-header2
             before advancing 2 lines.
      *
       125-print-footers.
      *print page footers
           move cntr-sl-total          to ws-total-sl-count.
           move cntr-s-total           to ws-total-s-count.
           move cntr-l-total           to ws-total-l-count.
           move cntr-ca                to ws-total-ca-count.
           move cntr-cr                to ws-total-cr-count.
           move cntr-db                to ws-total-db-count.
           move math-ca-percent        to ws-total-ca-percent.
           move math-cr-percent        to ws-total-cr-percent.
           move math-db-percent        to ws-total-db-percent.
           move math-total-percent     to ws-total-type-percent.
           move math-total-tax-owing   to ws-total-tax-owing.
      *    
           write output-line
             from ws-total-line1.
      *
           write output-line
             from ws-total-line2
             after advancing 1 line.
      *
           write output-line
             from ws-total-line3
             after advancing 2 lines.
      *
           write output-line
             from ws-total-line4
             after advancing 2 lines.
      *
           write output-line
             from ws-total-line5
             after advancing 2 lines.
      *
           write output-line
             from ws-total-line6
             after advancing 2 lines.
      *
       200-process-pages.
      *processes pages
      *
           perform 100-print-page-headings.
           perform 250-process-lines
           varying cntr-line from 1 by 1
             until cntr-line > const-lines-per-page
             or eof-flag = eof-y.
      *
       250-process-lines.
      *process lines
      *
           perform 80-clear-artifacts.
           perform 310-calculate-tax-owing.
           perform 320-determine-sl-type.
           perform 330-detemine-payment-types.
           perform 350-calculate-trans-per-store.
           perform 400-create-output-line.
           perform 50-read-input-file.
      *
       310-calculate-tax-owing.
      *calculates tax owing and total tax owing
      *
           multiply il-trans-amt
                 by const-tax-rate
             giving math-tax-owing.

           add math-tax-owing
            to math-total-tax-owing.
      *
       320-determine-sl-type.
      *determines which transaction type it is
      *
           if s-code
               add 1       to cntr-sl-total
               add 1       to cntr-s-total
           end-if.
           if l-code
               add 1       to cntr-sl-total
               add 1       to cntr-l-total
           end-if.
      *
       330-detemine-payment-types.
      *counts the number of CA, CR, and DB
      *
           if cr-type
               add 1       to cntr-cr
           end-if.
           if ca-type
               add 1       to cntr-ca
           end-if.
           if db-type
               add 1       to cntr-db
           end-if.
      *
       340-calculate-percent.
      *calculates the percentages of each payment type
      *
           divide cntr-ca
               by cntr-sl-total
           giving math-ca-percent      rounded.
      *
           multiply 100
                 by math-ca-percent.
      *
           divide cntr-cr
             by cntr-sl-total
             giving math-cr-percent    rounded.
      *
           multiply 100
             by math-cr-percent.
      *
           divide cntr-db
             by cntr-sl-total
             giving math-db-percent    rounded.
      *
           multiply 100
             by math-db-percent.
      *
           add math-ca-percent
             to math-total-percent.
           add math-cr-percent
             to math-total-percent.
           add math-db-percent
             to math-total-percent.
      *
       350-calculate-trans-per-store.
      *calculates the amount of transaction per store
      *and then which store has the most transactions
      *
           move il-store-num to store-num-tbl.
           if store-num-one(1)
               add 1 to cntr-store-1
           end-if.
           if store-num-two(1)
               add 1 to cntr-store-2
           end-if.
           if store-num-three(1)
               add 1 to cntr-store-3
           end-if.
           if store-num-four(1)
               add 1 to cntr-store-4
           end-if.
           if store-num-five(1)
               add 1 to cntr-store-5
           end-if.
           if store-num-twelve(1)
               add 1 to cntr-store-12
           end-if.
      *
       360-calculate-most-trans.
      *
           compute ws-most-transactions = function ord-max (
               cntr-store-1, cntr-store-2, cntr-store-3,
             cntr-store-4, cntr-store-5, cntr-store-12).
      *
       400-create-output-line.
      *creates output line
      *
           move cntr-line          to ws-line-number.
           move il-trans-code      to ws-trans-code.
           move il-trans-amt       to ws-trans-amt.
           move il-payment-type    to ws-payment-type.
           move il-store-num       to ws-store-num.
           move il-invoice-num1    to ws-invoice-num1.
           move il-invoice-num2    to ws-invoice-num2.
           move il-invoice-dash    to ws-invoice-dash.
           move il-invoice-nums    to ws-invoice-nums.
           move il-sku             to ws-sku.
           move math-tax-owing     to ws-tax-owing.
      *
           write output-line
             from ws-record-line
             before advancing 2 lines.
      *
       end program S_L_Processing.
