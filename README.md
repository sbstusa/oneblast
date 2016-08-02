---
title:Analysis of the oneBlast eNewsletter experiment
---

# Setup
You should create a directory called 'data' in the working directory.

You can create the data files in that directory by downloading the raw data files from the secure file storage location.and then doing: `Rscript -e "library(knitr);knit('datasetup.Rmd')"` at the command line. If you want an .html file or a .pdf file that you can view easily, it is easier to use the "Knit to HTML" or "Knit to PDF" or "Compile PDF" button in RStudio. Alternatively, you can do `Rscript -e "library(rmarkdown);render('datasetup.Rmd')` to make an html file.

The outcome (subscription) arises from finding subscribers in the subscriptions.csv file who match members of the experimental pool in the designdata.csv file. The file `createoutcomes.Rmd` does this merging. In the end, roughly 1000 subscribers are not matchable with the experimental pool. We do not know whether these people were not a part of the experiment at all or whether they received emails as a part of the study but then subscribed using different names *and* different email addresses. We address this problem in the analysis.

# Files

The source code is in R markdown format. To recreate our analysis (shown here in 
[HTML Version](http://htmlpreview.github.io/?https://github.com/sbstusa/oneblast/blob/master/oneblast_analysis.html)
) you would either use the `Knit to HTML` button in RStudio or, after installing the rmarkdown package, do `library(rmarkdown);render("oneblast_analysis.Rmd")`.



# Process

We wrote up a plan for analysis using Google Docs to enable easy commenting and group editing. Once we had a more or less final version, we downloaded it as .docx format and then converted this to github flavored markdown so that it could be posted publically online: `pandoc -f docx -t markdown_github AnalysisPlan.docx -o AnalysisPlan.md`.

 




