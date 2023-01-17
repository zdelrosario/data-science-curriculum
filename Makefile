
main:
	cd exercises; make
	./prepend.py
	cp -rf exercises/images exercises_sequenced/.
	cp -rf exercises/images book/.
	cp -rf exercises/data/tiny.csv exercises_sequenced/data/.
	cp -rf exercises/data/tiny.csv book/data/.
	cp -rf exercises/data/beef_price.csv book/data/.
	cp -rf exercises/data/beef_production.csv book/data/.

book: main
	cd book; Rscript -e 'bookdown::render_book("index.Rmd")'

test:
	Rscript -e 'testthat::test_dir("./tests/")'

lock:
	rm renv.lock
	Rscript -e "renv::snapshot(type='explicit')"

challenges:
	cd ../data-science-challenges/challenges; make
	cp -f ../data-science-challenges/challenges/*-assignment.Rmd challenges/.
	cp -rf ../data-science-challenges/challenges/images challenges/.
	cp -rf ../data-science-challenges/challenges/data challenges/.

clean:
	rm -f exercises/*-assignment.Rmd
	rm -f exercises/*-solution.Rmd
	rm -f exercises_sequenced/*-assignment.Rmd
	rm -f book/*-solution.Rmd
	rm -fr book/_book
	rm -fr book/_book_files
	rm -f book/_main.*

.PHONY: clean challenges
