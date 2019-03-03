//Name: Sucharita Das
//Include the files

#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
#include <cstring>
#include "studentlist.h"
using std::string;
using namespace std;




template <typename DATA>
List<DATA>::List()
{
	size = 0; dynamicArray = nullptr;
}

template <typename DATA>
List<DATA>::List(const List<DATA> &v)
{
	int size;//deep copy	
	if (v.size > 0)
	{
		dynamicArray = new DATA[v.size];
		size = v.size;
		for (int i = 0; i < v.size; i++)
		{
			dynamicArray[i] = v.dynamicArray[i];
		}
	}
}

template <typename DATA>
List<DATA>& List<DATA>::operator =(const List<DATA> &v)
{
	//Delete anything that the object contains
	if (dynamicArray != nullptr)
		delete[] dynamicArray;

	//deep copy
	dynamicArray = new DATA[v.size];
	for (int i = 0; i < size; i++)
	{
		dynamicArray[i] = v.dynamicArray[i];
	}
	return *this;


}

template <typename DATA>
List<DATA>::List(int _size)
{
	size = _size;
	dynamicArray = new DATA[size];
}

template <typename DATA>
void List<DATA>::clear()
{
	while (headPtr != NULL)
	{
		pop_front();
	}
}

template <typename DATA>//destructor function
List<DATA>::~List()
{
	clear();
}

template <typename DATA>// push_front function
void List<DATA>::push_front(DATA data)// add node from front and the link to the next node
{
	cout << "\ninserting: " << _data << " to front.\n\n";
	if (headPtr= nullptr)
	{
		headPtr = new DATA();
		size++;
		headPtr[0] = _data;
	}
	else
	{
		DATA *temp = new t[size + 1];
		temp[0] = _data;
		for (int i = 0; i < size; i++)
		{
			temp[i + 1] = headPtr[i];
			cout << "temp array element " << i << " contains ";
			cout << temp[i] << endl;
			cout << "classArray array element " << i << " contains ";
			cout << headPtr[i] << endl << endl;
		}
		if (size < 2)
			delete classArray;
		else
			delete[] classArray;
		headPtr = temp;
		size++;
	}
}



template <typename DATA>//push_back function
void List<DATA>::push_back(DATA _data)
{
	if (dynamicArray == nullptr)
	{
		dynamicArray = new DATA();
		size++;//incresing size
		dynamicArray[0] = _data;
	}
	else
	{
		DATA *tempArray = new DATA[size + 1];
		for (int i = 0; i < size; i++)
		{
			tempArray[i] = dynamicArray[i];
		}
		tempArray[size] = _data;

		if (size < 2)
			delete dynamicArray;
		else
			delete[] dynamicArray;

		dynamicArray = tempArray;
		size++;//incresing size
		
	};
}

template <typename DATA>//Print function
void List<DATA>::print(ostream & out)
{
	//requires that we overload << for data type
	for (int i = 0; i < size; i++)
		out << dynamicArray[i] << endl;
}

template <typename DATA>
DATA& List<DATA>::at(int index) throw(int)// throw an exception 
{
	if (index >= size)
		throw 0;
	else if (index < 0)
		throw - 1;
	return dynamicArray[index];
}

template <typename DATA>//pop_front function
void List<DATA>::pop_front() throw(int)
{
	if (headPtr == NULL)
		throw (int e("Cannot pop an empty list.\n"));
	Node<DATA> *temp = headPtr->next;
	delete headPtr;
	headPtr = temp;// create a temporary node and the point to the next node and the then delete the previous one
}

template <typename DATA>//pop_back function
void List<DATA>::pop_back() throw(int)
{
	//check for a null headPtr
	if (headPtr == nullptr)
		throw 0;
	//create a pointer to move to the end

	else
	{
		size--;
		//Just a headpointer, so headPtr is null after delete
		if (headPtr->nextPtr == nullptr)
		{
			delete headPtr;
			headPtr = nullptr;
		}
		else
		{ /*Need to keep track of two pointers so when you delete the end
		  node you can set it to nullptr.*/
			Node<DATA> *endPtr = headPtr;
			Node<DATA> *prevPtr;
			while (endPtr->nextPtr != nullptr)
			{
				prevPtr = endPtr;
				endPtr = endPtr->nextPtr;
			} //while
			prevPtr->nextPtr = nullptr;
			delete endPtr;
		}//else
	}//else
}

