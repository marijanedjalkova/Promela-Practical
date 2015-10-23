byte sum1;
byte sum2;
chan outgoing1 = [0] of {byte};
chan outgoing2 = [0] of {byte};
chan receiving = [0] of {byte};

init{
	sum1 = 0;
	sum2 = 0;
	run Intermediate1();
	run Intermediate2();
	run Sender();
	run Receiver();
}

proctype Sender(){
	byte count = 1;
	do
		:: count <=10->
			if
				:: true -> outgoing1!count;
				:: true -> outgoing2!count;
			fi;
			count++;
		:: count > 10 -> break;
	od;
}

proctype Receiver(){
	byte recv;
	do
		:: receiving?recv;
	od;
}

proctype Intermediate1(){
	byte recv;
	do
		:: outgoing1?recv;
			sum1 = sum1 + recv;
			receiving!recv;
	od;

}

proctype Intermediate2(){
	byte recv;
	do
		:: outgoing2?recv;
			sum2 = sum2 + recv;
			receiving!recv;
	od;

}
