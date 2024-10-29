import java.io.*;
import java.util.Scanner;
import java.util.ArrayList;

public class Main {
    public static void main(String[] args) throws IOException {
        Scanner sc = new Scanner(System.in);
        
        System.out.print("Enter the number of names: ");
        
        int num = sc.nextInt();
        sc.nextLine();
        ArrayList<String> names = new ArrayList<>();
        
        for (int i = 0; i < num; i++) {
            System.out.print("Enter name " + (i + 1) + ": ");
            names.add(sc.nextLine());
        }
        
        FileWriter fp = new FileWriter("names.txt");
        
        while (!names.isEmpty()) {
            fp.write(names.get(0) + "\n");
            names.remove(0);
        }
        
        fp.close();
        
        System.out.println("Names written to file successfully!");
    }
}