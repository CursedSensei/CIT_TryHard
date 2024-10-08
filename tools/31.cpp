#include "song.h"

struct node {
	Song* song;
	node* prev;
	node* next;
};