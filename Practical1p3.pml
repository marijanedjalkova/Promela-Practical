#define xodd (x % 2 == 1)
#define ylex (y <= x)
#define yex (y==x)


byte x=1;
byte y=0;

active proctype P1(){
	do
		:: x=x+2
	od;
}

active proctype P2(){
	do
		:: x=x+1
	od;
}

active proctype P3(){
	do
		:: y<x -> y=x
	od;
}

ltl stmt1 {[]xodd}
ltl stmt2 {<>[]xodd}
ltl stmt3 {<>[]<>xodd}
ltl stmt4 {[]ylex}
ltl stmt5 {[](yex-><>!yex)}

