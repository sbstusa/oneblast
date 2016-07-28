---
title:Analysis of the oneBlast eNewsletter experiment
---

# Setup
You should create a directory called 'data' in the working directory.

You can create the data files in that directory by downloading the raw data files from the secure file storage location.and then doing: `Rscript -e "library(knitr);knit('datasetup.Rmd')"` at the command line.

# Files

The source code is in R markdown format. To recreate our analysis (shown here in 
[HTML Version](http://htmlpreview.github.io/?https://github.com/sbstusa/oneblast/blob/master/oneblast_analysis.html)
) you would either use the `Knit to HTML` button in RStudio or, after installing the rmarkdown package, do `library(rmarkdown);render("oneblast_analysis.Rmd")`.



# Process

We wrote up a plan for analysis using Google Docs to enable easy commenting and group editing. Once we had a more or less final version, we downloaded it as .docx format and then converted this to github flavored markdown so that it could be posted publically online: `pandoc -f docx -t markdown_github AnalysisPlan.docx -o AnalysisPlan.md`.

 




