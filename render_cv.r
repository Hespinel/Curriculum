# This script builds both the HTML and PDF versions of your CV

# If you wanted to speed up rendering for googlesheets driven CVs you could use
# this script to cache a version of the CV_Printer class with data already
# loaded and load the cached version in the .Rmd instead of re-fetching it twice
# for the HTML and PDF rendering. This exercise is left to the reader.


# run ?datadrivencv::use_datadriven_cv to see more details
#install.packages("datadrivencv")

#install.packages("devtools")
#devtools::install_github("nstrayer/datadrivencv")

#install.packages("remotes")
#remotes::install_github('mitchelloharawild/icons@v0.1.0')


library(datadrivencv)

datadrivencv::use_datadriven_cv(
  full_name = "Hellen Espinel",
  data_location = "https://docs.google.com/spreadsheets/d/14MQICF2F8-vf8CKPF1m4lyGKO6_thG-4aSwat1e2TWc",
  pdf_location = "/cloud/project/Curriculum/hellen_espinel.pdf",
)

# Knit the HTML version
rmarkdown::render("cv.rmd",
                  params = list(pdf_mode = F),
                  output_file = "kate_dibiasky_datadrivencv.html")

# Knit the PDF version to temporary html location
tmp_html_cv_loc <- fs::file_temp(ext = ".html")
rmarkdown::render("cv.rmd",
                  params = list(pdf_mode = T),
                  output_file = tmp_html_cv_loc)

# Convert to PDF using Pagedown
pagedown::chrome_print(input = tmp_html_cv_loc,
                       output = "kate_dibiasky_datadrivencv.pdf")
