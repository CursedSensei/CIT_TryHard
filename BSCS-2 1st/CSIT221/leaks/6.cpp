public class BankAccount {
    private double balance;
    
    public BankAccount(double initialBalance) {
        balance = initialBalance;
    }
    
    public void withdraw(double amount) throws InsufficientFundsException {
        if (amount > balance) {
            throw new InsufficientFundsException();
        }
        
        balance -= amount;
        
        System.out.println("Withdrawal successful. Remaining balance: " + balance);
    }
}