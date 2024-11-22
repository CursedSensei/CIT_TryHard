public class Hero {
    public String name, faction;
    public int level;
    
    public Hero() {
        name = "Mystery";
        faction = "Neutral";
        level = 1;
    }
    
    public Hero(String name, String faction) {
        this.name = name;
        this.faction = faction;
        level = 1;
    }
    
    public void levelUp(int levels) {
        if (levels < 0) return;
        level += levels;
    }
}