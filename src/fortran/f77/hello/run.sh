#! /bin/bash
if [ "$#" -eq 2 ]; then
   echo "Using: F77 source code file " $1"; SGE job submission script " $2
   cwd=$PWD
   dir=/nobackup/$USER/$cwd
   outDir=$dir/data/output
   mkdir -p $outDir
   cp * $dir/.
   cd $dir
   echo "Copied all files to: "$cwd
   command="mpif77 -O2 -xAVX -o "$1".o "$1
   echo "Compiling using: "$command
   `$command`
   echo "Submitting job..."
   command="qsub "$2
   jobDetails=`$command`
   echo "... done"
   echo "Job details: "$jobDetails
   jobID=`echo $jobDetails | awk '{print $3}'`
   echo "To check status of the job run: qstat"
   echo "The file: "$dir"/"$qsubScript".o"$jobID" is to contain what was redirected from stdout from the job submission."
   echo "The file: "$dir"/"$qsubScript".e"$jobID" is to contain what was redirected from stderr from the job submission."
   echo "When the job has run, the stdout from the MPI program should be in: "$outDir"/"$jobID".txt"
   echo "After the job has completed. Use the following to check what resources were used: qacct "$jobID
else
    echo "Please provide two argument: the source code file to compile and run; the name of the job submission script."
fi
