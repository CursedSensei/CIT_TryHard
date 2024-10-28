import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        createSampleFiles();
        
        Scanner sc = new Scanner(System.in);
        
        System.out.print("Enter file path: ");
        String input = sc.nextLine();
        
        int number = 0;
        
        try (BufferedReader fp = new BufferedReader(new FileReader(input))) {
            while ((input = fp.readLine()) != null) {
                for (String S : input.split(" ")) {
                    if (!S.equals("")) number += 1;
                }
            }
        }
        catch (Exception e) {
            System.out.println("File not found.");
            return;
        }
        
        System.out.println("Word count: " + number);
    }

    private static void createSampleFiles() {
        try {
            FileWriter file1 = new FileWriter("sample_file_1.txt");
            file1.write("This is sample file 1.\nIt has multiple lines.\nIt should have 3 lines in total.");
            file1.close();

            FileWriter file2 = new FileWriter("sample_file_2.txt");
            file2.write("This is sample file 2.\nIt has only 2 lines.");
            file2.close();

            FileWriter file3 = new FileWriter("sample_file_3.txt");
            file3.close();

            FileWriter file4 = new FileWriter("sample_file_4.txt");
            file4.write("   This  is  file 4.   \nIt has   a      lot     of white spaces  and new lines  \n");
            file4.close();
        } catch (IOException e) {
            System.out.println("Error creating sample files.");
        }
    }

}