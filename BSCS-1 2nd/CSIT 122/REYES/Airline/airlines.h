#define FirstClass 1
#define Economy 2

void initSeats(int *seats, int size);
void displaySeats(int *seats, int size);
int assignSeat(int *st, int seatType);
int assignFirstClass(int *seats, int size);
int assignEconomy(int *seats, int size);
void boardPass(int seat);
void Exit(void);
