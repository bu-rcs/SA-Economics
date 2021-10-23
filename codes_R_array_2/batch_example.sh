#!/bin/sh -l

# "Set the run time limit for the job. The default is 12 hours.
# There is no advantage in queue scheduling when requesting
# <12 hours, but as an example this job is set to have a 2 hour limit." 

#$ -l h_rt=2:00:00

# "Email yourself when the job finishes."

#$ -m e

# "Join the console output and error files. This is optional."

#$ -j y 

# "Give the job a name, the console output file will be named
# econ_stata_demo.oXYZ where XYZ is the job number."

#$ -N econ_R_demo

# This will launch 4 jobs
# 1 for each Matlab script. 
#$ -t 1-4

echo "==========================================================" 
echo "Starting on : $(date)"
echo "Running on node : $(hostname)"
echo "Current directory : $(pwd)"
echo "Current job ID : $JOB_ID"
echo "Current job name : $JOB_NAME"
echo "Task index number : $SGE_TASK_ID"
echo "==========================================================" 

module load R

MFILES=(gmm_example_1.R gmm_example_2.R gmm_example_3.R gmm_example_4.R)

# Do some arithmetic to convert to a valid index
# Bash arrays index starting at 0.
INDEX=$(( $SGE_TASK_ID - 1 ))

# Pick a script to run
THIS_MFILE=${MFILES[$INDEX]}


R --vanilla < $THIS_MFILE > output_all_$INDEX.Rout

echo "=========================================================="
echo "Finished on : $(date)"
echo "=========================================================="
