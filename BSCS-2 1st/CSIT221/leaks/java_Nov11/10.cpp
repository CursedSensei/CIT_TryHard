public class Student extends Person {
    private double GPA;
    private String major;
    
    public Student(String name, int age, String major, double GPA) {
        super(name, age);
        this.GPA = GPA;
        this.major = major;
    }
    
    @Override
    public void displayInfo() {
        System.out.println("-- STUDENT DETAILS --");
        System.out.println("Name: " + getName());
        System.out.println("Age: " + getAge());
        System.out.println("Major: " + major);
        System.out.println(String.format("GPA: %.1f", GPA));
    }
}