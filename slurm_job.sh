#!/bin/bash

echo "Job is running on $(hostname), started at $(date)"

# Get some output about GPU status before starting the job
nvidia-smi 

# Compile the code with make - this should produce the 'scanner' executable
echo "Running make to compile your code..."
srun make all

# Run the executable - you can replace the default arguments here with "$@" to pass in the arguments to this job script instead
echo "Running!"
# ./check.py signatures/sigs-simple.txt tests/simple.in
# ./check.py signatures/sigs-exact.txt tests/virus-0001-Win.Downloader.Banload-242+Win.Trojan.Matrix-8.in
./check.py signatures/sigs-both.txt \
tests/virus-0001-Win.Downloader.Banload-242+Win.Trojan.Matrix-8.in \
tests/virus-0002-Win.Downloader.Zlob-1779+Html.Phishing.Bank-532.in \
tests/virus-0003-Win.Trojan.Anti-5+Win.Trojan.Mybot-8053.in \
tests/virus-0004-Win.Worm.Gaobot-857+Win.Worm.Delf-1443+Win.Trojan.Mybot-6497.in \
tests/virus-0005-Win.Trojan.Krap-1+Win.Spyware.Banker-4712.in \
tests/virus-0006-Win.Spyware.Banker-483.in \
tests/virus-0007-Win.Trojan.Matrix-8.in \
tests/virus-0008-Win.Trojan.Agent-35503+Win.Trojan.Mybot-6324+Win.Trojan.Delf-802.in \
tests/virus-0009-Win.Worm.Gaobot-688.in \
tests/virus-0010-Win.Trojan.Corp-3.in \
tests/virus-0011-Win.Trojan.Sdbot-52.in \
tests/virus-0012-Win.Trojan.Bancos-1977+Html.Phishing.Auction-29.in \
tests/virus-0013-Win.Trojan.Pakes-518.in \
tests/virus-0014-Win.Trojan.HIV-5+Html.Phishing.Auction-29.in \
tests/virus-0015-Win.Spyware.Goldun-31.in \
tests/virus-0016-Win.Trojan.Pakes-480.in

### RECIPES: Examples of what you can run here instead of the line above
## Just runs the scanner executable directly
# srun ./scanner signatures/sigs-exact.txt tests/benign-0001.in tests/virus-0001-Win.Downloader.Banload-242+Win.Trojan.Matrix-8.in
## Works as above if you call this script as sbatch a2_slurm_job.sh signatures/sigs-exact.txt tests/benign-0001.in tests/virus-0001-Win.Downloader.Banload-242+Win.Trojan.Matrix-8.in
# ./scanner $@
## Runs the debug version of the executable with NVIDIA's Nsight Systems profile in nvprof mode
# /usr/local/cuda/bin/nsys nvprof ./scanner-debug signatures/sigs-exact.txt tests/benign-0001.in tests/virus-0001-Win.Downloader.Banload-242+Win.Trojan.Matrix-8.in

echo -e "\n====> Finished running.\n"

echo -e "\nJob completed at $(date)"

cuda-memcheck ./scanner-debug signatures/sigs-both.txt tests/virus-0017-Win.Trojan.Mybot-8097+Win.Trojan.JetHome-2.in \
