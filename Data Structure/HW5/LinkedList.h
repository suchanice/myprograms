//Sucharita Das
//Data Stucture
//LinkedList Homework 5

#ifndef LINKEDLIST_H
#define LINKEDLIST_H
#include<iostream>
using namespace std;
struct Node
{
	char data = 0;
	Node* nextPtr = nullptr;
};

class LinkedList
{
private:
	Node *headPtr;
public:
	LinkedList();//default constructor
	~LinkedList();//Destructor

	bool insertAtFront(char value);
	bool insertBeforePosition(char value, int index);
	//first Node after headptr is 1
	//false if pos zero or out of range
	bool insertAtBack(char value);

	bool deleteAtFront();
	bool deletePosition(int index);
	//first Node after headptr is 1
	//false if pos zero or out of range
	bool deleteAtBack();
	//false if empty
	void clear(); //frees memory for entire list
	friend ostream& operator << (ostream &out, LinkedList &list);
};
#endif

