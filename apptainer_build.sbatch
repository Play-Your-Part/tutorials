#!/bin/bash
#SBATCH --job-name=build_jsalt_apptainer
#SBATCH --output=build_jsalt_apptainer_%A_%a.out
#SBATCH --error=build_jsalt_apptainer_%A_%a.err
#SBATCH --partition=gpu
#SBATCH --mem=32G
#SBATCH --nodes 1
#SBATCH --time=1:30:00
#SBATCH --gpus rtx3090:1
#SBATCH --account YOUR_ACCOUNT

OUTPUT_FILE="jsalt.sif"
BASE_PATH=$(pwd)/

rsync -a $BASE_PATH /tmp
cd /tmp

# build apptainer
apptainer build --fakeroot --bind /dev/shm:/tmp $OUTPUT_FILE Apptainer
echo "Finished building $OUTPUT_FILE"

echo "Copying SIF file..."
cp $OUTPUT_FILE $BASE_PATH

echo "Finished."
