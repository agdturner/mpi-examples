#! /bin/bash
makefile="${1}"
echo $makefile
if [ -f $makefile ]; then 
  qsubScript="${2:-submit.sh}"
  if [ -f $qsubScript ]; then
    echo "Using: SGE job submission script " $qsubScript
    cwd=$PWD
    dir=/nobackup/$USER/$cwd
    outDir=$dir/data/output
    mkdir -p $outDir
    cp $makefile $dir/.
    cp * $dir/.
    cd $dir
    echo "Copied all files to: "$cwd
    command="make"
    echo "Compile using: "$command
    $command
    echo "Compiled using: "$command
    echo "Submitting job"
    command="qsub $qsubScript"
    jobDetails=$($command)
    echo "Job submitted"
    echo "Job details: "$jobDetails
    jobID=$(echo $jobDetails | awk '{print $3}')
    echo "To check status of the job run: qstat"
    echo "The file: "$dir"/"$qsubScript".o"$jobID" is to contain what was redirected from stdout from the job submission."
    echo "The file: "$dir"/"$qsubScript".e"$jobID" is to contain what was redirected from stderr from the job submission."
    echo "When the job has run, the stdout from the MPI program should be in: "$outDir"/"$jobID".txt"
    echo "After the job has completed. Use the following to check what resources were used: qacct "$jobID
  else
    echo "$qsubScript does not exist, please provide the path to the submission script as the second argument"
  fi
else
  echo "$makefile does not exist, please provide the path to the Makefile as the first argument"
fi
