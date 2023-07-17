# Hello C README

## Contents
| Filename | Description |
| :--- | :--- |
| hello2.c | C source code for a simple hello Message Passing Interface (MPI) program. |
| hello2.qsub | Son of Grid Engine Job submission script detailing the number of processors and other details. |
| README.txt | This file. |
| run.sh | A shell script to run the program. |

## Dependencies
- `../Makefile`
  - The Makefile used to compile the executable.
- `../../run.sh`
  - The BASH shell script to stage, compile and run the program.
- The program assumes that there is a /nobackup/ directory on the system that the user can write to.

## Description
- This is an example Message Passing Interface (MPI) program designed to be run on an HPC with a Son of Grid Engine Scheduler.
- Each process prints out some information including the name of the node on which it is running and it's rank.
- The process with rank 0 is known as Major (also commonly known as manager or in the past master).
- Other processes have different numbered ranks and are known as Minor prodcessors (also sometimes called worker processes and in the past slaves)
- Each rank prints out to Standard Output (stdout) which is directed into an output file. The contants of the output file will look somethong like:
Minor <processor name 2> rank 2
Minor <processor name 1> rank 1
Major <processor name 0> rank 0 of 4
Minor <processor name 3> rank 3
- There is no guarantee of the order in which these lines are returned.
- "<processor name X>" would look more "d8sob1.arc4.leeds.ac.uk"

## Instructions and expectations.
- To run the program, change into this directory and run run.sh or execute the following command at the command line:
`../../run.sh ../Makefile hello2.qsub`
- Information and further instructions are then written to stdout.
- A directory will be created in /nobackup/$USER (where $USER is your username) with the path appended to where these files are located. Exisitng files at this location may get overwritten.
- The directory written will contain an error and output file for the job and a directory called data/output in which there should be an output text file with the first part of the filename being the job id.

## References
- [The Open MPI Project](https://www.open-mpi.org/)
