[![DOI](https://zenodo.org/badge/779834595.svg)](https://zenodo.org/doi/10.5281/zenodo.10901351)

## Overview
This repository provides input sample sheets for running data through 
[the scUTRquant pipeline](https://github.com/Mayrlab/scUTRquant)
as well as scripts for downloading the raw data. The results of these pipelines were analyzed in [*Fansler et al., bioRxiv, 2023*](https://www.biorxiv.org/content/10.1101/2021.11.22.469635v2).

## Use
Each folder here can be placed in the `input/` directory of the `scUTRquant` pipeline.
That is, when setting up the pipeline, one can do:

```bash
## download scUTRquant
git clone https://github.com/Mayrlab/scUTRquant.git

## download inputs
git clone https://github.com/Mayrlab/scUTRquant-inputs.git scUTRquant/input
```

Each folder contains code to download the raw data. Most of these are in the form of Snakemake pipelines. For example, one can download the Tabula Muris dataset with:

```bash
cd scUTRquant/input/tmuris
snakemake --use-conda
```

Once the data has downloaded, one can run `scUTRquant` from the root of the `scUTRquant/` folder:

```bash
snakemake --use-conda --configfile input/tmuris/config_scutr_quant.yaml
```
