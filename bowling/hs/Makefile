all: bowling test

bowling: bowling.hs
	ghc -Wall -Werror bowling.hs -o bowling

test: bowling
	./bowling

clean:
	rm -f bowling bowling.hi bowling.o
