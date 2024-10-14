public class AgeException extends Exception {
    public AgeException(int age) {
        super("Age " + age + " is too young.");
    }
}