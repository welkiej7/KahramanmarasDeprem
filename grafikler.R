library(tidyverse)
library(rayshader)
library(sf)
library(tigris)
library(UsingR)


hasar.onbiril%>%filter(İl == "Diyarbakır")%>%
  group_by(Durum)%>%
  count(Mahalle)%>%
  ggplot(mapping = aes(x = Mahalle, y = n, fill = Durum)) + 
  geom_col() +
  scale_fill_brewer(palette = "BrBG") + 
  scale_x_discrete(guide = guide_axis(n.dodge = 4)) +theme_minimal() +
  ylab(label = "Bina Sayısı")





hasar.onbiril.graph.object <- hasar.onbiril%>%group_by(İl)%>%count(Durum)%>%arrange(Durum)%>%
  ggplot(aes(x = İl, y = Durum, color = n)) + 
  geom_point() + scale_fill_brewer(palette = "BrBG") + 
  scale_color_viridis_c(option = "C")+
  scale_x_discrete(guide = guide_axis(n.dodge = 4)) +ggtitle(label = "Kahramanmaraş Pazarcık Depremi Güncel Bina İstatistikleri") + 
  theme(text = element_text(size = 20))  +theme_minimal()+ theme(text = element_text(color = "#22211d"),
                                                                 
                                                                 legend.text = element_text(size=6, color="black"),
                                                                 legend.title = element_text(size=8, color="white"),
                                                                 panel.grid.major = element_line(color = "grey80", size = 0.2),
                                                                 panel.grid.minor = element_blank(),
                                                                 
                                                                 plot.caption = element_text(size=6, color="white", hjust=.15, vjust=20),
                                                                 
                                                                 plot.background = element_rect(fill = "grey80", color = NA), 
                                                                 panel.background = element_rect(fill = "grey80", color = NA), 
                                                                 legend.background = element_rect(fill = "grey80", color = NA),
                                                                 panel.border = element_blank())





demo.rayshader <- hasar.onbiril.graph.object%>%
  rayshader::plot_gg(width = 8, height = 8, 
                     scale = 700, raytrace = TRUE, multicore = TRUE)

rayshader::render_camera(zoom = 1)
rayshader::render_highquality(demo.rayshader, height = 2560, width = 1600,
                              parallel = TRUE,
                              text_size = 16,
                              lightintensity = 700,
                              smooth_line = TRUE)
rayshader::render_snapshot("~/Desktop/demo2",width = 2560, height = 1600,
                           software_render = FALSE)




##Hatay 20022023
hatay.grouped.by.ilce%>%ggplot(mapping = aes(x = İlçe, y = n, fill = Durum)) + geom_col() + 
  ylab(label = "Bina Sayısı") + scale_fill_brewer(palette = "Reds") + theme_minimal() + theme(text = element_text(color = "#22211d"),
                                                                                              
                                                                                              legend.text = element_text(size=6, color="black"),
                                                                                              legend.title = element_text(size=8, color="white"),
                                                                                              panel.grid.major = element_line(color = "grey80", size = 0.2),
                                                                                              panel.grid.minor = element_blank(),
                                                                                              
                                                                                              plot.caption = element_text(size=6, color="white", hjust=.15, vjust=20),
                                                                                              
                                                                                              plot.background = element_rect(fill = "grey80", color = NA), 
                                                                                              panel.background = element_rect(fill = "grey80", color = NA), 
                                                                                              legend.background = element_rect(fill = "grey80", color = NA),
                                                                                              panel.border = element_blank())







##Hatay Estimation vs Real
hatay.combined%>%filter(Durum %in% c("Acil Yıkrıtılacak","Az Hasarlı","Ağır Hasarlı",
                                      "Bina Kilitli İnceleme Yapılamadı (Girilemedi)",
                                    "Hasarsız","Tespit Yapılamadı","Yıkık"))%>%ggplot(aes(x = İlçe, y = value, fill = Durum)) + geom_col() +
  ylab(label = "Bina Sayısı") + scale_fill_brewer(palette = "Reds") + theme_minimal() + theme(text = element_text(color = "#22211d"),
                                                                                              
                                                                                              legend.text = element_text(size=6, color="black"),
                                                                                              legend.title = element_text(size=8, color="white"),
                                                                                              panel.grid.major = element_line(color = "grey80", size = 0.2),
                                                                                              panel.grid.minor = element_blank(),
                                                                                              
                                                                                              plot.caption = element_text(size=6, color="white", hjust=.15, vjust=20),
                                                                                              
                                                                                              plot.background = element_rect(fill = "grey80", color = NA), 
                                                                                              panel.background = element_rect(fill = "grey80", color = NA), 
                                                                                              legend.background = element_rect(fill = "grey80", color = NA),
                                                                                              panel.border = element_blank()) + ggtitle("Hatay İlinin Hasar Dağılımı")



hatay.combined%>%filter(Durum %in% c("Az Hasarlı Est","Ağır Hasarlı Est","Yıkık Est"))%>%ggplot(aes(x = İlçe, y = value, fill = Durum)) + geom_col() +
  ylab(label = "Bina Sayısı") + scale_fill_brewer(palette = "Reds") + theme_minimal() + theme(text = element_text(color = "#22211d"),
                                                                                              
                                                                                              legend.text = element_text(size=14, color="black"),
                                                                                              legend.title = element_text(size=14, color="white"),
                                                                                              panel.grid.major = element_line(color = "grey80", size = 0.2),
                                                                                              panel.grid.minor = element_blank(),
                                                                                              
                                                                                              plot.caption = element_text(size=30, color="white", hjust=.15, vjust=20),
                                                                                              
                                                                                              plot.background = element_rect(fill = "grey80", color = NA), 
                                                                                              panel.background = element_rect(fill = "grey80", color = NA), 
                                                                                              legend.background = element_rect(fill = "grey80", color = NA),
                                                                                              panel.border = element_blank()) + ggtitle("Hatay İlinin Tahmini Hasar Dağılımı")




par(mfrow = c(2,2))
a <- hatay.combined%>%filter(Durum %in% c("Acil Yıkrıtılacak","Az Hasarlı","Ağır Hasarlı",
                                     "Bina Kilitli İnceleme Yapılamadı (Girilemedi)",
                                     "Hasarsız","Tespit Yapılamadı","Yıkık"))%>%ggplot(aes(x = İlçe, y = value, fill = Durum)) + geom_col() +
  ylab(label = "Bina Sayısı") + scale_fill_brewer(palette = "Reds")

b <- hatay.combined%>%filter(Durum %in% c("Az Hasarlı Est","Ağır Hasarlı Est","Yıkık Est"))%>%ggplot(aes(x = İlçe, y = value, fill = Durum)) + geom_col() +
  ylab(label = "Bina Sayısı") + scale_fill_brewer(palette = "Reds")
print(a, position = c(0, 0, 0.5, 1), more = TRUE)
print(b, position = c(0.5, 0, 1, 1))










