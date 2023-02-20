hasar <- readr::read_csv(file.choose())
require(tidyverse)


readr::read_csv("/Users/onurtuncaybal/Documents/Code/Doğruluk Payı/Data/hasar.csv") -> hasar

hasar%>%mutate(Durum = case_when(Durum == "Acil YÄ±ktÄ±rÄ±lacak" ~ 
                                  "Acil Yıktırılacak",
                                 Durum == "Az HasarlÄ±"~
                                   "Az Hasarlı",
                                 Durum == "AÄŸÄ±r HasarlÄ±"~
                                   "Ağır Hasarlı",
                                 Durum == "Bina Kilitli Ä°nceleme YapÄ±lamadÄ± (Girilemedi)"~
                                   "Bina Kilitli İnceleme Yapılamadı (Girilemedi)",
                                 Durum == "DeÄŸerlendirme DÄ±ÅŸÄ±"~
                                   "Değerlendirme Dışı",
                                 Durum == "HasarsÄ±z" ~
                                   "Hasarsız",
                                 Durum == "Tespit YapÄ±lamadÄ±"~
                                   "Tespit Yapılamadı",
                                 Durum == "YÄ±kÄ±k" ~
                                   "Yıkık",
                                 .default = Durum)) -> hasar.fin

write.csv(hasar.fin, "~/hasar.fin.csv")


hasar <- hasar.fin



hasar.onbiril <- hasar%>%filter(İl %in% c("Adana","Adıyaman",
                                         "Diyarbakır","Elazığ",
                                         "Gaziantep","Hatay",
                                         "Kahramanmaraş",
                                         "Kilis","Malatya",
                                         "Osmaniye","Şanlıurfa"))



hasar.onbiril.durum <- hasar.onbiril%>%group_by(Durum)%>%count(İl)



##Sadece Kilitli Bina Olan Sokaklar
View(hasar.onbiril%>%
       filter(Durum == "Bina Kilitli İnceleme Yapılamadı (Girilemedi)")%>%
       group_by(Sokak)%>%count(İl))




##Durum Factor

hasar.onbiril$Durum <- factor(hasar.onbiril$Durum, levels = c("Değerlendirme Dışı",
                                                              "Tespit Yapılamadı",
                                                              "Hasarsız",
                                                              "Az Hasarlı",
                                                              "Girilemedi",
                                                              "Ağır Hasarlı",
                                                              "Acil Yıktırılacak",
                                                              "Yıkık"))

