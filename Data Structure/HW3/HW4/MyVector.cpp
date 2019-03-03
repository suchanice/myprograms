//Sucharita Das
//StudentId : 109103020
//CSCI: Data Structure
//HW4
#include <iostream>
#include "MyVector.h"
using namespace std;
namespace HW4 {



	MyVector::MyVector()
	{
		//Default constructor return 0

		vsize = 0;

	}
	//A simple function to check the vector size.
	int MyVector::size()
	{

		return vsize;
	}


	//Removes the last element in the vector, effectively reducing the container size by one.
	void MyVector::pop_back()
	{
		MyVector* cur = begptr;
		MyVector* prev = nullptr;
		while (cur->nptr) //crawl the list until we can see the end at current->nextPtr
		{
			prev = cur;
			cur = cur->nptr;
		}

		if (prev) //just in case there was only one element
			prev->nptr = nullptr; //make sure the new end of the list points to nullptr

		delete cur; //delete what current points at, the last element
		vsize--;
	

	}

	//boolean function to check whether the vector is empty or not. If empty then returns True, else it returns false.
	bool MyVector::empty()
	{
		if (vsize != 0)
		{
			//cout << "The vector is not empty" << endl;
			return false;
		}
		else
		{
			//cout << "The vector is empty" << endl;
			return true;
		}

	}

	// Access element : Returns a reference to the element at position [index] in the vector container vec.
	T MyVector::operator[] (int index)
	{
		MyVector* cur = begptr;
		for (int i = 0; i < index; i++)
		{
			if (cur->nptr) //if nptr isn't null, we aren't at the end
				cur = cur->nptr;
		}

		return cur->val; //return what we found at the ith position
	
	}
	//Adds a new element at the end of the vector, after its current last element.
	void MyVector::push_back(T value)
	{

		

		MyVector* cur = begptr;
		MyVector* previous = nullptr;

		if (empty())
		{
			begptr = new MyVector;
			begptr->val = value;
			vsize++;
			return;
		}

		else
		{
			MyVector* cur = begptr;
			while (cur->nptr) //crawl to the end of the list
				cur = cur->nptr;
			cur->nptr = new MyVector;
			cur->nptr->val = value;
			vsize++;
			return;
		}
	
	}




	//Search for an element in a vector and returns the position
	int MyVector::search(T Value)
	{
		MyVector* cur = begptr;
		int i = 0;
		while (cur)
		{
			if (cur->val == Value)
				return i;
			cur = cur->nptr;
			i++;
		}
		return -1;

	}
}