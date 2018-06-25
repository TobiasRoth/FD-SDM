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

#------------------------------------------------------------------------------------------------------
# apply HOF
#------------------------------------------------------------------------------------------------------
ausw <- names(commat_PlZ9)[apply(commat_PlZ9, 2, sum) > 10]
commat_Pl <- commat_Pl[, match(ausw, names(commat_Pl))]
commat_PlZ9 <- commat_PlZ9[, match(ausw, names(commat_PlZ9))]

mod_Pl <- HOF(commat_Pl, sites$bio1, freq.limit = 1, bootstrap = 1)
save(mod_Pl, file = "Res_HOF/mod_Pl.RData")

mod_PlZ9 <- HOF(commat_PlZ9, sitesZ9$bio1, freq.limit = 1, bootstrap = 1)
save(mod_PlZ9, file = "Res_HOF/mod_PlZ9.RData")

tt <- pick.model(mod_Pl); table(tt); table(tt)[names(table(tt)) == "IV"]/ sum(table(tt))
tt <- pick.model(mod_PlZ9); table(tt); table(tt)[names(table(tt)) == "IV"]/ sum(table(tt))


Z7 <- pick.model(mod_Pl)
Z9 <- pick.model(mod_PlZ9)

mean(Z7 == Z9)

I  II III  IV   V  VI VII 
42  51  73 219  85  18  32 
IV 
0.4211538 