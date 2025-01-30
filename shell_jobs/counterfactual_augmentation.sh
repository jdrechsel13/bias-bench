#!/bin/bash

source "shell_jobs/_experiment_configuration.sh"
#export CUDA_VISIBLE_DEVICES=0

models=("bert-base-cased" "bert-large-cased" "roberta-large" "distilbert-base-cased")

bias_types=("gender")
seeds=(0)
for seed in ${seeds[@]}; do
  for model in ${models[@]}; do
        for bias_type in ${bias_types[@]}; do
          experiment_id="cda_c-${model}_t-${bias_type}_s-${seed}"

          if [ ! -d "${persistent_dir}/results/checkpoints/${experiment_id}" ]; then
              echo ${experiment_id}
              python experiments/run_mlm.py \
                  --model_name_or_path ${model} \
                  --do_train \
                  --train_file "${persistent_dir}/data/text/wikipedia-10.txt" \
                  --max_steps 2000 \
                  --per_device_train_batch_size 32 \
                  --gradient_accumulation_steps 16 \
                  --max_seq_length 512 \
                  --save_steps 500 \
                  --preprocessing_num_workers 4 \
                  --counterfactual_augmentation "${bias_type}" \
                  --seed ${seed} \
                  --output_dir "${persistent_dir}/results/checkpoints/${experiment_id}" \
                  --persistent_dir ${persistent_dir}
          else
              echo "${experiment_id} already computed"
          fi
        done
    done
done
