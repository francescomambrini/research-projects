#!/usr/bin/env python
# -*- coding: UTF-8 -*-

"""Generate the data to produce syntactic networks (with and withoud deprel as
edge label) and/or co-occurrence networks from the Universal Dependencies treebanks.
The csv output files are saved in the following path:
'network_files'/<treebank_name>/<file_name>.csv

Usage:
  syntacticNetwork.py [--threshold=<nr.>] (-a | -r | -n | -c) <treebank_dir>
	
Options:
  -r, --rel        produce only the data for syntactic network with deprel edge label
  -n, --norel      produce only the data for syntactic network without deprel edge label
  -c, --cooc       produce only the data for co-occurrence network
  -a, --all        produce the data for all the three networks above
  --threshold=NR  number of tokens after which the treebanks will be cut [default: 200000]

"""

import nltk
import re
import os
from glob import glob
import pandas as pd
from nltk.grammar import DependencyGrammar
from nltk.parse import DependencyGraph
from nltk.corpus.reader.dependency import DependencyCorpusReader
from nltk import bigrams
import docopt
import logging

logging.basicConfig(filename="syntacticNetwork.log", level=logging.INFO)


def fixed_parsed_sents(self, fileids=None, top_label="root"):
    from nltk.corpus.reader.util import concat
    from nltk.corpus.reader.dependency import DependencyCorpusView
    from nltk.parse import DependencyGraph
    
    sents=concat([DependencyCorpusView(fileid, False, True, True, encoding=enc)
                  for fileid, enc in self.abspaths(fileids, include_encoding=True)])
    return [DependencyGraph(sent, top_relation_label=top_label, cell_separator="\t") for sent in sents]

DependencyCorpusReader.parsed_sents = fixed_parsed_sents

def new_triples(self, node=None, word_label = "word", tag_label="ctag"):
        """
        Extract dependency triples of the form:
        ((head word, head tag), rel, (dep word, dep tag))
        """
        
        from itertools import chain
        
        assert word_label in ["word", "lemma"], "Select either word or lemma as label!"
        assert tag_label in ["tag", "ctag"], "Select either tag or ctag as label!"

        if not node:
            node = self.root

        head = (node[word_label], node[tag_label])
        for i in sorted(chain.from_iterable(node['deps'].values())):
            dep = self.get_by_address(i)
            yield (head, dep['rel'], (dep[word_label], dep[tag_label]))
            for triple in self.triples(node=dep, word_label=word_label, tag_label=tag_label):
                yield triple

DependencyGraph.triples = new_triples

def hasPunctHead(parsed_sent):
    for n in parsed_sent.triples():
        if n[0][1] == "PUNCT":
            return True
    return False

def countNodes(parsed_sent):
    """count the tokens in a sentence (purging punctuation);
    :return: int: the count
    """
    i =0
    for k,v in parsed_sent.nodes.items():
        if v["ctag"] == "PUNCT" or v["ctag"] == "TOP":
            continue
        else:
            i +=1
    return i
    
def getCoocInSent(parsed_sent):

    ns = parsed_sent.nodes
    lemma_list = [ns[w]["lemma"] for w in ns.keys() 
              if ns[w]["lemma"] != None and ns[w]["ctag"] != "PUNCT"]
    return list(bigrams(lemma_list))

def coocData(parsed_sents):
    w1, w2 = [], []
    for s in parsed_sents:
        sent = getCoocInSent(s)
        for line in sent:
            w1.append(line[0])
            w2.append(line[1])
    return pd.DataFrame({"Prec": w1, "Seq" : w2})

def getNetworkDataFrames(parsed_sents, threshold=200000):
    """Process the parsed DependencyGraphs and return the DFs with 
    :param: parsed_sents: list of parsed Dependency Graphs
    :param: threshold: the iteration over sentences will stop after the sentence that 
    exceeds the give threshold
    :return: tuple of DataFrames (head-dep values, cooccurence values)
    """
    head, dep, rel = [], [], []
    w1, w2 = [], []
    token_count = 0
    puncthead = 0
    for i,s in enumerate(parsed_sents, start=1):
        if hasPunctHead(s) == False:
            #co-occurence data
            sent = getCoocInSent(s)
            for line in sent:
                w1.append(line[0])
                w2.append(line[1])
            #syntax-based
            for n in s.triples(word_label="lemma"):
                if n[0][1] == 'PUNCT':
                    print("{}: Punctuation as head!".format(i-1))
                    break
                if n[2][1] == "PUNCT":
                    continue
                head.append(n[0][0])
                #htag.append(n[0][1])
                #clean relation feature:
                rel.append(n[1].split(":")[0])
                dep.append(n[2][0])
                #dtag.append(n[2][1])
            token_count = token_count + countNodes(s)
        else:
            puncthead += 1
        if token_count > threshold:
            logging.info("Sentences with punctuation as head: {}".format(puncthead))
            logging.info("Nr. of Sentences included: {}".format(i))
            logging.info("Nr. of Tokens included: {}".format(token_count))
            print("Finalizing the Dataframe at {} tokens after {} sentences".format(token_count, i))
            break
    df_dep = pd.DataFrame({"Head_Lemma" : head, "Dep_Lemma" : dep, "Relation" : rel })
    df_dep = df_dep[["Head_Lemma", "Dep_Lemma", "Relation"]]
    df_co = pd.DataFrame({"Prec": w1, "Seq" : w2})
    return (df_dep, df_co)
    
def countEdges(df):
    """Read dataframe and return a new dataframe with counts
    """
    tab = pd.pivot_table(df,index=list(df.columns), aggfunc=len)
    newdf = tab.to_frame("Count")
    newdf.reset_index(inplace=True)
    return newdf

def writeCSV(df, filepath):
    df.to_csv(filepath, sep="\t", header=True, index=False)

if __name__ == "__main__":
    #argument parsing
    arguments = docopt.docopt(__doc__)
    th = int(arguments["--threshold"])
    tbroot = arguments["<treebank_dir>"]

    assert os.path.isdir(tbroot), "<treebank_dir> must be a directory"
    
    tbname = os.path.split(tbroot.rstrip("/"))[-1]
    logging.info("Working with treebank: {}".format(tbname))
    unidep = DependencyCorpusReader(tbroot, r".*\.conllx")
    print(', '.join(unidep.fileids()))
    parsed = unidep.parsed_sents()
    df_raw_dep, df_raw_co = getNetworkDataFrames(parsed, threshold=200000)

    #the three DF's
    df_dep_rel = countEdges(df_raw_dep)
    df_dep_norel = countEdges(df_raw_dep[["Dep_Lemma","Head_Lemma"]])
    df_cooc = countEdges(df_raw_co)
    
    #write
    lang = unidep.fileids()[0][:2]
    outdir = os.path.join("network_files", tbname)
    os.makedirs(outdir, exist_ok=True)
    
    if arguments["--all"] or arguments["--rel"]:
        writeCSV(df_dep_rel, os.path.join(outdir, lang+ "_syntax_deprel.csv"))
    
    if arguments["--all"] or arguments["--norel"]:
        writeCSV(df_dep_norel, os.path.join(outdir, lang+ "_syntax_no-deprel.csv"))
    
    if arguments["--all"] or arguments["--cooc"]:
        writeCSV(df_cooc, os.path.join(outdir, lang+ "_cooccurrence.csv"))