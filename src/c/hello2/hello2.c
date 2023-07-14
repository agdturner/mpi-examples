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
       //int MPI_Recv(void *buf, int count, MPI_Datatype datatype, int source, int tag, MPI_Comm comm, MPI_Status *status)
       printf ("Major %s rank 0", name);
       int i;   
       for (i=1 ; i<size ; i++) {
           MPI_Recv(name, namesize, MPI_CHAR, int source, i, MPI_COMM_WORLD)
           printf ("Minor %s rank %d\n", name[i], i);
       }


       //int *rbuf;
       //rbuf = malloc(size*namesize*sizeof(MPI_CHAR));

       //MPI_Gather( sendarray, 100, MPI_INT, rbuf, 100, MPI_INT, root, comm);
       //MPI_Gather(name, namesize, MPI_CHAR, rbuf, namesize, MPI_CHAR, rank, MPI_COMM_WORLD);

   } else {
       //printf("Minor %s rank %d of size %d \n", name, rank, size);
       //int MPI_Send(const void *buf, int count, MPI_Datatype datatype, int dest, int tag, MPI_Comm comm)
       MPI_Send(name, namesize, MPI_CHAR, 0, rank, MPI_COMM_WORLD);
       //MPI_Send(name, resultlen, MPI_CHAR, 0, rank, MPI_COMM_WORLD);
   }

   MPI_Finalize();
}
