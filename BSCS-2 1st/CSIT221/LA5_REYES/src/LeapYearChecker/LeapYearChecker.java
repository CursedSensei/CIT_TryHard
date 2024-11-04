package LeapYearChecker;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class LeapYearChecker extends JFrame {
    private JTextField yearTextField;
    private JButton checkYearButton;
    private JPanel pName;

    LeapYearChecker() {
        checkYearButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                int year = 0;

                try {
                    year = Integer.parseInt(yearTextField.getText());
                } catch (NumberFormatException ex) {
                    JOptionPane.showMessageDialog(null, "Not a leap year");
                    return;
                }

                if (year % 4 == 0) {
                    if (year % 100 == 0) {
                        if (year % 400 == 0) {
                            JOptionPane.showMessageDialog(null, "Leap year");
                            return;
                        }
                    } else {
                        JOptionPane.showMessageDialog(null, "Leap year");
                        return;
                    }
                }

                JOptionPane.showMessageDialog(null, "Not a leap year");
            }
        });
    }

    public static void main(String[] args) {
        LeapYearChecker s = new LeapYearChecker();
        s.setContentPane(s.pName);
        s.setSize(600, 300);
        s.setDefaultCloseOperation(EXIT_ON_CLOSE);
        s.setVisible(true);
        s.setTitle("Leap Year Checker");
    }
}
