all: report.html

clean: rm -f CaseStudy1.tsv report.html ./Data/Rplots.pdf

CaseStudy1.tsv: ./Source/CaseStudy1.R
	Rscript $<

report.html: ./Paper/CaseStudy1.Rmd CaseStudy1.tsv
	Rscript -e 'rmarkdown::render("$<")'
