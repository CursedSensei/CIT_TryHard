public class Healer extends Superhero {
    private boolean hasHealed = false;
    
    public Healer() {
        super(80, 5, 10);
    }
    
    public void heal() {
        if (!hasHealed) {
            hasHealed = true;
            setHealth(getHealth() + 80);
        }
    }
    
    @Override
    public void takeDamage(int damage) {
        int health = getHealth();
        if (damage % 2 == 1) {
            health -= Math.max(0, (damage / 2) - getArmor());
        } else {
            health -= Math.max(0, damage - getArmor());
        }
        
        if (health <= 0) {
            health = 0;
            setHealth(health);
            if (!hasHealed) heal();
            else System.out.println("Healer has fallen");
            return;
        }
        setHealth(health);
    }
}