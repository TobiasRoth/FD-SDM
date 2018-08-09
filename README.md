# Functional Diversity and species distribution models

## Aim of the study
xxx

## Description of main files
- `Bibliography.bib`: Contains the bibliography in BibTeX format.

- `MS-Roth_et_al.Rmd`: File that contains the title page of the manuscript inclding affiliations, abstract etc as well as different format-settings. This file should be run to produce the pdf of the mansuscript. When running this file it will also run `MS-Content.Rmd`.

- `MS-Roth_et_al.pdf`: PDF with that manuscript produced when running `MS-Roth_et_al.Rmd`.

- `MS-Content.Rmd`: Contains the main content of the manuscript. It will be sourced when running `MS-Roth_et_al.Rmd`.

## Description of folders

### Figures
This folder contains the pdf files of the figures presented in the manuscript. These are produced when kniting `MS-Roth_et_al.Rmd`.

### R
Contains the follwong `R` files:

- `Data_processing.R`: Collects the data from the BDM data-base and stores them as `.RData` files in the corresponding folder. It also prepares other data needed for the study.

### RData
This folder contains the following `.RData` files:

- `commat_Bi.RData`: 

- `commat_Bu.RData`: 
