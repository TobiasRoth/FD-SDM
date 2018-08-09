rm(list=ls(all=TRUE))

#------------------------------------------------------------------------------------------------------
# Settings and load data
#------------------------------------------------------------------------------------------------------
# Libraries
library(tidyverse)
library(eHOF)

# Load data
load("RData/sites.RData")
load("RData/sitesZ9.RData")
load("RData/commat_Pl.RData")
load("RData/commat_PlZ9.RData")
load("RData/commat_Bi.RData")
load("RData/commat_Bu.RData")

# Settings
freq.limit <- 1 

#------------------------------------------------------------------------------------------------------
# apply HOF
#------------------------------------------------------------------------------------------------------
mod_Pl <- HOF(commat_Pl, sites$bio1, freq.limit = freq.limit, bootstrap = 1)
save(mod_Pl, file = "Res_HOF/mod_Pl.RData")

mod_PlZ9 <- HOF(commat_PlZ9, sitesZ9$bio1, freq.limit = 1, bootstrap = 1)
save(mod_PlZ9, file = "Res_HOF/mod_PlZ9.RData")

mod_Bi <- HOF(commat_Bi, sites$bio1, freq.limit = freq.limit, bootstrap = 1)
save(mod_Bi, file = "Res_HOF/mod_Bi.RData")

mod_Bu <- HOF(commat_Bu, sites$bio1, freq.limit = freq.limit, bootstrap = 1)
save(mod_Bu, file = "Res_HOF/mod_Bu.RData")
