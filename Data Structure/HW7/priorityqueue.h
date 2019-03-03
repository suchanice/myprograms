//Sucharita Das
//HW7
//Includeing all header file
#ifndef PRIORITYQUEUE_H
#define PRIORITYQUEUE_H
#include "event.h"
#include "data.h"
#include "node.h"

class prityQue//Class name
{
private:
	node* prityhead;
	
public:
	prityQue();//default constructor
	~prityQue();//destructor
	bool isemty() const;//boolean isempty function
	bool enque(const evnt& newqData);//boolean enqueue function
	bool deQu();//boolean dequeue function
	evnt qumethod() const throw(Data);
};
#endif

