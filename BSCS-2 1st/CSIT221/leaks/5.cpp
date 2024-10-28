import java.io.*;
import java.util.Scanner;
import java.util.ArrayList;

public class Main {
    public static void main(String[] args) throws IOException {
        Scanner sc = new Scanner(System.in);
        
        ArrayList<Character>chars = new ArrayList<>();
        ArrayList<Character>nums = new ArrayList<>();
        char input;
        
        do {
            System.out.print("Enter a character: ");
            input = sc.nextLine().charAt(0);
            
            if (Character.isDigit(input)) {
                nums.add(input);
            } else if (Character.isLetter(input)) {
                chars.add(input);
            }
        } while(Character.isDigit(input) || Character.isLetter(input));
        
        new File("letters").mkdir();
        
        FileWriter fp = new FileWriter("letters/inputted.txt");
        while(!chars.isEmpty()) {
            fp.write(chars.get(0) + "\n");
            chars.remove(0);
        }
        fp.close();
        
        new File("numbers").mkdir();
        
        fp = new FileWriter("numbers/inputted.txt");
        while(!nums.isEmpty()) {
            fp.write(nums.get(0) + "\n");
            nums.remove(0);
        }
        fp.close();
    }
}