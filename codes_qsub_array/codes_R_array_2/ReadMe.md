This file demonstrate the steps on how to use `array` to more efficiently submit several batches at one time (with a R example)

**Purpose**: when you have multiple code files and need to submit all of them; instead of submitting many batch files, use `array` to submit just once. 

1). Log onto scc through your terminal with codes: ssh Your_Name@scc1.bu.edu

2). Upload your batch file and R code files to clusters (e.g. using FileZilla)

3). Run your batch with codes: qsub -P econdept batch_example.sh

4). You will receive multiple results when your task is done. Check your folder with the log file and other documents you chose to export
