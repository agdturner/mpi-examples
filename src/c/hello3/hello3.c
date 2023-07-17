#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

/*
 * A basic MPI program where all minor processes send back information
 * to rank0 that prints out that information.
 */
int main (int argc, char *argv[]) {
    int rank;
    int size;
    int resultlen;
    int namesize = MPI_MAX_PROCESSOR_NAME;
    char name[namesize];
    char namer[namesize];
    MPI_Status status;
    MPI_Request request;

    if (MPI_Init(&argc, &argv) == MPI_SUCCESS) {
        //printf("MPI_Init succeeded.\n");
    } else {
        printf("MPI_Init failed.\n");
        MPI_Abort(MPI_COMM_WORLD, MPI_ERR_UNKNOWN);
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

    if (MPI_Barrier(MPI_COMM_WORLD) == MPI_SUCCESS) {
        //printf("MPI_Barrier succeeded rank %d.\n", rank);
    } else {
        printf("MPI_Barrier failed.\n");
    }

    // Print out some information.
    if (rank == 0) {
        printf("Major %s rank %d size %d\n", name, rank, size);
        int i;   
        for (i=1; i<size; i++) {
            printf("Recieving from %d\n", i);
            if (MPI_Recv(&namer, namesize, MPI_CHAR, i, i, MPI_COMM_WORLD, &status) == MPI_SUCCESS) {
                //printf("MPI_Recv succeeded on rank %d from %d.\n", rank, i);
            } else {
                printf("MPI_Recv failed on rank %d from %d.\n", rank, i);
            }
            printf("Minor %s rank %d\n", namer, i);
            printf("MPI process %d received %s from source %d"
               ", status source %d tag %d error code %d.\n",
               rank, namer, i,
               status.MPI_SOURCE, status.MPI_TAG, status.MPI_ERROR);
        }
    } else {
        printf("Sending from %d\n", rank);
        if (MPI_Ssend(name, namesize, MPI_CHAR, 0, rank, MPI_COMM_WORLD) == MPI_SUCCESS) {
            //printf("MPI_Ssend succeeded from %d to %d.\n", rank, 0);
        } else {
            printf("MPI_Ssend failed from %d to %d", rank, 0);
        }
    }

    if (MPI_Barrier(MPI_COMM_WORLD) == MPI_SUCCESS) {
        //printf("MPI_Barrier succeeded rank %d.\n", rank);
    } else {
        printf("MPI_Barrier failed.\n");
    }

    if (MPI_Finalize() == MPI_SUCCESS) {
        printf("MPI_Finalize succeeded.\n");
    } else {
        printf("MPI_Finalize failed on %d.\n", rank);
	if (MPI_Abort(MPI_COMM_WORLD, MPI_ERR_OTHER) == MPI_SUCCESS) {
            printf("MPI_Abort succeeded on %d.\n", rank);
        } else {
            printf("MPI_Abort failed on %d.\n", rank);
        }
    }

    // It is good practice to return 0 if the C Program exits normally.
    return 0;
}
