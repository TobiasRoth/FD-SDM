#------------------------------------------------------------------------------------------------------
# Settings and load data
#------------------------------------------------------------------------------------------------------
# Libraries
library(tidyverse)
library(eHOF)
library(knitr)

# Load data
load("Res_HOF/mod_Pl.RData")
load("Res_HOF/mod_PlZ9.RData")
load("Res_HOF/mod_Bi.RData")
load("Res_HOF/mod_Bu.RData")

#------------------------------------------------------------------------------------------------------
# Make tibble with results
#------------------------------------------------------------------------------------------------------
res <- tibble(`Species group` = c("Plants", "Plants", "Butterflies", "Birds"),
       Scale = c("local", "landscape", "landscape", "landscape"),
       `Number of species` = c(length(mod_PlZ9), length(mod_Pl), length(mod_Bu), length(mod_Bi)),
       `Prob I` = 0,
       `Prob II` = 0,
       `Prob III` = 0,
       `Prob IV` = 0,
       `Prob V` = 0,
       `Prob VI` = 0,
       `Prob VII` = 0)

tt <- pick.model(mod_PlZ9); res[1, paste("Prob", names(table(tt)))] <- table(tt) / sum(table(tt))
tt <- pick.model(mod_Pl); res[2, paste("Prob", names(table(tt)))] <- table(tt) / sum(table(tt))
tt <- pick.model(mod_Bu); res[3, paste("Prob", names(table(tt)))] <- table(tt) / sum(table(tt))
tt <- pick.model(mod_Bi); res[4, paste("Prob", names(table(tt)))] <- table(tt) / sum(table(tt))

# mod_Bi[[1]]$models$IV$par

kable(res, digits = 3,
      caption = "Results of HOF models.") %>% 
  print
