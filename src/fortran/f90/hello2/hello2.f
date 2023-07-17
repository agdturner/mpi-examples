       PROGRAM HELLO2

c      A simple MPI program for testing.
 
       IMPLICIT NONE

       INCLUDE 'mpif.h'

       INTEGER IERROR
       INTEGER RANK
       INTEGER SIZE
       INTEGER RESULTLEN
       CHARACTER*(MPI_MAX_PROCESSOR_NAME) NAME
c       CHARACTER*(32) NAME
       CHARACTER*(MPI_MAX_PROCESSOR_NAME) NAMER
c       CHARACTER*(32) NAMER
       INTEGER I
       INTEGER STATUS(MPI_STATUS_SIZE)
       INTEGER RANKR

       CALL MPI_INIT(IERROR)

       CALL MPI_COMM_RANK(MPI_COMM_WORLD, RANK, IERROR)

       CALL MPI_COMM_SIZE(MPI_COMM_WORLD, SIZE, IERROR)

       CALL MPI_GET_PROCESSOR_NAME(NAME, RESULTLEN, IERROR)

       CALL MPI_BARRIER(MPI_COMM_WORLD, IERROR)

       IF (RANK == 0) THEN      
        WRITE (*,*) 'Major Rank ', RANK, 'Size ', SIZE,
     +   'Name ', NAME
        DO 10 I = 1, SIZE - 1
         WRITE (*,*) 'Recieving from', I
c      ---
c      MPI_RECV(BUF, COUNT, DATATYPE, SOURCE, TAG, COMM, STATUS, IERROR)
c       <type>    BUF(*)
c       INTEGER    COUNT, DATATYPE, SOURCE, TAG, COMM
c       INTEGER    STATUS(MPI_STATUS_SIZE), IERROR
c      ---
c         CALL MPI_RECV(NAMER, MPI_MAX_PROCESSOR_NAME, MPI_CHAR, I,
c     +    TAG, MPI_COMM_WORLD, STATUS, IERROR)
c         WRITE (*,*) 'Minor Rank ', I, 'Name ', NAMER
         CALL MPI_RECV(RANKR, 1, MPI_INT, I,
     +    I, MPI_COMM_WORLD, STATUS, IERROR)
         IF (IERROR == MPI_SUCCESS) THEN
          WRITE (*,*) 'Success'
         ELSE
          WRITE (*,*) 'Failure'
         ENDIF
         WRITE (*,*) 'Minor Rank ', RANKR
         WRITE (*,*) 'Recieved from', I
 10     ENDDO
       ELSE
        WRITE (*,*) 'Sending from ', RANK
c       WRITE (*,*) 'Minor Rank ', RANK, 'Name ', NAME
c      ---
c      MPI_SSEND(BUF, COUNT, DATATYPE, DEST, TAG, COMM, IERROR)
c       <type>    BUF(*)
c       INTEGER    COUNT, DATATYPE, DEST, TAG, COMM, IERROR
c      ---
c        CALL MPI_SSEND(NAME, MPI_MAX_PROCESSOR_NAME, MPI_CHAR, 0,
c     +   RANK, MPI_COMM_WORLD, IERROR)
        CALL MPI_SEND(RANK, 1, MPI_INT, 0, RANK, MPI_COMM_WORLD,
     +   IERROR)
        WRITE (*,*) 'Sent from ', RANK
       ENDIF

      CALL MPI_BARRIER(MPI_COMM_WORLD, IERROR)

      CALL MPI_FINALIZE(IERROR)

      END PROGRAM HELLO2
