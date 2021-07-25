#!/bin/sh 

#$ -l h_rt=2:00:00
#$ -m e
#$ -j y 

echo "==========================================================" 
echo "Starting on : $(date)"
echo "Running on node : $(hostname)"
echo "Current directory : $(pwd)"
echo "Current job ID : $JOB_ID"
echo "Current job name : $JOB_NAME"
echo "Task index number : $SGE_TASK_ID"
echo "==========================================================" 

module load R

R --vanilla < gmm_example.R > output_all_m.Rout

echo "=========================================================="
echo "Finished on : $(date)"
echo "=========================================================="
