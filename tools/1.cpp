import java.util.Comparator;

public class Point implements Comparable<Point> {
    public int x;
    public int y;
    
    public Point(int xx, int yy) {
        x = xx;
        y = yy;
    }
    
    @Override
    public String toString() {
        return "(" + x + ", " + y + ")";
    }
    
    @Override
    public int compareTo(Point point) {
        if (y > point.y) return -1;
        else if (y < point.y) return 1;
        
        if (x < point.x) return -1;
        else if (x > point.x) return 1;
        
        return 0;
    }
    
    static public class Nearest implements Comparator<Point> {
        Point point;
        
        public Nearest(Point point) {
            this.point = point;
        }
        
        @Override
        public int compare(Point point1, Point point2) {
            
            double dist1 = Math.sqrt((point.x - point1.x) * (point.x - point1.x) + (point.y - point1.y) * (point.y - point1.y));
            double dist2 = Math.sqrt((point.x - point2.x) * (point.x - point2.x) + (point.y - point2.y) * (point.y - point2.y));
            
            if (dist1 > dist2) return 1;
            else if (dist1 < dist2) return -1;
            
            return 0;
        }
    }
}