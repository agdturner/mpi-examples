#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

int main (int argc, char *argv[]) {
   int rank;
   int size;
   int resultlen;
   int namesize = MPI_MAX_PROCESSOR_NAME;
   char name[namesize];
   char namer[namesize];
   MPI_Status status;

   MPI_Init(&argc, &argv);

   MPI_Comm_rank(MPI_COMM_WORLD, &rank);

   MPI_Comm_size(MPI_COMM_WORLD, &size);

   MPI_Get_processor_name(name, &resultlen);


   if (rank == 0) {
       printf ("Major %s, rank 0, size %d.\n", name, size);
       int i;   
       for (i=1; i<size; i++) {
           MPI_Recv(&namer, namesize, MPI_CHAR, i, i, MPI_COMM_WORLD, &status);
           printf ("Minor %s rank %d.\n", namer, i);
       }
   } else {
       MPI_Ssend(name, namesize, MPI_CHAR, 0, rank, MPI_COMM_WORLD);
   }

   MPI_Finalize();

   return 0;
}
