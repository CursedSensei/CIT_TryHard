import java.util.Scanner;
import java.io.*;
// joke nara diay
public class Main {
    static final int MAX_FILE_NAME_LEN = 100;
    static final int BUFFER_SIZE = 1024;

    public static void main(String[] args) throws IOException {
        String fileName1 = "";
        String fileName2 = "";
        String newFileName = "";
        FileInputStream file1 = null;
        FileInputStream file2 = null;
        FileOutputStream newFile = null;
        byte[] buffer = new byte[BUFFER_SIZE];
        int bytesRead = 0;

        // create sample files
        try {
            FileOutputStream sampleFile1 = new FileOutputStream("file1.txt");
            sampleFile1.write("This is the contents of file 1.\nIt contains some random text.\n".getBytes());
            sampleFile1.close();
            FileOutputStream sampleFile2 = new FileOutputStream("file2.txt");
            sampleFile2.write("This is the contents of file 2.\nIt also contains some random text.\n".getBytes());
            sampleFile2.close();
        } catch (IOException e) {
            System.out.println("Error: Could not create sample files.");
            System.exit(1);
        }
        
        Scanner sc = new Scanner(System.in);
        
        System.out.print("Enter the name of the first file: ");
        fileName1 = sc.nextLine();
        System.out.print("Enter the name of the second file: ");
        fileName2 = sc.nextLine();
        
        try {
            file1 = new FileInputStream(fileName1);
        } catch (Exception e) {
            System.out.println("Error: Could not open file " + fileName1 +".");
            return;
        }
        try {
            file2 = new FileInputStream(fileName2);
        } catch (Exception e) {
            System.out.println("Error: Could not open file " + fileName2 +".");
            return;
        }
        
        System.out.print("Enter the name of the new file: ");
        newFileName = sc.nextLine();

        try {
            newFile = new FileOutputStream(newFileName);
        } catch (Exception e) {
            System.out.println("Error: Could not open file " + newFileName +".");
            return;
        }
        
        bytesRead = file1.read(buffer);
        bytesRead += file2.read(buffer, bytesRead, BUFFER_SIZE - bytesRead);
        newFile.write(buffer, 0, bytesRead);
        
        file1.close();
        file2.close();
        newFile.close();
        
        System.out.println("Files merged successfully.");
    }
}