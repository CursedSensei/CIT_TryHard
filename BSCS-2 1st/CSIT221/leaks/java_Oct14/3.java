import java.util.Scanner;

public class Main {
    public static void main(String args[]) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter a string: ");
        String myString = null;
        
        myString = sc.nextLine();
        
        if (myString.charAt(0) == '-' || myString.charAt(myString.length() - 1) == '-') {
            myString = null;
        }
        
        try {
            System.out.println(myString.toUpperCase());
        } catch (NullPointerException e) {
            System.out.println("myString is still null");
        } finally {
            System.out.println("Everything's over");
        }
    }
}