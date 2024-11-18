import java.util.*;

public class PersonManager {
    private List<Person> persons;
    
    public PersonManager() {
        persons = new ArrayList<>();
    }
    
    public void addPerson(Person person) {
        persons.add(person);
    }
    
    public void displayAllPersons() {
        for (Person p : persons) {
            p.displayInfo();
        }
    }
}