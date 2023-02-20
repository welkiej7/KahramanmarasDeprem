# Kahramanmaraş Earhquake Data Analysis

The main aim of this repository is to provide fundamental tools for web scraping from government sites related to the Kahramanmaraş Earthquake. In addition to scraping scripts, I have used Rayshader for advanced visualization of the data. Scraping scripts are given in hasarsorgulama.R and biruni.R files. The vital idea behind the scripts is the web browser automation with the RSelenium package.  


In the hasarsorgulama.R script we let Firefox connect to the https://hasartespit.csb.gov.tr. First, we assign html elements and interactive buttons to some values.  After assigning these values, we create a mainframe from the HTML table that https://hasartespit.csb.gov.tr gave us.  After that, we start to iterate and add different districts in a loop. Since the site is rather fragile, saving it in each loop is better. 

Similar to hasarsorgulama.R script, in biruni.R script we automated the downloading process. In each iteration, we select a value from the list. Since it is an overflow hidden HTML list, we have to define the navigator element in each “for” loop. 


In data.analysis.R, I made the necessary data wrangling. Here is to create a solid and clear frame and compare it to the different academic works about the earthquake.


Finally, we use ggplot and Rayshader to create the following graphs. The necessary script can be found in grafikler.R. 



![0dd472e5-12a1-48dd-9381-cf02267bd50c](https://user-images.githubusercontent.com/94485797/220098537-cce476f9-ae08-4c3b-83c7-9e6091b491c3.jpg)


![2b21ea13-baed-4329-8191-210687f12fc3](https://user-images.githubusercontent.com/94485797/220098552-e7187258-e330-46dc-86d6-50c5deeb4e9e.jpg)


![b5f782b1-f0e5-4cb4-9add-842754f6ea3b](https://user-images.githubusercontent.com/94485797/220098556-1132e8f0-e5b6-4c6d-a2ae-b0f6796706cb.jpg)



