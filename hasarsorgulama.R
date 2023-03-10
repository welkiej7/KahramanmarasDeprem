
##Muhtemel hatalar
# Java hatası, eğer işlemi yapan makinede java yüklü olmak zorunda. https://www.java.com/en/download/ 'dan yüklenebilir.
# Firefox hatası, makine içerisinde firefox olmak zorunda.
#Selenium hatası: eğer hata id içeriklerinin uyuşmaması ise terminalde "killall -9 java" komutunu çalıştırın.  Daha sonrasında script i tekrar çalıştırın.
#subscript out of bounds hatası: İnternet hızı yüzünden veri yeterince hızlı indirelemediği için listelerin boyutları uyuşmamakta, sys.sleep seçeneklerini 
#artırarak düzeltilebilir. 


message("For Doğruluk Payı®
          by Onur Tuncay Bal, Simge Akkaş
          for contact:
          https://www.linkedin.com/in/onur-tuncay-bal-400955176/
          https://www.linkedin.com/in/simge-akkaş-737345203/")
message("Gerekli Kütüphaneler Yükleniyor")



require(tidyverse)
library(RSelenium)
require(netstat)
library(rvest)

message("Done!")

message("Firefox Sanal Uzantısı Başlatılıyor")









rs.driver.object <- rsDriver(browser = "firefox",
                             verbose = TRUE,
                             port = free_port())


rs.client<- rs.driver.object$client
message("Client Ayrıldı, Yönlendiriliyor")
rs.client$navigate("https://hasartespit.csb.gov.tr")


message("Hasar Tespit Veri Tabanına Bağlanıldı, Elementler Ayrıştırılıyor.")
search_city <- rs.client$findElement(using = "id",'IlId')
search_ilce <- rs.client$findElement(using = "id", 
                                     'IlceId')
search_mahalle <- rs.client$findElement(using = "id","MahalleId")
sorgula.buttons <- rs.client$findElements(using = 'class', value = "btn")
sorgula.button<- sorgula.buttons[[2]]


search_city$sendKeysToElement(list("Kahramanmaraş", key = 'enter'))

search_ilce <- rs.client$findElement(using = "id", 
                                     'IlceId')
search_ilce$sendKeysToElement(list("Afşin", key = 'enter'))

#Search Mahalle
search_mahalle <- rs.client$findElement(using = "id","MahalleId")
search_mahalle$sendKeysToElement(list('Afşinbey', key = 'enter'))

#Inspect the button element
sorgula.buttons <- rs.client$findElements(using = 'class', value = "btn")
sorgula.button<- sorgula.buttons[[2]]

#click on button
sorgula.button$clickElement()


qresult<- rs.client$findElements(using = "name", value = "QueryResult_length")
qresult.options <- qresult[[1]]$findChildElements(using = "xpath","option")
qresult.options[[5]]$clickElement()


#get the html table
table <- rs.client$findElement(using = 'id', value = 'QueryResult')
source <- table$getPageSource()
source.unlist <- source%>%unlist()
page <- read_html(source.unlist)
html_table(page)[1] -> main.frame
main.frame <- main.frame[[1]]





options.city <- search_city$findChildElements(using = "xpath","option")
##Sys.sleep içerisindeki rakamları düşürerek hızı artırabilirsiniz, fakat firefox ve sitenin tepki süresine göre hata alınabilir. 

for (city in 1:length(options.city)) {
  temp.options.city <- options.city[[city]]
  temp.options.city$clickElement()
  options.ilce <- search_ilce$findChildElements(using = "xpath","option")
  Sys.sleep(2)
  for (ilce in 5:length(options.ilce)) {
    temp.options.ilce <- options.ilce[[ilce]]
    temp.options.ilce$clickElement()
    options.mahalle <- search_mahalle$findChildElements(using = "xpath","option")
    Sys.sleep(2)
    for (mahalle in 2:length(options.mahalle)) {
      temp.options.mahalle <- options.mahalle[[mahalle]]
      temp.options.mahalle$clickElement()
      sorgula.button$clickElement()
      Sys.sleep(1)
      #select all
      qresult<- rs.client$findElements(using = "name", value = "QueryResult_length")
      qresult.options <- qresult[[1]]$findChildElements(using = "xpath","option")
      qresult.options[[5]]$clickElement()
      #get query
      table <- rs.client$findElement(using = 'id', value = 'QueryResult')
      source <- table$getPageSource()
      source.unlist <- source%>%unlist()
      page <- read_html(source.unlist)
      html_table(page)[1] -> temp.frame
      rbind(temp.frame[[1]],main.frame) -> main.frame
      write.csv(main.frame, "~/main.frame.csv")
      
    }
  }
}

##Tekrar eden satırlar var, yapı kimlik no kolonunu NA ve NON- Na olarak ayırıp, distinct fonksiyonu ile tekrar eden satırları silip tekrar birleştirebilirsiniz. 


