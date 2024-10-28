import java.io.*;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) throws IOException {
        FileWriter dataFile = new FileWriter("data.txt");
        dataFile.write("5\n3\n2\n");
        dataFile.close();
        
        FileReader nc = new FileReader("data.txt");
        Scanner sc = new Scanner(nc);
        
        int first = Integer.parseInt(sc.nextLine());
        int second = Integer.parseInt(sc.nextLine());
        int third = Integer.parseInt(sc.nextLine());
        
        nc.close();
        
        dataFile = new FileWriter("data.txt", true);
        dataFile.write(String.format("\n%d\n%d\n%d\n", first * first, second * second, third * third));
        dataFile.close();
    }
}