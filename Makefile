
main:
	cd exercises; make
	./prepend.py
	cp -rf exercises/images exercises_sequenced/.

test:
	Rscript -e 'testthat::test_dir("./tests/")'

challenges:
	cd ../data-science-challenges/challenges; make
	cp -f ../data-science-challenges/challenges/*-assignment.Rmd challenges/.
	cp -rf ../data-science-challenges/challenges/images challenges/.
	cp -rf ../data-science-challenges/challenges/data challenges/.

clean:
	rm -f exercises/*-assignment.Rmd
	rm -f exercises/*-solution.Rmd
	rm -f exercises_sequenced/*-assignment.Rmd

.PHONY: clean challenges
