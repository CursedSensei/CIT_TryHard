public class Employee extends Person {
    private double salary;
    private String department;
    
    public Employee(String name, int age, double salary, String department) {
        super(name, age);
        this.salary = salary;
        this.department = department;
    }
    
    @Override
    public void displayInfo() {
        System.out.println("-- EMPLOYEE DETAILS --");
        System.out.println("Name: " + getName());
        System.out.println("Age: " + getAge());
        System.out.println(String.format("Salary: Php%.2f", salary));
        System.out.println("Department: " + department);
    }
}