This is an adapted version of the ORIGINAL_README.md for the purpose of using the AGENDA dataset

### Preprocess

Using the files obtained in the preparation step, we first generate data and dictionary for OpenNmt.


To preprocess the raw files run:

```
python3 preprocess.py 
-train_src data/agenda/train-agenda-all-notdelex-src-nodes.txt \
-train_label data/agenda/train-agenda-all-notdelex-src-labels.txt \
-train_node1 data/agenda/train-agenda-all-notdelex-src-node1.txt \
-train_node2 data/agenda/train-agenda-all-notdelex-src-node2.txt \
-train_tgt data/agenda/train-agenda-all-notdelex-tgt.txt \
-train_title data/agenda/train-agenda-all-notdelex-title.txt \
-train_types data/agenda/train-agenda-all-notdelex-types.txt \
-valid_src data/agenda/dev-agenda-all-notdelex-src-nodes.txt \
-valid_label data/agenda/dev-agenda-all-notdelex-src-labels.txt \
-valid_node1 data/agenda/dev-agenda-all-notdelex-src-node1.txt \
-valid_node2 data/agenda/dev-agenda-all-notdelex-src-node2.txt \
-valid_tgt data/agenda/dev-agenda-all-notdelex-tgt.txt \
-valid_title data/agenda/dev-agenda-all-notdelex-title.txt \
-valid_types data/agenda/dev-agenda-all-notdelex-types.txt \
-save_data data/gcn_exp -src_vocab_size 5000 -tgt_vocab_size 5000 -data_type gcn
```

The argument ```-dynamic_dict``` is needed to train models using copy mechanism e.g., the model GCN_CE in the paper.

#### Embeddings

Using pre-trained embeddings in OpenNMT, need to do this pre-processing step first:
```
export glove_dir="../vectors"
python3 tools/embeddings_to_torch.py \
    -emb_file "$glove_dir/glove.6B.200d.txt" \
    -dict_file "data/gcn_exp.vocab.pt" \
    -output_file "data/gcn_exp.embeddings" 
```

### Train
After you preprocessed the files you can run the training procedure from the train.sh file or:
```

python3 train.py 
	-data data/gcn_exp \
	-save_model data/tmp_ \
	-rnn_size 256 \
	-word_vec_size 256 \
	-layers 1 \
	-epochs 20 \
	-batch_size 128 \
	-optim adam \
	-learning_rate 0.001 \
	-encoder_type gcn \
	-gcn_num_inputs 256 \
	-gcn_num_units 256 \
	-gcn_in_arcs -gcn_out_arcs \
	-gcn_num_layers 1 \
	-gcn_num_labels 5 \
```
Add the following argument to use copy attention:
```
    -copy_attn \
```

Add the following argument to use GPU:
```
    -gpuid 0
```

### Generate ###
Generating with obtained model can be done using translate.sh or:
```
python3 translate.py 
    -model data/tmp_       \
    -data_type gcn \
    -src data/agenda/dev-agenda-all-notdelex-src-nodes.txt \
    -tgt data/agenda/dev-agenda-all-notdelex-tgt.txt \
    -src_label data/agenda/dev-agenda-all-notdelex-src-labels.txt \
    -src_node1 data/agenda/dev-agenda-all-notdelex-src-node1.txt \
    -src_node2 data/agenda/dev-agenda-all-notdelex-src-node2.txt \
    -title data/agenda/dev-agenda-all-notdelex-title.txt \
    -output data/agenda/delexicalized_predictions_dev.txt \
    -replace_unk \
    -verbose \
    -report_bleu
```

Add the following argument to use GPU:
```
    -gpu 0
```