
main:
	cd exercises; make
	./prepend.py
	cp -rf exercises/images exercises_sequenced/.

clean:
	rm -f exercises/*-assignment.Rmd
	rm -f exercises/*-solution.Rmd
	rm -f exercises_sequenced/*-assignment.Rmd
