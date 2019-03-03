//Sucharita Das
//Data Stucture
//LinkedList Homework 5
#include <iostream>
#include "linkedlist.h"
using namespace std;
int main()

{
	int k;//variable
	//Object of LinkedList class
	LinkedList outPut;

	for (int i = 65; i <= 74; i++)//print insertAtFront
	outPut.insertAtFront((char)i);
	cout << " Insertion at front      " << endl;//Print insertion at front
	cout<< outPut << endl<<endl;
	for (int i = 74; i <= 76; i++)
	outPut.insertAtBack((char)i);
	cout << " Insert at the End       " << endl;//Print insert at the End
	cout<< outPut << endl<<endl;
	outPut.insertBeforePosition('M', 2);
	cout << " InsertBeforePosition" << endl;
	cout <<outPut<<endl<<endl;
	outPut.deleteAtFront();
	cout << " Delete at front         " << endl;//Print Delete at front 
	cout << outPut << endl << endl;
	outPut.deleteAtBack();
	cout << " Delete at back          " << endl;//Print Delete on back 
	cout<<outPut << endl << endl;	
	outPut.deletePosition(3);
	cout << " Delete Position         " << endl;//Print Delete Position
	cout<<outPut << endl << endl;
	outPut.deletePosition(10);
	cout << " Delete Position          " << endl;//Print delete Position
	cout<<outPut << endl << endl;
	cin >> k;
	return 0;
	

}