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

echo "==========================================================" 
echo "Starting on : $(date)"
echo "Running on node : $(hostname)"
echo "Current directory : $(pwd)"
echo "Current job ID : $JOB_ID"
echo "Current job name : $JOB_NAME"
echo "Task index number : $SGE_TASK_ID"
echo "==========================================================" 

module load matlab/2020b

matlab -singleCompThread -nodisplay -r ML_example_2.m

echo "=========================================================="
echo "Finished on : $(date)"
echo "=========================================================="
