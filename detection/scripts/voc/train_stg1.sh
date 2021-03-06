# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# --simple_path makes train_log/${DATASET}/${EXPNAME} as exact location to save
# DATASET='VOC2007/instances_trainval'
# TESTSET='VOC2007/instances_test'
# CKPT_PATH=result/${DATASET}
# export CUDA_VISIBLE_DEVICES=0

python3 train_stg1.py \
    --logdir=${CKPT_PATH} --simple_path --config \
    BACKBONE.WEIGHTS=${COCODIR}/ImageNet-R50-AlignPadding.npz \
    DATA.BASEDIR=${VOCDIR}/VOCdevkit \
    DATA.TRAIN="('${DATASET}',)" \
    DATA.VAL="('${TESTSET}',)" \
    MODE_MASK=False \
    PREPROC.MAX_SIZE=1000 \
    FRCNN.BATCH_PER_IM=256 \
    TRAIN.EVAL_PERIOD=20 \
    TRAIN.LR_SCHEDULE=[7500,10000] \
    TRAIN.NUM_GPUS=1 \
    TRAIN.AUGTYPE_LAB='default' \
    $@
