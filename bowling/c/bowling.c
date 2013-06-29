#include <stdio.h>
#include <stdlib.h>

int score_roll(char *roll)
{
	switch (*roll) {
	case 'X':
		return 10;
	case '/':
		return 10 - score_roll(roll - 1);
	case '1': case '2': case '3': case '4': case '5':
	case '6': case '7': case '8': case '9':
		return *roll - '0';
	case '-': default:
		return 0;
	}
}

int score_game(char *game)
{
	char *c = game;
	int frame = 0, score = 0;

	while (frame < 10) {
		if (*c == 'X') {
			score += 10 + score_roll(c + 1) + score_roll(c + 2);
			c++;
		} else if (*(c + 1) == '/') {
			score += 10 + score_roll(c + 2);
			c += 2;
		} else {
			score += score_roll(c) + score_roll(c + 1);
			c += 2;
		}
		frame++;
	}
	return score;
}

int main(int argc, char *argv[])
{
	if (argc != 2) {
		fprintf(stderr, "usage: %s game\n", argv[0]);
		exit(EXIT_FAILURE);
	}
	printf("%d\n", score_game(argv[1]));
	return EXIT_SUCCESS;
}
