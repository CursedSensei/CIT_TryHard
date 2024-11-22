public class Mage extends Superhero {
    private int mana;
    
    public Mage() {
        super(100, 25, 5);
        mana = 100;
    }
    
    public void castSpell() {
        if (mana >= 10) {
            System.out.println("Mage casts a powerful spell!");
            mana -= 10;
        } else {
            System.out.println("Not enough mana to cast a spell");
        }
    }
    
    @Override
    public void takeDamage(int damage) {
        int health = getHealth();
        health -= Math.max(0, damage - getArmor());
        if (health <= 0) {
            health = 0;
            System.out.println("Mage has fallen");
        }
        setHealth(health);
    }
}