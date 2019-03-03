//Sucharita Das
//HW7
//Includeing all header file
#include <iostream>
#include "node.h"

node::node()// constructor
{
	nodeNext = NULL;//pointer as null
}
node::node(evnt nData)
{
	nodeData = nData;//initilisation
	nodeNext = NULL;
}
node::node(evnt nData, node* nNextNode)//constructor
{
	nodeData = nData;
	nodeNext = nNextNode;
}
node::~node() {}//destructor