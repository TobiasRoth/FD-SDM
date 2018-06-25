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
freq.limit <- 20 

#------------------------------------------------------------------------------------------------------
# apply HOF
#------------------------------------------------------------------------------------------------------
mod_Pl <- HOF(commat_Pl, sites$bio1, freq.limit = freq.limit, bootstrap = 1)
save(mod_Pl, file = "Res_HOF/mod_Pl.RData")


ausw <- names(commat_Pl)[apply(commat_Pl, 2, sum) >= 20]

!is.na(match(names(commat_PlZ9), ausw))

mod_PlZ9 <- HOF(commat_PlZ9[, !is.na(match(names(commat_PlZ9), ausw))], sitesZ9$bio1, freq.limit = 1, bootstrap = 1)
save(mod_PlZ9, file = "Res_HOF/mod_PlZ9.RData")

mod_Bi <- HOF(commat_Bi, sites$bio1, freq.limit = freq.limit, bootstrap = 1)
save(mod_Bi, file = "Res_HOF/mod_Bi.RData")

mod_Bu <- HOF(commat_Bu, sites$bio1, freq.limit = freq.limit, bootstrap = 1)
save(mod_Bi, file = "Res_HOF/mod_Bu.RData")


tt <- pick.model(mod_Pl); table(tt); table(tt)[names(table(tt)) == "IV"]/ sum(table(tt))
tt <- pick.model(mod_PlZ9); table(tt); table(tt)[names(table(tt)) == "IV"]/ sum(table(tt))
tt <- pick.model(mod_Bi); table(tt); table(tt)[names(table(tt)) == "IV"]/ sum(table(tt))
tt <- pick.model(mod_Bu); table(tt); table(tt)[names(table(tt)) == "IV"]/ sum(table(tt))
