#include <stdio.h>
#include <mpi.h>

int main (int argc, char *argv[]) {
   int rank;
   int size;
   char name[MPI_MAX_PROCESSOR_NAME];
   int resultlen;

   MPI_Init(&argc, &argv);

   MPI_Comm_rank(MPI_COMM_WORLD, &rank);

   MPI_Comm_size(MPI_COMM_WORLD, &size);

   MPI_Get_processor_name(name, &resultlen);

   if (rank == 0) {
       printf("Major %s rank %d of %d \n", name, rank, size);
   } else {
       printf("Minor %s rank %d \n", name, rank);
   }

   MPI_Finalize();
}
