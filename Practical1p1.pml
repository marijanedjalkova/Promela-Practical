#define SIZE 0
byte count;
byte sum1;
byte sum2;
chan outgoing1 = [SIZE] of {byte};
chan outgoing2 = [SIZE] of {byte};
chan receiving = [1] of {byte};

init{
	count = 1;
	sum1 = 0;
	sum2 = 0;
	run Intermediate1();
	run Intermediate2();
	run Sender();
	run Receiver();
}

proctype Sender(){
	do
		:: count <=10->
			if
				:: true -> outgoing1!count;
				:: true -> outgoing2!count;
			fi;
			count++;
	od;
}

proctype Receiver(){
	byte recv;
	do
	:: nempty(receiving) -> receiving?recv;
	od;
}

proctype Intermediate1(){
	byte recv;
	do
		:: nempty(outgoing1) -> outgoing1?recv;
			sum1 = sum1 + recv;
			receiving!recv;
	od;

}

proctype Intermediate2(){
	byte recv;
	do
		:: nempty(outgoing2) -> outgoing2?recv;
			sum2 = sum2 + recv;
			receiving!recv;
	od;

}
