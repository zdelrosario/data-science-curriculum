SRC := $(wildcard *master.Rmd)
ASSIGNMENTS := $(subst master,assignment,$(SRC))
SOLUTIONS := $(subst master,solution,$(SRC))
# ${RSTUDIO_PASS} # Set in environment variables

all: ${ASSIGNMENTS} ${SOLUTIONS}

%assignment.Rmd: %master.Rmd
	sed -E \
	-e '/<!-- solution-begin -->/,/<!-- solution-end -->/d' \
	-e '/# solution-begin/,/# solution-end/d' \
	-e '/# task-(begin|end)/d' \
	-e '/<!-- task-(begin|end)/d' \
	-e '/<!-- include-exit-ticket -->/ r exit-ticket.md' \
	< $< > $@
	# Replace e-code-target
	perl -epi "s/e-code-target/$@/g" $@

%solution.Rmd: %master.Rmd
	sed -E \
	-e '/<!-- task-begin -->/,/<!-- task-end -->/d' \
	-e '/# task-begin/,/# task-end/d' \
	-e '/# solution-(begin|end)/d' \
	-e '/<!-- solution-(begin|end)/d' \
	< $< > $@

start:
	./run-rstudio

stop:
	docker stop rstudio

setup:
	docker pull rocker/geospatial
	mkdir data

unset:
	docker rm rstudio

clean:
	rm -f *assignment.Rmd *solution.Rmd
