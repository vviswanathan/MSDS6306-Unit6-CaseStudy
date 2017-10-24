all: report.html

clean:
	rm -f CaseStudy1.tsv report.html

CaseStudy1.tsv: ./Source/CaseStudy1.R
	Rscript $<

#CaseStudy1.png: CaseStudy1.tsv
#	Rscript -e 'library(ggplot2); qplot(words_length, Freq, data=read.delim("$<")); ggsave("$@")'
#	rm Rplots.pdf

report.html: ./Paper/CaseStudy1.Rmd CaseStudy1.tsv
	Rscript -e 'rmarkdown::render("$<")'