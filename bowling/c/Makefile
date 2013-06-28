all: bowling test

bowling: bowling.c
	gcc bowling.c -o bowling

test: bowling
	./bowling_tests.sh

clean:
	rm -f bowling
