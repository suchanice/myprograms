//Sucharita Das
//HW7
//Includeing all header file
#include "event.h"
#include <iostream>

evnt::evnt(void) : evType('A'), cusArrTime(0), lenOfTime(0) {}//default constructor
evnt::evnt(unsigned int incusArrTime, unsigned int inLenOfTime) : evType('A'), cusArrTime(incusArrTime), lenOfTime(inLenOfTime) {}
evnt::evnt(char inEType, unsigned int incusArrTime, unsigned int inLenOfTime) : evType(inEType), cusArrTime(incusArrTime), lenOfTime(inLenOfTime) {}

evnt::~evnt() {}//destructor
char evnt::getEvType() const
{
	return evType;
}

unsigned int evnt::gettime() const//Return customer arrival time.
{
	return cusArrTime;
}

unsigned int evnt::getTimeLen() const//Return time length.
{
	return lenOfTime;
}

int evnt::setEvType(char inEType)
{
	if (inEType != 'A' && inEType != 'D')//checking invalid input or not
	{
		return 1;
	}

	evType = inEType;

	
	return 0;
}

int evnt::setTime(unsigned int incusArrTime)
{
	if (incusArrTime < 0)
	{
		return 1;
	}

	cusArrTime = incusArrTime;
	return 0;
}

int evnt::setTimeLen(unsigned int inLenOfTime)//checking the time in positive or not
{
	if (inLenOfTime < 0)
	{
		return 1;
	}
	
	lenOfTime = inLenOfTime;
	return 0;
}

