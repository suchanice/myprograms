//Sucharita Das
//HW7
//Includeing all header file
#ifndef QUEUE_H
#define  QUEUE_H
#include "event.h"
#include "data.h"

const unsigned int qmax = 101;

class que//que is a class
{
private:

	unsigned int method;
	unsigned int eq;
	evnt* qdata;

public:
	
	que();//Default constructor
	
	~que	();//destructor
	bool isemty() const;//isempty boolean function
	bool enque(const evnt& newqData);//enque boolean function
	bool deQu();//dequeue boolean function
	evnt qumethod() const throw(Data);
};
#endif
