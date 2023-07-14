#include <stdio.h>
#include <mpi.h>

int main (int argc, char *argv[]) {
   int rank;
   int size;
   int resultlen;
   int namesize = MPI_MAX_PROCESSOR_NAME;
   char name[namesize];

   MPI_Init(&argc, &argv);

   MPI_Comm_rank(MPI_COMM_WORLD, &rank);

   MPI_Comm_size(MPI_COMM_WORLD, &size);

   MPI_Get_processor_name(name, &resultlen);   

   if (rank == 0) {
       //printf("Major %s rank %d\n", name, rank);
       //MPI_SEND(BUF, COUNT, DATATYPE, DEST, TAG, COMM, IERROR)
       MPI_Send(name, namesize, MPI_CHAR, 0, rank, MPI_COMM_WORLD);

       int *rbuf;
       rbuf = (int *)malloc(size*namesize*sizeof(MPI_CHAR));

       //MPI_Gather( sendarray, 100, MPI_INT, rbuf, 100, MPI_INT, root, comm);
       MPI_Gather(name, namesize, MPI_CHAR, rbuf, namesize, MPI_CHAR, rank, MPI_COMM_WORLD);

       printf ("Major %s rank 0", name);
       int i;
       for (i=1 ; i<size ; i++) {
           printf ("Minor %s rank %d\n", name[i], i);
       }
   } else {
       //printf("Minor %s rank %d of size %d \n", name, rank, size);
       MPI_Send(name, namesize, MPI_CHAR, 0, rank, MPI_COMM_WORLD);
   }

   MPI_Finalize();
}
