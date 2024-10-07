import java.util.ArrayList;
import java.util.Scanner;
import java.util.Comparator;
import java.util.Collections;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter number of points: ");
        int size = sc.nextInt();
        ArrayList<Point> points = new ArrayList<>();
        for (int i = 0; i < size; i++) {
            System.out.print("Enter point " + (i+1) + " : ");
            points.add(new Point(sc.nextInt(), sc.nextInt()));
        }

        System.out.println("USING COMPARABLE");
        Collections.sort(points);
        for (Point p : points) {
            System.out.println(p);
        }
        while (true) {
            System.out.print("Enter target: ");
            int x = sc.nextInt();
            if (x < -9 || x > 9) {
                break;
            }
            int y = sc.nextInt();
            if (y < -9 || y > 9) {
                break;
            }
            Point target = new Point(x, y);
            print(points, target);
        }
    }

    static void print(ArrayList<Point> points, Point target) {
        System.out.println("Sorted nearest to " + target);
        points.sort(new Point.Nearest(target));
        for (Point p : points) {
            System.out.println(p);
        }
        Collections.sort(points);
        int index = 0;
        for (int j = 9; j >= -9; j--) {
            for (int i = -9; i <= 9; i++) {
                if (target.x == i && target.y == j) {
                    if (index < points.size() && points.get(index).x == i && points.get(index).y == j) {
                        System.out.print("|1o");
                        index++;
                    } else {
                        System.out.print("| o");
                    }
                } else if (index < points.size() && points.get(index).x == i && points.get(index).y == j) {
                    Point p = points.get(index);
                    points.sort(new Point.Nearest(target));
                    int ind = points.indexOf(p)+1;
                    if (ind < 10) {
                        System.out.print("| " + ind);
                    } else {
                        System.out.print("|" + ind);
                    }
                    Collections.sort(points);
                    index++;
                } else {
                    System.out.print("|  ");
                }
            }
            System.out.println();
        }
    }
}