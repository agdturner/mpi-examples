#include <stdio.h>
#include <mpi.h>

/*
A basic MPI program that prints out some basic information.
*/
int main (int argc, char *argv[]) {
    int rank;
    int size;
    char name[MPI_MAX_PROCESSOR_NAME];
    int resultlen;

    if (MPI_Init(&argc, &argv) == MPI_SUCCESS) {
        //printf("MPI_Init succeeded.\n");
    } else {
        printf("MPI_Init failed.\n");
    }

    if (MPI_Comm_size(MPI_COMM_WORLD, &size) == MPI_SUCCESS) {
        //printf("MPI_Comm_size succeeded.\n");
    } else {
        printf("MPI_Comm_size failed.\n");
    }

    if (MPI_Comm_rank(MPI_COMM_WORLD, &rank) == MPI_SUCCESS) {
        //printf("MPI_Comm_rank succeeded.\n");
    } else {
        printf("MPI_Comm_rank failed.\n");
    }

    if (MPI_Get_processor_name(name, &resultlen) == MPI_SUCCESS) {
        //printf("MPI_Get_processor_name succeeded.\n");
    } else {
        printf("MPI__Get_processor_name failed.\n");
    }

    // Print out some information.
    if (rank == 0) {
        printf("Major %s rank %d of %d \n", name, rank, size);
    } else {
        printf("Minor %s rank %d \n", name, rank);
    }

    if (MPI_Finalize() == MPI_SUCCESS) {
        //printf("MPI_Finalize succeeded.\n");
    } else {
        printf("MPI_Finalize failed.\n");
    }
    
    // It is good practice to return 0 if the C Program exits normally.
    return 0;
}
