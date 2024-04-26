#include <Windows.h>

void gotoxy(int x, int y) {
	HANDLE console = GetStdHandle(STD_OUTPUT_HANDLE);
	COORD cursor;
	cursor.X = x;
	cursor.Y = y;

	SetConsoleCursorPosition(console, cursor);
}
