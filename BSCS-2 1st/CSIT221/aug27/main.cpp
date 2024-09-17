#include <iostream>
#include "point.h"

using namespace std;

int main(int argc, char **argv) {
	
	Point point1 = {2, 2}, point2 = {11, 5};
	
	Point out = point1.midpoint(point2);
	
	cout << "(" << out.x << ", " << out.y << ")" << endl;
	
	return 0;
}
