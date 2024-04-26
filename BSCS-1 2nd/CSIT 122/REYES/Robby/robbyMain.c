#include "robby.h"

int main() {
	int x, y;
	char input;
	
	initialize(&x, &y);
	
	while (input != 'd') {
		input = printCommand();
		
		switch (input) {
			case 'a':
				initialize(&x, &y);
				break;
			case 'b':
				printLocation(x, y);
				break;
			case 'c':
				move(&x, &y);
				break;
			case 'd':
				Exit();
				break;
		}
	}
	
	return 0;
}

// HI!!!
