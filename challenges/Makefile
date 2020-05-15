SRC := $(wildcard *master.Rmd)
ASSIGNMENTS := $(subst master,assignment,$(SRC))
SOLUTIONS := $(subst master,solution,$(SRC))

all: ${ASSIGNMENTS} ${SOLUTIONS}

%assignment.Rmd: %master.Rmd
	sed -E \
	-e '/<!-- solution-begin -->/,/<!-- solution-end -->/d' \
	-e '/# solution-begin/,/# solution-end/d' \
	-e '/# task-(begin|end)/d' \
	-e '/<!-- task-(begin|end)/d' \
	< $< > $@

%solution.Rmd: %master.Rmd
	sed -E \
	-e '/<!-- task-begin -->/,/<!-- task-end -->/d' \
	-e '/# task-begin/,/# task-end/d' \
	-e '/# solution-(begin|end)/d' \
	-e '/<!-- solution-(begin|end)/d' \
	< $< > $@

clean:
	rm -f *assignment.Rmd *solution.Rmd
