import java.io.*;
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        // Sample file names
        String file1 = "file1.csv";
        String file2 = "file2.csv";
        String file3 = "file3.csv";
    
        // Create sample files
        try {
            FileWriter file = new FileWriter(file1);
            file.write("Name,Age,Gender\n");
            file.write("Alice,25,Female\n");
            file.write("Bob,30,Male\n");
            file.close();
    
            file = new FileWriter(file2);
            file.write("ID,Name,Age,Gender\n");
            file.write("1,Alice,25,Female\n");
            file.write("2,Bob,30,Male\n");
            file.write("3,Charlie,35,Male\n");
            file.close();
    
            file = new FileWriter(file3);
            file.write("Name,Age,Gender,Height,Weight\n");
            file.write("Alice,25,Female,1.68,60.0\n");
            file.write("Bob,30,Male,1.75,75.5\n");
            file.write("Charlie,35,Male,1.80,80.0\n");
            file.write("David,40,Male,1.83,85.5\n");
            file.write("Emily,45,Female,1.70,65.5\n");
            file.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    
        String input;
        System.out.print("Enter the filename/path of the CSV file: ");
        
        Scanner sc = new Scanner(System.in);
        input = sc.nextLine();
        int row = 0, col = 0;
        try (BufferedReader fp = new BufferedReader(new FileReader(input))) {
            col = fp.readLine().split(",").length;
            
            String line;
            
            while ((line = fp.readLine()) != null) {
                row += 1;
            }
        } catch (Exception e) {
            System.out.println("Error: File not found.");
            return;
        }
        
        System.out.println(input + " contains " + row + " rows and " + col + " columns of data.");
    }
}