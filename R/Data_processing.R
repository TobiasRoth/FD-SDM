rm(list=ls(all=TRUE))

#------------------------------------------------------------------------------------------------------
# Settings
#------------------------------------------------------------------------------------------------------
# Libraries
library(tidyverse)

# Connection to data base
db <- src_sqlite(path = "~/Documents/Dropbox/DB_BDM.db", create = FALSE)

#------------------------------------------------------------------------------------------------------
# Prepare site data
#------------------------------------------------------------------------------------------------------
# Z7
sites <- tbl(db, "KD_Z7") %>% 
  left_join(tbl(db, "RAUMDATEN_Z7")) %>% 
  left_join(tbl(db, "STICHPROBE_Z7")) %>% 
  filter(Aufnahmetyp == "Normalaufnahme_Z7") %>% 
  filter(yearP >= 2012 & yearP <= 2016) %>% 
  filter(BDM_Verdichtung == "nein") %>% 
  transmute(aID_KD = aID_KD,
            aID_STAO = aID_STAO,
            yearPl = yearPl,
            yearBi = yearBi,
            yearBu = yearBu,
            bio1 = bio1 / 10) %>% 
  as.tibble() %>% 
  filter(!is.na(yearPl) & !is.na(yearBi) & !is.na(yearBu))
sites <- sites[order(sites$aID_STAO), ]

# Z9
sitesZ9 <- tbl(db, "KD_Z9") %>% 
  left_join(tbl(db, "RAUMDATEN_Z9")) %>% 
  left_join(tbl(db, "STICHPROBE_Z9")) %>% 
  filter(Aufnahmetyp == "Normalaufnahme_Z9") %>% 
  filter(yearP >= 2012 & yearP <= 2016) %>% 
  filter(BDM_Verdichtung == "nein") %>% 
  transmute(aID_KD = aID_KD,
            aID_STAO = aID_STAO,
            yearPl = yearPl,
            bio1 = bio1 / 10) %>% 
  as.tibble() %>% 
  filter(!is.na(yearPl))
sitesZ9 <- sitesZ9[order(sitesZ9$aID_STAO), ]

#------------------------------------------------------------------------------------------------------
# Prepare community matrices
#------------------------------------------------------------------------------------------------------
# Plants Z7
commat_Pl <- tbl(db, "PL") %>% 
  filter(Z7 == 1) %>% 
  left_join(tbl(db, "KD_Z7")) %>% 
  as.tibble() %>% 
  filter(!is.na(aID_SP)) %>% 
  filter(!is.na(match(aID_KD, sites$aID_KD))) %>% 
  transmute(aID_STAO = aID_STAO,
            aID_SP = aID_SP) %>% 
  table()
commat_Pl <- commat_Pl[order(dimnames(commat_Pl)$aID_STAO), ]

# Plants Z9
tt <- tbl(db, "PL") %>% 
  filter(Z7 == 0) %>% 
  left_join(tbl(db, "KD_Z9")) %>% 
  as.tibble() %>% 
  filter(!is.na(aID_SP)) %>% 
  filter(!is.na(match(aID_KD, sitesZ9$aID_KD))) %>% 
  transmute(aID_STAO = aID_STAO,
            aID_SP = aID_SP) 
tt$aID_STAO <- factor(tt$aID_STAO, levels = sitesZ9$aID_STAO)
commat_PlZ9 <- table(tt)
commat_PlZ9 <- commat_PlZ9[order(dimnames(commat_PlZ9)$aID_STAO), ]

# Birds
commat_Bi <- tbl(db, "Bi") %>% 
  left_join(tbl(db, "KD_Z7")) %>% 
  as.tibble() %>% 
  filter(!is.na(aID_SP)) %>% 
  filter(!is.na(match(aID_KD, sites$aID_KD))) %>% 
  transmute(aID_STAO = aID_STAO,
            aID_SP = aID_SP) %>% 
  table()
commat_Bi <- commat_Bi[order(dimnames(commat_Bi)$aID_STAO), ]

# Butterflies
commat_Bu <- tbl(db, "TF") %>% 
  left_join(tbl(db, "KD_Z7")) %>% 
  as.tibble() %>% 
  filter(!is.na(aID_SP)) %>% 
  filter(!is.na(match(aID_KD, sites$aID_KD))) %>% 
  transmute(aID_STAO = aID_STAO,
            aID_SP = aID_SP) %>% 
  table()
commat_Bu <- commat_Bu[order(dimnames(commat_Bu)$aID_STAO), ]


#------------------------------------------------------------------------------------------------------
# Hide coorination IDs and save data-objects
#------------------------------------------------------------------------------------------------------
siteID <- 1:nrow(sites)
dimnames(commat_Pl)$aID_STAO <- siteID[match(dimnames(commat_Pl)$aID_STAO, sites$aID_STAO)]
dimnames(commat_Bi)$aID_STAO <- siteID[match(dimnames(commat_Bi)$aID_STAO, sites$aID_STAO)]
dimnames(commat_Bu)$aID_STAO <- siteID[match(dimnames(commat_Bu)$aID_STAO, sites$aID_STAO)]
sites$aID_STAO <- siteID

siteID <- 1:nrow(sitesZ9)
dimnames(commat_PlZ9)$aID_STAO <- siteID[match(dimnames(commat_PlZ9)$aID_STAO, sites$aID_STAO)]
sitesZ9$aID_STAO <- siteID

commat_Pl <- array(commat_Pl, dim = dim(commat_Pl)) %>% data.frame
commat_PlZ9 <- array(commat_PlZ9, dim = dim(commat_PlZ9)) %>% data.frame
commat_Bi <- array(commat_Bi, dim = dim(commat_Bi)) %>% data.frame
commat_Bu <- array(commat_Bu, dim = dim(commat_Bu)) %>% data.frame

save(sites, file = "RData/sites.RData")
save(sitesZ9, file = "RData/sitesZ9.RData")
save(commat_Pl, file = "RData/commat_Pl.RData")
save(commat_PlZ9, file = "RData/commat_PlZ9.RData")
save(commat_Bi, file = "RData/commat_Bi.RData")
save(commat_Bu, file = "RData/commat_Bu.RData")

