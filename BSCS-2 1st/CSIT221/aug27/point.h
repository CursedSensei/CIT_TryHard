struct Point {
	float x;
	float y;
	
	Point midpoint(Point in) {
		Point out;
	
		out.x = (x + in.x) / 2.0;
		out.y = (y + in.y) / 2.0;
		
		return out;
	}
};
