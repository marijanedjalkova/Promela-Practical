#define N 6
bool oneTrue;
bool moreThanOneTrue;
bool print[N] = false;
chan outgoing = [0] of {byte};
chan receiving = [0] of {byte};

init{
	oneTrue = false;
	moreThanOneTrue = false;
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
		if 
			:: oneTrue == false -> oneTrue = true;
			:: else -> moreThanOneTrue = true;
		fi;
		printf("\n=============%d from process %d===============\n", num, id);
		print[id] = false;
		receiving!num;
	od;
}

never{
	do
	:: moreThanOneTrue == true;
	od;
}

