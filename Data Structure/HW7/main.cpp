//Sucharita Das
//HW7
//Include all header file
#include <iostream>
#include <fstream>
#include <string>
#include "event.h"
#include "queue.h"
#include "priorityqueue.h"
using namespace std;

void loadInputIntoPQ(prityQue &inPQ)
{
	
	unsigned int ttTime,ttTime1, ttTime2, ttTime3;
	unsigned int ttLength,ttLength1, ttLength2, ttLength3 ;//variables for length
	string fileName,fileName1, fileName2, fileName3;//variables for file input
	ifstream fin,fin1, fin2, fin3;
	std::ofstream combined_file("combined_file.txt");
	cout << "Enter file name for Teller 1: ";
	getline(cin, fileName1);//geting the file name from user
	fin1.open(fileName1.c_str());//opening the txt file
	cout << "Enter file name for Teller 2: ";
	getline(cin, fileName2); // geting the file name from user
	fin2.open(fileName2.c_str());//opening the file
	cout << "Enterthe file name for Teller 3: ";
	getline(cin, fileName3);//geting the file name from user
	fin3.open(fileName3.c_str());// opening the file

	while (fin1 >> ttTime1 >> ttLength1)
	{
		
		evnt tmpEvent1(ttTime1, ttLength1);
		inPQ.enque(tmpEvent1);	//Function call 
	}

	
	while (fin2 >> ttTime2 >> ttLength2)
	{
		
		evnt tmpEvent2(ttTime2, ttLength2);
		inPQ.enque(tmpEvent2);//Function call
	}
	
	while (fin3 >> ttTime3 >> ttLength3)
	{
		
		evnt tmpEvent3(ttTime3, ttLength3);
		inPQ.enque(tmpEvent3);//Function call 
	}
}

int main(void)
{
	
	que mybankQueue;//Createing  instance
	prityQue eventListPQ;
	bool istellerAvailable = true;//for boolean value
	loadInputIntoPQ(eventListPQ);//to load input 
	unsigned int deptTimeTotal = 0;//Declare a variable for departure
	unsigned int processesTimeTotal = 0;
	unsigned int arrTimeTotal = 0;
	unsigned int evCounter = 0;
	float evwaitTime;//for waiting time
	cout << endl << "Simulation Begins" << endl;
	while (!eventListPQ.isemty())
	{
		evnt newerEvent = eventListPQ.qumethod();
		unsigned int preTime = newerEvent.gettime();//for present time
		if (newerEvent.getEvType() == 'A')
		{
			eventListPQ.deQu();
			evnt bankCust = newerEvent;
			if (mybankQueue.isemty() && istellerAvailable)
			{
				unsigned int deptTime = preTime + bankCust.getTimeLen();
				evnt newDepartureEvent('D', deptTime, 0);//new departure time
				eventListPQ.enque(newDepartureEvent);
				istellerAvailable = false;//boolean value
			}
			else
			{
				mybankQueue.enque(bankCust);//Function call 
			}
		
			cout << "Processing an arrival event at time:\t" << bankCust.gettime() << endl;
			evCounter++;
			arrTimeTotal += bankCust.gettime();//arival total time
			processesTimeTotal += bankCust.getTimeLen();
		}
		
		else
		{
			eventListPQ.deQu();//function call
			if (!mybankQueue.isemty())
			{
				evnt bankCust = mybankQueue.qumethod();
				mybankQueue.deQu();//function call for dequeue
				unsigned int deptTime = preTime + bankCust.getTimeLen();
				evnt newDepartureEvent('D', deptTime, 0);//new departue time
				eventListPQ.enque(newDepartureEvent);
			}
			
			else
			{
				istellerAvailable = true;
			}
			
			cout << "Processing a departure event at time:\t" << preTime << endl;
		
			deptTimeTotal += preTime;
		}
	}
	evwaitTime = (float)(deptTimeTotal - processesTimeTotal - arrTimeTotal) / evCounter;
	
	cout << "Simulation Ends" << endl << endl;
	cout << "Final Statistics:" << endl;
	cout << "\tTotal number of people processed: " << evCounter << endl;
	cout << "\tAverage amount of time spent waiting: " << evwaitTime << endl;
	cin.get(); cin.get();
	return 0;//ending the program
}