all: bowling test

bowling: bowling.c
	gcc -Wall -Werror -Wextra bowling.c -o bowling

test: bowling
	./bowling_tests.sh

clean:
	rm -f bowling
