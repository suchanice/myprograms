//Sucharita Das
//HW7
//Includeing all header file
#ifndef NODE_H
#define NODE_H
#include "event.h"

class node//Class name
{
public:
	evnt nodeData;
	node* nodeNext;
	node();	//Constructor
	node(evnt nData);
	node(evnt nData, node* nNextNode);
	~node();//Destructor
};
#endif

