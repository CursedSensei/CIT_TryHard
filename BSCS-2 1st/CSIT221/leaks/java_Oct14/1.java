import java.util.Scanner;

public class Main {
    public static void main(String args[]) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter the value of a: ");
        int a = sc.nextInt();
        System.out.print("Enter the value of b: ");
        int b = sc.nextInt();
        int c;
        
        try {
            System.out.println("Quotient: " + (a / b));
        } catch (ArithmeticException e) {
            System.out.println("Invalid division");
        }
    }
}