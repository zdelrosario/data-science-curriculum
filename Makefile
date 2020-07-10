
main:
	cd exercises; make
	./prepend.py
	cp -rf exercises/images exercises_sequenced/.

challenges:
	cd ../data-science-challenges/challenges; make
	cp -f ../data-science-challenges/challenges/*-assignment.Rmd challenges/.
	cp -rf ../data-science-challenges/challenges/images challenges/.
	cp -rf ../data-science-challenges/challenges/data challenges/.

clean:
	rm exercises/*-assignment.Rmd
	rm exercises/*-solution.Rmd
	rm exercises_sequenced/*-assignment.Rmd

.PHONY: clean challenges
