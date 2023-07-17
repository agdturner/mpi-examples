# Hello2 C README

## Contents
| Filename | Description |
| :--- | :--- |
| hello3.c | C source code for a simple hello Message Passing Interface (MPI) program. |
| hello3.qsub | Son of Grid Engine Job submission script detailing the number of processors and other details. |
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
- All the writing is done by rank 0 (Major).
- Other ranks (Minor) send a message to Major which is the name of the node on which they are running.
- The program contains more error checking code than ../hello2.

## Instructions and expectations.
- To run the program, change into this directory and run run.sh or execute the following command at the command line:
`../../run.sh ../Makefile hello3.qsub`
- Information and further instructions are then written to stdout.
- A directory will be created in /nobackup/$USER (where $USER is your username) with the path appended to where these files are located. Exisitng files at this location may get overwritten.
- The directory written will contain an error and output file for the job and a directory called data/output in which there should be an output text file with the first part of the filename being the job id.

## References
- [The Open MPI Project](https://www.open-mpi.org/)
