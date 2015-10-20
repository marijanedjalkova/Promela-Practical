#define N 6
bool print[N] = false;
chan outgoing = [0] of {byte};
chan receiving = [0] of {byte};
int k;
int count;

init{
	int i;
	for (i : 0 .. N - 1){
		run P(i);
	}

	run Distributor();
}

proctype Distributor(){
	int mylimit = 100;
	int ack;
	do
	:: mylimit > 0 -> outgoing!mylimit;
				mylimit = mylimit - 1;

				receiving?ack;
	:: mylimit <= 0 -> break;
	od;
}

proctype P(int id){
	byte num;
	do
		::true -> outgoing?num;
		print[id] = true;
		printf("\n=============%d from process %d===============\n", num, id);
		print[id] = false;
		receiving!num;
	od;
}

never{
	count = 0;
	for (k : 0 .. N - 1){
		if 
			:: print[k] == true -> count++;
		fi;
	}
	count < 2;
}

