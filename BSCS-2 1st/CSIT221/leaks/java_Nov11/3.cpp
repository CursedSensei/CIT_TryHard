import java.util.ArrayList;

public class Team {
    public String teamName;
    public ArrayList<Hero> heroes;
    public int damageBonus;
    
    public Team(String teamName, ArrayList<Hero> heroes) {
        this.teamName = teamName;
        this.heroes = heroes;
        
        if (heroes.size() == 0) return;
        int sum = 0;
        String faction = heroes.get(0).faction;
        for (Hero s : heroes) {
            sum += s.level;
            if (!s.faction.equals(faction)) {
                faction = null;
            }
        }
        
        damageBonus = sum * 10;
        if (faction == null) {
            damageBonus -= 50;
        } else {
            damageBonus += 100;
        }
    }
}