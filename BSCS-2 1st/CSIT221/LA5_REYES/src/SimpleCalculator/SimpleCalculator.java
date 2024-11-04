package SimpleCalculator;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class SimpleCalculator extends JFrame {
    private JPanel pName;
    private JButton btnCompute;
    private JTextField tfNumber1;
    private JComboBox cbOperations;
    private JTextField tfNumber2;
    private JLabel lblResult;

    SimpleCalculator() {
        btnCompute.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                int num1 = Integer.parseInt(tfNumber1.getText());
                int num2 = Integer.parseInt(tfNumber2.getText());

                switch (cbOperations.getSelectedIndex()) {
                    case 0: {
                        lblResult.setText(String.format("%d", num1 + num2));
                        break;
                    }
                    case 1: {
                        lblResult.setText(String.format("%d", num1 - num2));
                        break;
                    }
                    case 2: {
                        lblResult.setText(String.format("%d", num1 * num2));
                        break;
                    }
                    case 3: {
                        lblResult.setText(String.format("%d", num1 / num2));
                        break;
                    }
                }
            }
        });
    }

    public static void main(String[] args) {
        SimpleCalculator s = new SimpleCalculator();
        s.setContentPane(s.pName);
        s.setSize(600, 300);
        s.setTitle("Simple Calculator");
        s.setDefaultCloseOperation(EXIT_ON_CLOSE);
        s.setVisible(true);
    }
}
