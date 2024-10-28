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
        
        FileWriter fp = new FileWriter("people.txt");
        
        for (int i = 0; i < num; i++) {
            Boolean isDup = false;
            for (int j = 0; j < i; j++) {
                if (names.get(i).equals(names.get(j))) {
                    isDup = true;
                    break;
                }
            }
            
            if (!isDup) fp.write(names.get(i) + "\n");
        }
        
        fp.close();
    }
}