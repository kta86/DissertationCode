#!/bin/bash

INPUT_MODEL=$1
OUTPUT=$2

CUDA_VISIBLE_DEVICES=0 python3 translate.py \
-model ${INPUT_MODEL} \
-data_type gcn \
-src data/agenda/dev-agenda-all-notdelex-src-nodes.txt \
-tgt data/agenda/dev-agenda-all-notdelex-tgt.txt \
-src_label data/agenda/dev-agenda-all-notdelex-src-labels.txt \
-src_node1 data/agenda/dev-agenda-all-notdelex-src-node1.txt \
-src_node2 data/agenda/dev-agenda-all-notdelex-src-node2.txt \
-output data/agenda/delex_preds_${OUTPUT}.txt \
-replace_unk \
-verbose \
-report_bleu
