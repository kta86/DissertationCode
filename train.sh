#!/bin/bash


RNN_SIZE=256
EMB_SIZE=256
RNN_LAYERS=2
GCN_SIZE=256
GCN_LAYERS=1
EPOCHS=20

CUDA_VISIBLE_DEVICES=0 python train.py \
	-data data/gcn_exp \
	-save_model data/tmp_rnn_${RNN_SIZE}_${RNN_LAYERS}_layer_emb_${EMB_SIZE}_gcn_${GCN_SIZE}_${GCN_LAYERS}_layers \
	-rnn_size ${RNN_SIZE} \
	-word_vec_size ${EMB_SIZE} \
	-layers ${RNN_LAYERS} \
	-epochs ${EPOCHS} \
	-batch_size 128 \
	-optim adam \
	-learning_rate 0.001 \
	-encoder_type gcn \
	-gcn_num_inputs ${GCN_SIZE} \
	-gcn_num_units ${GCN_SIZE} \
	-gcn_in_arcs -gcn_out_arcs \
	-gcn_num_layers ${GCN_LAYERS} \
	-gcn_num_labels 5 \
	-copy_attn \
	-pre_word_vecs_dec data/gcn_exp.embeddings.dec.pt \
	-gpuid 0
