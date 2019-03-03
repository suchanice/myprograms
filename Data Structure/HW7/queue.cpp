//Sucharita Das
//HW7
//Includeing all header file
#include "queue.h"
#include <cmath>

que::que() : method(0), eq(0), qdata(NULL)//constructor
{
	qdata = new evnt[qmax];
}

que::~que()//destructor
{
	delete[] qdata;
	qdata = NULL;
}

bool que::isemty() const//Check whether the queue is empty or not.
{
	if (method == eq)
	{
		return true;
	}
	return false;
}

bool que::enque(const evnt& newqData)//enqueue function
{

	if ((method % qmax) == (eq + 1) % qmax)
	{
		return false;
	}
	
	qdata[(eq) % qmax] = newqData;//putting into array
	eq++;
	return true;
}

bool que::deQu()//dequeue function
{
	//Check whether the queue is empty or not
	if (method == eq)
	{
		return false;
	}

	method++;
	return true;
}

evnt que::qumethod() const throw(Data)//qumethod function to check queue is empty or not
{
	if (method == eq)
	{
		throw Data("que is Empty");
	}

	return qdata[method % qmax];
}

