
main:
	cd exercises; make
	./prepend.py
	cp -rf exercises/images exercises_sequenced/.

challenges:
	cd ../data-science-challenges/challenges; make
	cp ../data-science-challenges/challenges/*-assignment.Rmd challenges/.

clean:
	rm -f exercises/*-assignment.Rmd
	rm -f exercises/*-solution.Rmd
	rm -f exercises_sequenced/*-assignment.Rmd

.PHONY: clean challenges
