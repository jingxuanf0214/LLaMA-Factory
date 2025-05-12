#! /bin/bash
#SBATCH --job-name=verl-gsm8k-sft
#SBATCH -c 16                                    # Number of cores (-c)
#SBATCH -t 0-04:00                              # Runtime in D-HH:MM, minimum of 10 minutes
#SBATCH -p seas_gpu                             # Partition to submit to
#SBATCH -n 1                                    # XM: num of nodes
#SBATCH --gres=gpu:nvidia_h100_80gb_hbm3:1      # GPU resources
#SBATCH --account=brenner_lab               # Account to charge
#SBATCH --mem-per-cpu=8G
#SBATCH -o sbatch_logs/%j.out    # File to which STDOUT will be written, %j inserts jobid
#SBATCH -e sbatch_logs/%j.err    # File to which STDERR will be written, %j inserts jobid
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=jfan@g.harvard.edu

set -x -e
source ~/.bashrc
module load python
conda deactivate
conda activate llamafac
module load cuda/12.2.0-fasrc01
echo "PYTHON ENV: $(which python)"

cd /n/netscratch/konkle_lab/Everyone/Jingxuan/LLaMA-Factory

llamafactory-cli train examples/train_lora/llama3.2_3b_lora_sft.yaml