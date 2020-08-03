#!/bin/bash

# compute BLEU
#changed for agenda atm katja

export TEST_TARGETS_REF0=data/AGENDA/dev-all-notdelex-reference0.lex
# export TEST_TARGETS_REF1=agenda_references/dev-all-notdelex-reference1.lex
# export TEST_TARGETS_REF2=agenda_references/dev-all-notdelex-reference2.lex
# export TEST_TARGETS_REF3=../data/webnlg/all-notdelex-reference3.lex
# export TEST_TARGETS_REF4=../data/webnlg/all-notdelex-reference4.lex
# export TEST_TARGETS_REF5=../data/webnlg/all-notdelex-reference5.lex
# export TEST_TARGETS_REF6=../data/webnlg/all-notdelex-reference6.lex
# export TEST_TARGETS_REF7=../data/webnlg/all-notdelex-reference7.lex

./webnlg_eval_scripts/multi-bleu.perl ${TEST_TARGETS_REF0} < ./data/AGENDA/relexicalised_predictions.txt

