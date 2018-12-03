#include <time.h>
#include <stdio.h>

int totalCalls = 0;
int ackermann(int x, int y);
int main(){
  //printf("%li\n",CLOCKS_PER_SEC);
  clock_t before, after;
  before = clock();
  int ret = ackermann(3,6);
  after = clock();
  clock_t time = (after - before) ; // / CLOCKS_PER_SEC;
  long _time = (long) time;
  printf("Total Calls: %i\nTotal time: %li Processor time\n", totalCalls, _time);
  return 1;
}


int ackermann(int x, int y){
  totalCalls++;

  if (x == 0)
    return y+1;

  else if (y == 0)
    return ackermann(x-1, 1);

  else
    return ackermann(x-1, ackermann(x, y-1));

}
