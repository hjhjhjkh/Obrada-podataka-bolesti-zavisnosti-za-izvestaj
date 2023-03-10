# Script information ------------------------------------------------------

#' Project title: Obrada podataka "bolesti zavisnosti" iz .sjz.rs eksportovani za zeljeni izvestaj obrada. 
#' Script name: main.R
#' Date created: 2023-03-10
#' Date updated: 
#' Author: Milica
#' Script purpose: automatizacija pisanja izvestaja

# Ucitaj potrebne biblioteke ----------------------------------------------
library(dplyr)
library(uuid)
library(tidyverse)
library(readxl)
library(openxlsx)

# Uvezi i proveri iz eksela uvezene podatke -------------------------------
procitanEksel <- read_excel("data/baza.xlsx")
#procitanEksel

# Sredi podatke -----------------------------------------------------------
## Reimenuj imena kolona (jedna rec) -----
names(procitanEksel)[1] <- 'Id'                                                                                                                    
names(procitanEksel)[2] <- 'Okrug'                                                                                                                 
names(procitanEksel)[3] <- 'Ustanova'                                                                                                              
names(procitanEksel)[4] <- 'Organizaciona_jedinica'                                                                                                
names(procitanEksel)[5] <- 'Opština'                                                                                                               
names(procitanEksel)[6] <- 'Datum_početka_popunjavanja_prijave'                                                                                    
names(procitanEksel)[7] <- 'Datum_dostavljanja_prijave'                                                                                            
names(procitanEksel)[8] <- 'Ime'                                                                                                                   
names(procitanEksel)[9] <- 'Prezime'                                                                                                               
names(procitanEksel)[10] <- 'Državljanstvo'                                                                                                         
names(procitanEksel)[11] <- 'JMBG_EBS'                                                                                                              
names(procitanEksel)[12] <- 'Datum_rođenja'                                                                                                         
names(procitanEksel)[13] <- 'Pol'                                                                                                                   
names(procitanEksel)[14] <- 'Kod_(šifra)_lica'                                                                                                      
names(procitanEksel)[15] <- 'Prebivalište/boravište_-_naselje'                                                                                      
names(procitanEksel)[16] <- 'Gde_živi'                                                                                                              
names(procitanEksel)[17] <- 'Gde_lice_živi_-_drugo'                                                                                                 
names(procitanEksel)[18] <- 'S_kojim_punoletnim_licima_živi'                                                                                        
names(procitanEksel)[19] <- 'S_kojim_punoletnim_licima_živi_-_drugo'                                                                                
names(procitanEksel)[20] <- 'Radni_status'                                                                                                          
names(procitanEksel)[21] <- 'Radni_status_-_drugo'                                                                                                  
names(procitanEksel)[22] <- 'Najviša_završena_škola'                                                                                                
names(procitanEksel)[23] <- 'Da_li_ima_svoju_decu'                                                                                                  
names(procitanEksel)[24] <- 'Uzrast_najmlađeg_deteta'                                                                                               
names(procitanEksel)[25] <- 'Da_li_živi_sa_svojom_decom'                                                                                            
names(procitanEksel)[26] <- 'Da_li_živi_sa_licima_mlađim_od_18_godina_o_kojima_se_stara'                                                            
names(procitanEksel)[27] <- 'Glavni_uzrok_zavisnosti'                                                                                               
names(procitanEksel)[28] <- 'Glavni_uzrok_zavisnosti_-_navedite'                                                                                    
names(procitanEksel)[29] <- 'Uobičajen_način_korišćenja_-_glavni_uzrok_zavisnosti'                                                                  
names(procitanEksel)[30] <- 'Učestalost_korišćenja_u_poslednjih_30_dana_-_glavni_uzrok_zavisnosti'                                                  
names(procitanEksel)[31] <- 'Uzrast_na_početku_korišćenja_-_glavni_uzrok_zavisnosti'                                                                
names(procitanEksel)[32] <- 'Sporedni_uzrok_zavisnosti_1'                                                                                           
names(procitanEksel)[33] <- 'Sporedni_uzrok_zavisnosti_1_-_navedite'                                                                                
names(procitanEksel)[34] <- 'Sporedni_uzrok_zavisnosti_2'                                                                                           
names(procitanEksel)[35] <- 'Sporedni_uzrok_zavisnosti_2_-_navedite'                                                                                
names(procitanEksel)[36] <- 'Sporedni_uzrok_zavisnosti_3'                                                                                           
names(procitanEksel)[37] <- 'Sporedni_uzrok_zavisnosti_3_-_navedite'                                                                                
names(procitanEksel)[38] <- 'Da_li_je_lice_koristilo_više_vrsta_supstanci_istovremeno_u_poslednjih_30_dana'                                         
names(procitanEksel)[39] <- 'Koliko_meseci_(4_nedelje_zaredom)_lice_nije_koristilo_ni_jedno_od_navedenih_supstanci_sa_spiska_u_poslednjih_12_meseci'
names(procitanEksel)[40] <- 'Da_li_je_lice_uzimalo_psihoaktivne_supstance_injektiranjem'                                                            
names(procitanEksel)[41] <- 'Uzrast_prvog_uzimanja_psihoaktivne_supstance_injektiranjem'                                                            
names(procitanEksel)[42] <- 'Da_li_je_lice_za_injektiranje_psihoaktivne_supstance_delilo_igle_i_ili_špriceve_s_drugim_licima'                       
names(procitanEksel)[43] <- 'Testiranje_na_HIV'                                                                                                     
names(procitanEksel)[44] <- 'Rezultat_poslednjeg_testiranja_na_HIV'                                                                                 
names(procitanEksel)[45] <- 'Testiranje_na_Hepatits_C'                                                                                              
names(procitanEksel)[46] <- 'Rezultat_poslednjeg_testiranja_na_Hepatits_C'                                                                          
names(procitanEksel)[47] <- 'Testiranje_na_Hepatits_B'                                                                                              
names(procitanEksel)[48] <- 'Rezultat_poslednjeg_testiranja_na_Hepatitis_B'                                                                         
names(procitanEksel)[49] <- 'Datum_početka_ove_epizode_lečenja'                                                                                     
names(procitanEksel)[50] <- 'Da_li_se_lice_ranije_lečilo_od_bolesti_zavisnosti_povezane_sa_alkoholom'                                               
names(procitanEksel)[51] <- 'Godina_u_kojoj_je_započelo_prvo_lečenje_od_bolesti_zavisnosti_povezane_sa_alkoholom'                                   
names(procitanEksel)[52] <- 'Da_li_se_lice_ranije_lečilo_od_bolesti_zavisnosti_povezane_sa_psihoaktivnim_supstancama'                               
names(procitanEksel)[53] <- 'Godina_u_kojoj_je_započelo_prvo_lečenje_od_bolesti_zavisnosti_povezane_sa_psihoaktivnim_supstancama'                   
names(procitanEksel)[54] <- 'Da_li_se_lice_ranije_lečilo_od_od_bolesti_zavisnosti_povezane_sa_kockanjem'                                            
names(procitanEksel)[55] <- 'Godina_u_kojoj_je_započelo_prvo_lečenje_od_bolesti_zavisnosti_povezane_sa_kockanjem'                                   
names(procitanEksel)[56] <- 'Ko_je_imao_najveću_ulogu_u_upućivanju_lica_na_ovu_epizodu_lečenja'                                                     
names(procitanEksel)[57] <- 'Ko_je_imao_najveću_ulogu_u_upućivanju_lica_na_ovu_epizodu_lečenja_-_drugo'                                             
names(procitanEksel)[58] <- 'Tip_centra_programa_za_lečenje'                                                                                        
names(procitanEksel)[59] <- 'Tip_centra_programa_za_lečenje_-_drugo'                                                                                
names(procitanEksel)[60] <- 'Da_li_je_lice_ikada_bilo_na_supstitucionoj_terapiji_opioidima'                                                         
names(procitanEksel)[61] <- 'Godina_u_kojoj_je_započeta_prva_supstituciona_terapija_opioidima'                                                      
names(procitanEksel)[62] <- 'Da_li_je_lice_sada_na_supstitucionoj_terapiji_opiodima'                                                                
names(procitanEksel)[63] <- 'Godine_u_kojoj_je_započeta_sadašnja_supstituciona_terapija_opioidima'                                                  
names(procitanEksel)[64] <- 'Da_li_je_sadašnja_supstituciona_terapija_opiodima_propisana_u_ovom_centru'                                             
names(procitanEksel)[65] <- 'Lek_koji_se_koristi_u_sadašnjoj_supstitucionoj_terapiji_opoidima_propisanoj_u_ovom_centru'                             
names(procitanEksel)[66] <- 'Lek_koji_se_koristi_u_sadašnjoj_supstitucionoj_terapiji_opoidima_propisanoj_u_ovom_centru_-_drugo'

## Izbaci kao uzroke zavisnosti alkohol i kockanje ----
filterovano <- filter(procitanEksel, Glavni_uzrok_zavisnosti != "80 - Alkohol" &  Glavni_uzrok_zavisnosti != "91 - Kockanje")
## Ostavi samo jedinstvene maticne brojeve njihovo prvo pojavljivanje prema datumu prijave ----
orderovano <- filterovano[order(filterovano$Datum_dostavljanja_prijave),]
#orderovano
jedinstveno <- orderovano[!duplicated(orderovano$JMBG_EBS),]
#jedinstveno

# Napravi izlaz ----------------------------------------------------------
###Mapiranje za tabelu 8.1.1 iz .sjz.rs baze:
###
###treatment centres = Tip_centra_programa_za_lečenje
###Outpatient treatment centres = (1 - Ambulantno lečenje/dnevna bolnica)
###Inpatient treatment centres = (2 - Bolničko lečenje)
###Treatment units in prison = (3 - Lečenje u zatvoru)
###General practitioners = (4 - Izabrani lekar)
###Low threshold agencies = Uvek Nula
###Other¹ = (5 - Drugo)
###Not known / missing   = Uvek Nula
###Total = Zbir svega 
###
###----
###
###treatment status = Da_li_se_lice_ranije_lečilo_od_bolesti_zavisnosti_povezane_sa_psihoaktivnim_supstancama
###1. Never previously treated = (5 - Ne, nije se nikad ranije lečilo)
###2. Previously treated = (2 - Da, ranije se lečilo u istom centru, ali ne u poslednjih 6 meseci)+(4 - Da, ranije se lečilo u drugom centru, ali ne u poslednjih 6 meseci)
###3. Not known / Missing = (0 - Nepoznat podatak)
###4. All treatment entrants  (1+2+3) = Zbir svega iznad

## Sracunaj vrednosti za  TDI tabelu 8.1.1
a1 <- nrow(filter(jedinstveno, Tip_centra_programa_za_lečenje == "1 - Ambulantno lečenje/dnevna bolnica" & Da_li_se_lice_ranije_lečilo_od_bolesti_zavisnosti_povezane_sa_psihoaktivnim_supstancama == "5 - Ne, nije se nikad ranije lečilo"))
b1 <- nrow(filter(jedinstveno, Tip_centra_programa_za_lečenje == "1 - Ambulantno lečenje/dnevna bolnica" & (Da_li_se_lice_ranije_lečilo_od_bolesti_zavisnosti_povezane_sa_psihoaktivnim_supstancama == "2 - Da, ranije se lečilo u istom centru, ali ne u poslednjih 6 meseci" | Da_li_se_lice_ranije_lečilo_od_bolesti_zavisnosti_povezane_sa_psihoaktivnim_supstancama == "4 - Da, ranije se lečilo u drugom centru, ali ne u poslednjih 6 meseci")))
c1 <- nrow(filter(jedinstveno, Tip_centra_programa_za_lečenje == "1 - Ambulantno lečenje/dnevna bolnica" & Da_li_se_lice_ranije_lečilo_od_bolesti_zavisnosti_povezane_sa_psihoaktivnim_supstancama == "0 - Nepoznat podatak"))
d1 <- a1 + b1 + c1

a2 <- nrow(filter(jedinstveno, Tip_centra_programa_za_lečenje == "2 - Bolničko lečenje" & Da_li_se_lice_ranije_lečilo_od_bolesti_zavisnosti_povezane_sa_psihoaktivnim_supstancama == "5 - Ne, nije se nikad ranije lečilo"))
b2 <- nrow(filter(jedinstveno, Tip_centra_programa_za_lečenje == "2 - Bolničko lečenje" & (Da_li_se_lice_ranije_lečilo_od_bolesti_zavisnosti_povezane_sa_psihoaktivnim_supstancama == "2 - Da, ranije se lečilo u istom centru, ali ne u poslednjih 6 meseci" | Da_li_se_lice_ranije_lečilo_od_bolesti_zavisnosti_povezane_sa_psihoaktivnim_supstancama == "4 - Da, ranije se lečilo u drugom centru, ali ne u poslednjih 6 meseci")))
c2 <- nrow(filter(jedinstveno, Tip_centra_programa_za_lečenje == "2 - Bolničko lečenje" & Da_li_se_lice_ranije_lečilo_od_bolesti_zavisnosti_povezane_sa_psihoaktivnim_supstancama == "0 - Nepoznat podatak"))
d2 <- a2 + b2 + c2

a3 <- nrow(filter(jedinstveno, Tip_centra_programa_za_lečenje == "3 - Lečenje u zatvoru" & Da_li_se_lice_ranije_lečilo_od_bolesti_zavisnosti_povezane_sa_psihoaktivnim_supstancama == "5 - Ne, nije se nikad ranije lečilo"))
b3 <- nrow(filter(jedinstveno, Tip_centra_programa_za_lečenje == "3 - Lečenje u zatvoru" & (Da_li_se_lice_ranije_lečilo_od_bolesti_zavisnosti_povezane_sa_psihoaktivnim_supstancama == "2 - Da, ranije se lečilo u istom centru, ali ne u poslednjih 6 meseci" | Da_li_se_lice_ranije_lečilo_od_bolesti_zavisnosti_povezane_sa_psihoaktivnim_supstancama == "4 - Da, ranije se lečilo u drugom centru, ali ne u poslednjih 6 meseci")))
c3 <- nrow(filter(jedinstveno, Tip_centra_programa_za_lečenje == "3 - Lečenje u zatvoru" & Da_li_se_lice_ranije_lečilo_od_bolesti_zavisnosti_povezane_sa_psihoaktivnim_supstancama == "0 - Nepoznat podatak"))
d3 <- a3 + b3 + c3

a4 <- nrow(filter(jedinstveno, Tip_centra_programa_za_lečenje == "4 - Izabrani lekar" & Da_li_se_lice_ranije_lečilo_od_bolesti_zavisnosti_povezane_sa_psihoaktivnim_supstancama == "5 - Ne, nije se nikad ranije lečilo"))
b4 <- nrow(filter(jedinstveno, Tip_centra_programa_za_lečenje == "4 - Izabrani lekar" & (Da_li_se_lice_ranije_lečilo_od_bolesti_zavisnosti_povezane_sa_psihoaktivnim_supstancama == "2 - Da, ranije se lečilo u istom centru, ali ne u poslednjih 6 meseci" | Da_li_se_lice_ranije_lečilo_od_bolesti_zavisnosti_povezane_sa_psihoaktivnim_supstancama == "4 - Da, ranije se lečilo u drugom centru, ali ne u poslednjih 6 meseci")))
c4 <- nrow(filter(jedinstveno, Tip_centra_programa_za_lečenje == "4 - Izabrani lekar" & Da_li_se_lice_ranije_lečilo_od_bolesti_zavisnosti_povezane_sa_psihoaktivnim_supstancama == "0 - Nepoznat podatak"))
d4 <- a4 + b4 + c4

a5 <- 0 ## !Hardcode!
b5 <- 0 ## !Hardcode!
c5 <- 0 ## !Hardcode!
d5 <- a5 + b5 + c5

a6 <- nrow(filter(jedinstveno, Tip_centra_programa_za_lečenje == "5 - Drugo" & Da_li_se_lice_ranije_lečilo_od_bolesti_zavisnosti_povezane_sa_psihoaktivnim_supstancama == "5 - Ne, nije se nikad ranije lečilo"))
b6 <- nrow(filter(jedinstveno, Tip_centra_programa_za_lečenje == "5 - Drugo" & (Da_li_se_lice_ranije_lečilo_od_bolesti_zavisnosti_povezane_sa_psihoaktivnim_supstancama == "2 - Da, ranije se lečilo u istom centru, ali ne u poslednjih 6 meseci" | Da_li_se_lice_ranije_lečilo_od_bolesti_zavisnosti_povezane_sa_psihoaktivnim_supstancama == "4 - Da, ranije se lečilo u drugom centru, ali ne u poslednjih 6 meseci")))
c6 <- nrow(filter(jedinstveno, Tip_centra_programa_za_lečenje == "5 - Drugo" & Da_li_se_lice_ranije_lečilo_od_bolesti_zavisnosti_povezane_sa_psihoaktivnim_supstancama == "0 - Nepoznat podatak"))
d6 <- a6 + b6 + c6

a7 <- 0 ## !Hardcode!
b7 <- 0 ## !Hardcode!
c7 <- 0 ## !Hardcode!
d7 <- a7 + b7 + c7

a8 <- a1 + a2 + a3 + a4 + a5 + a6 + a7
b8 <- b1 + b2 + b3 + b4 + b5 + b6 + b7
c8 <- c1 + c2 + c3 + c4 + c5 + c6 + c7
d8 <- d1 + d2 + d3 + d4 + d5 + d6 + d7

## Kreiraj TDI tabelu 8.1.1
tabela_8.1.1 <- data.frame(
  rowName = c ("", "1. Never previously treated","2. Previously treated","3. Not known / Missing","4. All treatment entrants  (1+2+3) "), 
  outpatientTreatmentCentres = c("Outpatient treatment centres", a1 , b1, c1, d1),
  inpatientTreatmentCentres = c("Inpatient treatment centres", a2, b2, c2, d2),
  treatmentUnitsInPrison = c("Treatment units in prison", a3, b3, c3, d3),
  generalPractitioners = c("General practitioners", a4, b4, c4, d4),
  lowThresholdAgencies = c("Low threshold agencie", a5, b5, c5, d5),
  other = c("Other¹", a6, b6, c6, d6),
  notKnownMissing = c("Not known / missing", a7, b7, c7, d7),
  total = c("Total", a8, b8, c8, d8)
)
print(tabela_8.1.1) 

# Sacuvaj izlazni fajl ----------------------------------------------------
write.xlsx(tabela_8.1.1,'data/izlazniPodatci.xlsx',colNames = FALSE)
