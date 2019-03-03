//Sucharita Das
//Data Stucture
//LinkedList Homework 5


//Include the files
#include <iostream>
#include <string>
#include "LinkedList.h"
using std::string;
using namespace std;


//Initilize the LinkedList Pointer
LinkedList::LinkedList()
{
	headPtr = nullptr;
	while (headPtr != NULL) {
		Node *temp = headPtr->nextPtr;
		delete headPtr;
		headPtr = temp;
	}

}//default constructor

//This is clear function
void LinkedList::clear()
{
	headPtr = headPtr->nextPtr;
	while (headPtr != nullptr)
	{Node *temp = headPtr;
	headPtr = headPtr->nextPtr;
	delete(temp);//loop at the end
	}
}

bool LinkedList::deletePosition(int index)//This is delete position function
{
	if (headPtr->nextPtr == nullptr)
		return false;
	if (index == 0)
		return false;
	if (index == 1)
		return deleteAtFront();
	int i = 1;

	Node *temp = headPtr->nextPtr;
	while (temp != nullptr)//loop to the position
	{
		if (i == index - 1)
		{
			if (temp->nextPtr == nullptr)
				return false;
			Node *del = temp->nextPtr;
			temp->nextPtr = del->nextPtr;//set the pervious pointer to preview
			delete(del);
			return true;
		}
		i++;
		temp = temp->nextPtr;
	}
	return false;
}

// push_front function
bool LinkedList::insertAtFront(char value)// add node from front and the link to the next node
{
	Node *newNode = new Node;
	newNode->data = value;
	newNode->nextPtr = headPtr;//set the new node next pointer to null pointer

		headPtr = newNode;
	
	return true;
}

//pop_front function
//first Node after headptr is 1
bool LinkedList::insertBeforePosition(char value, int index)
{
	if (index == 0)
		return false;
	if (headPtr->nextPtr == nullptr && index > 1)
		return false;
	if (index == 1)
		return insertAtFront(value);
	Node *temp = headPtr->nextPtr;
	int i = 1;
	Node *newNode = new Node;
	newNode->data = value;
	newNode->nextPtr = nullptr;
	while (temp != nullptr)
	{		
		if (i == index - 1)
		{
			if (temp->nextPtr == nullptr)
				return insertAtBack(value);
			else {
				newNode->nextPtr = temp->nextPtr;
				temp->nextPtr = newNode;
				return true;

			};// create a temporary node and the point to the next node and the then delete the previous one
		}
		i++;
		temp = temp->nextPtr;
	}
	return false;
}

ostream& operator << (ostream &out, LinkedList &list) // non-member, simply because it doesn't need to be
{
	Node *temp = list.headPtr->nextPtr;// set the first pointer  then move to the next pointer
	while (temp != nullptr)
	{
		out << temp->data << endl;
		temp = temp->nextPtr;
	}
	return out;
}


//This function is for destructor function
LinkedList::~LinkedList()
{
	headPtr = headPtr->nextPtr;
	while (headPtr != nullptr)
	{
		Node *temp = nullptr;
		headPtr = headPtr->nextPtr;
		delete (temp);
		clear();

	}


}

//pop_back or delete at back function
bool LinkedList::deleteAtBack()
{
	if (headPtr->nextPtr == nullptr)
		return false;
	Node *temp = headPtr->nextPtr;
	if (temp->nextPtr == nullptr)
		return deleteAtFront();
	while (temp->nextPtr != nullptr)
	{
		temp = temp->nextPtr;
	}
	Node *remove = temp->nextPtr;
	temp->nextPtr = nullptr;// set the end null then delete the value
	delete(remove);
	return true;
}

//push_back function
bool LinkedList::insertAtBack(char value)
{// this function will enter new value from back
	if (headPtr->nextPtr == nullptr)
		return insertAtFront(value);
	Node *temp = headPtr->nextPtr;
	Node *newNode = new Node;
	newNode->data = value;
	newNode->nextPtr = nullptr;
	while (temp->nextPtr != nullptr)//loop 
	{
		temp = temp->nextPtr;
	}
	temp->nextPtr = newNode;
	return true;//increasing the size

}

bool LinkedList::deleteAtFront()// This function is for delete in from front 
{
	if (headPtr->nextPtr == nullptr)
	return false;
	Node *temp = headPtr->nextPtr;
	headPtr->nextPtr = temp->nextPtr;
	delete(temp);
	return true;
}
