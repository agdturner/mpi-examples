# Hello2 Fortran F77 Program

## Contents
| Filename | Description |
| :--- | :--- |
| hello2.f | Fortran 77 source code for a simple hello Message Passing Interface (MPI) program. |
| hello2.qsub | Son of Grid Engine Job submission script detailing the number of processors and other details. |
| README.txt | This file. |
| run.sh | A shell script to run the program. |

## Description
- This is an example Message Passing Interface (MPI) program designed to be run on an HPC with a Son of Grid Engine Scheduler.
- The program assumes that there is a /nobackup/ directory on the system that the user can write to.
- To run the program, change into this directory and either run run.sh or execute the following command at the command line:
`../../../run.sh ../../Makefile hello2.qsub`
- Information and further instructions are then written to stdout.
- A directory will be created in /nobackup/$USER (where $USER is your username) with the path appended to where these files are located. Exisitng files at this location may get overwritten.

## References
- [The Open MPI Project](https://www.open-mpi.org/)
