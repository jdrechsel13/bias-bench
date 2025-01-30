# GRADIEND: Monosemantic Feature Learning within Neural Networks Applied to Gender Debiasing
> Jonathan Drechsel, Steffen Herbold

This repository contains the official source code for the evaluation of [GRADIEND: Monosemantic Feature Learning within Neural Networks Applied to Gender Debiasing](todo).

The main difference compared to the original repository [bias-bench](https://github.com/McGill-NLP/bias-bench) are:

- added support for other base models (e.g., `distilbert-base-cased`, `roberta-large`, `bert-large-cased`, `microsoft/deberta-v3-large`)
- added support for the GRADIEND model evaluation (the training of the GRADIEND models needs to be done in the original GRADIEND repository)
- added support for bootstrapping evaluation of all evaluated metrics (SEAT, SS, CrowS, LMS, GLUE)

## Install
```bash
git clone https://github.com/aieng-lab/bias-bench.git
cd bias-bench 
conda create --file environment.yml
```

Install [aieng-lab/gradiend](https://github.com/aieng-lab/gradiend) for the GRADIEND model training. Both repositories should be in the same directory.

## Required Datasets
Below, a list of the external datasets required by this repository is provided:

Dataset | Download Link | Notes | Download Directory
--------|---------------|-------|-------------------
Wikipedia-2.5 | [Download](https://drive.google.com/file/d/1JSlm8MYDbNjpMPnKbb91T-xZnlWAZmZl/view?usp=sharing) | English Wikipedia dump used for SentenceDebias and INLP. | `data/text`
Wikipedia-10 | [Download](https://drive.google.com/file/d/1boQTn44RnHdxWeUKQAlRgQ7xrlQ_Glwo/view?usp=sharing) | English Wikipedia dump used for CDA and Dropout. | `data/text`

Each dataset should be downloaded to the specified path, relative to the root directory of the project.

## Experiments
We provide scripts for running all of the experiments presented in the paper.
Generally, each script takes a `--model` argument and a `--model_name_or_path` argument.
We briefly describe the script(s) for each experiment below:

* **CrowS-Pairs**: Two scripts are provided for evaluating models against CrowS-Pairs: `experiments/crows.py` evaluates non-debiased
  models against CrowS-Pairs and `experiments/crows_debias.py` evaluates debiased models against CrowS-Pairs.
* **INLP Projection Matrix**: `experiments/inlp_projection_matrix.py` is used to compute INLP projection matrices.
* **SEAT**: Two scripts are provided for evaluating models against SEAT: `experiments/seat.py` evaluates non-debiased models against SEAT and
  `experiments/seat_debias.py` evaluates debiased models against SEAT.
* **StereoSet**: Two scripts are provided for evaluating models against StereoSet: `experiments/stereoset.py` evaluates non-debiased models against StereoSet and
  `experiments/stereoset_debias.py` evaluates debiased models against StereoSet.
* **SentenceDebias Subspace**: `experiments/sentence_debias_subspace.py` is used to compute SentenceDebias subspaces.
* **GLUE**: `experiments/run_glue.py` is used to run the GLUE benchmark.
* **Perplexity**: `experiments/perplexity.py` is used to compute perplexities on WikiText-2.

To recreate the experiments performed in the paper, you can run the following scripts in `shell_jobs`:
* `counterfactual_augmentation.sh` to create the CDA models
* `dropout.sh` to create the Dropout models
* `inlp_projection_matrix.sh` to create the INLP models
* `sentence_debias_subspace.sh` to create the SentenceDebias models
* `crows.sh` to evaluate the CrowS-Pairs benchmark for the base models
* `crows_debias.sh` to evaluate the CrowS-Pairs benchmark for the debiased models
* `seat.sh` to evaluate the SEAT benchmark for the base models
* `seat_debias.sh` to evaluate the SEAT benchmark for the debiased models
* `stereoset.sh` to evaluate the StereoSet benchmark for the base models
* `stereoset_debias.sh` to evaluate the StereoSet benchmark for the debiased models
* `glues.sh` to evaluate GLUE for all models (this script will take a long time to run, you may want to split it into multiple sub-scripts)

Note that these scripts must be run from the root directory of the project.
Moreover, before running these scripts, the gradiend results must be computed first!
You may need to adjust the paths in `shell_jobs/_experiment_configuration.sh` to match your local setup (`persistent_dir` and `gradiend_dir`).

### Notes
* To run SentenceDebias models against any of the benchmarks, you will first need to run `experiments/sentence_debias_subspace.py`.
* To run INLP models against any of the benchmarks, you will first need to run `experiments/inlp_projection_matrix.py`.
* `export` contains the script `bootstrap_results.py` containing functions (`print_main_table()`, `print_full_glue_table()`, `print_full_seat_table()`) to generate the result tables presented in the paper.
* All python programs and shell scripts must be started from the bias-bench root directory to make sure that the relative paths are correct.

## Running on an HPC Cluster TODO
We provide scripts for running all of the experiments presented in the paper on a SLURM cluster in `batch_jobs`.
If you plan to use these scripts, make sure you customize `python_job.sh` to run the jobs on your cluster.
In addition, you will also need to change both the output (`-o`) and error (`-e`) paths.

## Acknowledgements
This repository makes use of code from the following repositories:

* [Towards Debiasing Sentence Representations](https://github.com/pliang279/sent_debias)
* [StereoSet: Measuring Stereotypical Bias in Pre-trained Language Models](https://github.com/moinnadeem/stereoset)
* [CrowS-Pairs: A Challenge Dataset for Measuring Social Biases in Masked Language Models](https://github.com/nyu-mll/crows-pairs)
* [On Measuring Social Biases in Sentence Encoders](https://github.com/w4ngatang/sent-bias)
* [Null It Out: Guarding Protected Attributes by Iterative Nullspace Projection](https://github.com/shauli-ravfogel/nullspace_projection)
* [Towards Understanding and Mitigating Social Biases in Language Models](https://github.com/pliang279/lm_bias)
* [Self-Diagnosis and Self-Debiasing: A Proposal for Reducing Corpus-Based Bias in NLP](https://direct.mit.edu/tacl/article/doi/10.1162/tacl_a_00434/108865/Self-Diagnosis-and-Self-Debiasing-A-Proposal-for)

We thank the authors for making their code publicly available.

## Citation
If you use the code in this repository, please cite the following papers:
TODO

Original Work of the framework:
```bibtex
    @inproceedings{meade_2022_empirical,
        title = "An Empirical Survey of the Effectiveness of Debiasing Techniques for Pre-trained Language Models",
        author = "Meade, Nicholas  and Poole-Dayan, Elinor  and Reddy, Siva",
        booktitle = "Proceedings of the 60th Annual Meeting of the Association for Computational Linguistics (Volume 1: Long Papers)",
        month = may,
        year = "2022",
        address = "Dublin, Ireland",
        publisher = "Association for Computational Linguistics",
        url = "https://aclanthology.org/2022.acl-long.132",
        doi = "10.18653/v1/2022.acl-long.132",
        pages = "1878--1898",
    }
```