/*
Name: Sucharita Das
CSCI : 2313
Status: Program running properly*/

//Include the needed files
#include "function.h"// declearing header file file in the main function
#include <iostream>
#include<string>
#include<fstream>
#include <sstream>
using namespace std;
//main function 

int main()
{
	int c;
	// Object of derived classes
	Dog d; 
	Fish f;
	Horse h;
	Monkey m;
	Lizard l;
	ofstream file;
	
	string st;
	int num;
	using std::ifstream;
	ifstream inStream;

	//Opens the file Dog.csv for reading		
	inStream.open("Dog.csv");
	try
	{
		if (!inStream) {
			cout << "Unable to open file";
			exit(1); // terminate with error
						}
		num = 0;
		while (getline(inStream, st, ',')) {//reading from file and setting the values
			num++;
			switch (num) {
				case 1:	d.setName(st);	break;
				case 2:	d.setBreed(st); 	break;
				case 3:	d.setAge(atoi(st.c_str()));	break;//converted int to string
				case 4: d.setColor(st); break;
				case 5: d.setubtract10(atoi(st.c_str())); break;//converted int to string
				default: break;
						 }
					}
		}
	catch (int e)
	{		cout << "Unable to open file: " << endl;	}
	//Close file
	d.print();
	inStream.close();
//...................................................................
	//Opens the file Fish.csv
	inStream.open("Fish.csv");
	try
	{
		if (!inStream) {
			cout << "Unable to open file";
			exit(1); // terminate with error
		}
		
		num = 0;
		while (getline(inStream, st, ',')) {//reading from file and setting the values
			num++;
			switch (num) {
			case 1:	f.setName(st);	break;
			case 2:	f.setColor(st); 	break;
			case 3: f.setFreshwater(st); break;
			case 4: f.setHabitat(st); break;
			case 5: f.setPredator(st); break;
			default: break;
			}
			//f.print();
		}
}
catch (int e)
{	cout << "Unable to open file: " << endl;}
f.print();
//Close file
inStream.close();
//......................................................


//Opens the file Horse.csv for reading		
inStream.open("Horse.csv");
try
{
	if (!inStream) {
		cout << "Unable to open file";
		exit(1); // terminate with error
	}
	num = 0;
	while (getline(inStream, st, ',')) {//reading from file and setting the values
		num++;
		switch (num) {
		case 1:	h.setName(st);	break;
		case 2: h.setColor(st); break;
		case 3: h.setManeColor(st); break;
        case 4:	h.setAge(atoi(st.c_str()));	break;
		case 5: h.setadd1(atoi(st.c_str())); break;
		default: break;
		}
	}
}
catch (int e)

{

	cout << "Unable to open file: " << endl;

}
h.print();
//Close file
inStream.close();
//..................................................................
	


//Opens the file Monkey.csv for reading		
inStream.open("Monkey.csv");
try
{
	if (!inStream) {
		cout << "Unable to open file";
		exit(1); // terminate with error
	}
	num = 0;
	while (getline(inStream, st, ',')) {//reading from file and setting the values
		num++;
		switch (num) {
		case 1:	m.setName(st);	break;
		case 2:	m.setColor(st); 	break;
		case 3:	m.setAge(atoi(st.c_str()));	break;//converted int to string
		case 4: m.setWild(st); break;
		case 5: m.sethome(st); break;
		case 6: m.setchangeEndangered(st.c_str()); break;
		default: break;
		}
	}
}
catch (int e)

{

	cout << "Unable to open file: " << endl;

}
m.print();
//Close file

inStream.close();
//..................................................


//Opens the file Lizard.csv for reading		
inStream.open("Lizard.csv");
try
{
	if (!inStream) {
		cout << "Unable to open file";
		exit(1); // terminate with error
	}
	num = 0;
	while (getline(inStream, st, ',')) {//reading from file and setting the values
		num++;
		switch (num) {
		case 1:	l.setName(st);	break;
		case 2:	l.setColor(st); 	break;
		case 3:	l.setHabitat(st.c_str());	break;
		case 4: l.setProtected(st); break;
		case 5: l.setWeight(atoi(st.c_str())); break;//converted int to string
		default: break;
		}
	}
}
catch (int e)

{

	cout << "Unable to open file: " << endl;

}
l.print();
//Close file

inStream.close();

	
	
cin >> c;
	return 0;
}