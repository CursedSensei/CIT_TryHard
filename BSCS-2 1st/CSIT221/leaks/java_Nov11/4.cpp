public class Superhero {
    private int health, power, armor;
    
    public Superhero(int health, int power, int armor) {
        this.health = health;
        this.power = power;
        this.armor = armor;
    }
    
    public int getHealth() {
        return health;
    }
    public int getPower() {
        return power;
    }
    public int getArmor() {
        return armor;
    }
    
    public void setHealth(int health) {
        this.health = health;
    }
    
    public void takeDamage(int damage) {
        health -= Math.max(0, damage - armor);
        if (health <= 0) {
            health = 0;
            System.out.println("Superhero has fallen");
        }
    }
}