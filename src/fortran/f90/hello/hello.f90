      PROGRAM HELLO

c     A simple MPI program for testing.
 
      IMPLICIT NONE

      INCLUDE 'mpif.h'

      INTEGER IERROR
      INTEGER RANK
      INTEGER SIZE
      INTEGER RESULTLEN
      CHARACTER*(MPI_MAX_PROCESSOR_NAME) NAME
c      CHARACTER*(32) NAME

      CALL MPI_INIT(IERROR)

      CALL MPI_COMM_RANK(MPI_COMM_WORLD, RANK, IERROR)

      CALL MPI_COMM_SIZE(MPI_COMM_WORLD, SIZE, IERROR)

      CALL MPI_GET_PROCESSOR_NAME(NAME, RESULTLEN, IERROR)
      
      IF (rank == 0) THEN
          WRITE (*,*) 'Major Rank ', RANK, 'Size ', SIZE, 'Name ', NAME
      ELSE
          WRITE (*,*) 'Minor Rank ', RANK, 'Name ', NAME
      ENDIF

      CALL MPI_FINALIZE(IERROR)

      END PROGRAM HELLO
