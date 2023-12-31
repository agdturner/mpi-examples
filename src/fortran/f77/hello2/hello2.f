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
       INTEGER NAME_LENGTH

       CALL MPI_INIT(IERROR)

       CALL MPI_COMM_RANK(MPI_COMM_WORLD, RANK, IERROR)

       CALL MPI_COMM_SIZE(MPI_COMM_WORLD, SIZE, IERROR)

       CALL MPI_GET_PROCESSOR_NAME(NAME, RESULTLEN, IERROR)

       CALL MPI_BARRIER(MPI_COMM_WORLD, IERROR)

       IF (RANK == 0) THEN      
        WRITE (*,*) 'Major ', NAME(1:RESULTLEN),', rank ', RANK,
     +   ', size ', SIZE, '.'
        DO 10 I = 1, SIZE - 1
c         WRITE (*,*) 'Recieving from', I
c      ---
c      MPI_RECV(BUF, COUNT, DATATYPE, SOURCE, TAG, COMM, STATUS, IERROR)
c       <type>    BUF(*)
c       INTEGER    COUNT, DATATYPE, SOURCE, TAG, COMM
c       INTEGER    STATUS(MPI_STATUS_SIZE), IERROR
c      ---
         CALL MPI_RECV(NAME_LENGTH, 1, MPI_INT, I, I, MPI_COMM_WORLD,
     +    STATUS, IERROR)
         CALL MPI_RECV(NAMER, NAME_LENGTH, MPI_CHAR, I,
     +    I, MPI_COMM_WORLD, STATUS, IERROR)
c         CALL MPI_RECV(NAMER, MPI_MAX_PROCESSOR_NAME, MPI_CHAR, I,
c     +    I, MPI_COMM_WORLD, STATUS, IERROR)
c         WRITE (*,*) 'Minor Rank ', I, 'Name ', NAMER
         WRITE (*,*) 'Minor ', NAMER(1:NAME_LENGTH), ', rank ', I, '.'
c         IF (IERROR == MPI_SUCCESS) THEN
c          WRITE (*,*) 'MPI_RECV Succeeded from rank ', I
c         ELSE
c          WRITE (*,*) 'MPI_RECV Failed from rank ', I
c         ENDIF
c         WRITE (*,*) 'Recieved from', I
  10    ENDDO
       ELSE
c        WRITE (*,*) 'Sending from ', RANK
c        WRITE (*,*) 'RESULTLEN', RESULTLEN
c       WRITE (*,*) 'Minor Rank ', RANK, 'Name ', NAME
c      ---
c      MPI_SSEND(BUF, COUNT, DATATYPE, DEST, TAG, COMM, IERROR)
c       <type>    BUF(*)
c       INTEGER    COUNT, DATATYPE, DEST, TAG, COMM, IERROR
c      ---
c      Send the length of NAME.
        CALL MPI_SSEND(RESULTLEN, 1, MPI_INT, 0,
     +   RANK, MPI_COMM_WORLD, IERROR)
        CALL MPI_SSEND(NAME, RESULTLEN, MPI_CHAR, 0,
     +   RANK, MPI_COMM_WORLD, IERROR)
c        CALL MPI_SSEND(NAME, MPI_MAX_PROCESSOR_NAME, MPI_CHAR, 0,
c     +   RANK, MPI_COMM_WORLD, IERROR)
c        WRITE (*,*) 'Sent from ', RANK
       ENDIF

      CALL MPI_BARRIER(MPI_COMM_WORLD, IERROR)

      CALL MPI_FINALIZE(IERROR)

      END PROGRAM HELLO2
