import java.util.Scanner;

public class Main {
    public static void main(String args[]) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter the size of the array: ");
        int size = sc.nextInt();
        double[] arr = new double[size];
        
        for (int i = 0; i < size; i++) {
            System.out.print("Enter element " + (i + 1) +": ");
            arr[i] = sc.nextDouble();
        }
        
        System.out.print("Enter the index of the element to print: ");
        int idx = sc.nextInt();
        
        try {
            System.out.println("Element at index " + idx + ": " + String.format("%.2f", arr[idx]));
        } catch (ArrayIndexOutOfBoundsException e) {
            System.out.println("Index " + idx + " is invalid.");
        }
    }
}