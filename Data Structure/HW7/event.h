
///Sucharita Das
//HW7
//Includeing all header file
#ifndef EVENT_H
#define EVENT_H

class evnt//Class name event
{
private:
	char evType;
	unsigned int cusArrTime;
	unsigned int lenOfTime;

public:


	evnt(void);	//Default constructor
	evnt(unsigned int incusArrTime, unsigned int inLenOfTime);//Constructor
	evnt(char inEType, unsigned int incusArrTime, unsigned int inLenOfTime);
	~evnt();//destructor
	char getEvType() const;
	unsigned int gettime() const;
	unsigned int getTimeLen() const;
	int setEvType(char inEType);
	int setTime(unsigned int incusArrTime);
	int setTimeLen(unsigned int inLenOfTime);
};
#endif