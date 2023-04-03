       identification division.
       program-id. Returns.

        environment division.
       input-output section.
       file-control.
      *
           select input-file
               assign to "../../../../data/project8.dat"
                   organization is line sequential.

      *This is where the file will be output to
           select return-file
               assign to "../../../../output/Return-Data.out"
               organization is line sequential.

           select valid-data-file
               assign to "../../../../data/Valid-Data.dat"
               organization is line sequential.
      *
       configuration section.

       data division.
       working-storage section.

       procedure division.

           goback.

       end program Returns.
