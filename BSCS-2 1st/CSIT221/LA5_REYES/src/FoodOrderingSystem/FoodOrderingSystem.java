package FoodOrderingSystem;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class FoodOrderingSystem extends JFrame {
    private JCheckBox cPizza;
    private JRadioButton rb0;
    private JRadioButton rb5;
    private JCheckBox cBurger;
    private JRadioButton rb10;
    private JCheckBox cFries;
    private JRadioButton rb15;
    private JCheckBox cSoftDrinks;
    private JCheckBox cTea;
    private JCheckBox cSundae;
    private JButton btnOrder;
    private JLabel lPizza;
    private JLabel lBurger;
    private JLabel lFries;
    private JLabel lSoft;
    private JLabel lTea;
    private JLabel lSundae;
    private JPanel pName;

    FoodOrderingSystem() {
        btnOrder.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                double total = 0;

                if (cPizza.isSelected()) {
                    total += Integer.parseInt(lPizza.getText().split(" ")[1]);
                }
                if (cBurger.isSelected()) {
                    total += Integer.parseInt(lBurger.getText().split(" ")[1]);
                }
                if (cFries.isSelected()) {
                    total += Integer.parseInt(lFries.getText().split(" ")[1]);
                }
                if (cSoftDrinks.isSelected()) {
                    total += Integer.parseInt(lSoft.getText().split(" ")[1]);
                }
                if (cTea.isSelected()) {
                    total += Integer.parseInt(lTea.getText().split(" ")[1]);
                }
                if (cSundae.isSelected()) {
                    total += Integer.parseInt(lSundae.getText().split(" ")[1]);
                }

                JRadioButton arr[] = {rb0, rb5, rb10, rb15};

                for (JRadioButton rb : arr) {
                    if (rb.isSelected()) // incomplete here
                }
            }
        });
    }

    public static void main(String[] args) {
        FoodOrderingSystem s = new FoodOrderingSystem();
        s.setContentPane(s.pName);
        s.setSize(600, 300);
        s.setTitle("Simple Calculator");
        s.setDefaultCloseOperation(EXIT_ON_CLOSE);
        s.setVisible(true);
    }
}
