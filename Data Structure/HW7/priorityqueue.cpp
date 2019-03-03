//Sucharita Das
//HW7

#include "priorityqueue.h"//header files
#include <iostream>

prityQue::prityQue() : prityhead(NULL) {}//constructor

prityQue::~prityQue()
{
	node* pqLast;//declearing pointer
	node* current = prityhead;
	while (current != NULL)
	{
		pqLast = current;
		current = current->nodeNext;
		delete pqLast;
	}
	prityhead = NULL;
}

bool prityQue::isemty() const//isempty boolean function 
{
	if (prityhead == NULL)//checking empty or not
	{
		return true;
	}
	
	return false;
}

bool prityQue::enque(const evnt& newQ)//enqueue function to check empty or not
{
	if (&newQ == NULL)
	{
		return false;
	}
	
	if (prityhead == NULL || newQ.gettime() < prityhead->nodeData.gettime())
	{
		node* tempNode = new node(newQ, prityhead);//keeping the memory in temporary
		prityhead = tempNode;
		return true;
	}
	node* current = prityhead;
	node* previous = prityhead;
	while (current != NULL && (newQ.gettime() > current->nodeData.gettime()))
	{
		previous = current;
		current = current->nodeNext;
	}
	
	if (current != NULL && (newQ.getEvType() == 'D' && current->nodeData.getEvType() == 'A'))
	{
		if (newQ.gettime() == current->nodeData.gettime())
		{
			previous = current;
			current = current->nodeNext;
		}
	}
	
	node* tempNode = new node(newQ, previous->nodeNext);//temporary memory allocation
	previous->nodeNext = tempNode;
	return true;
}
bool prityQue::deQu()//dequeue funtion which is boolean
{
	if (prityhead == NULL)//checking it is empty or not
	{
		return false;
	}

	node* headNext = prityhead->nodeNext;
	delete prityhead;
	prityhead = headNext;
	return true;
}

evnt prityQue::qumethod() const throw(Data)//Check whether the priority queue is empty or not
{
	if (prityhead == NULL)
	{
		throw Data("prityQue is Empty");
	}
	
	return prityhead->nodeData;
}

