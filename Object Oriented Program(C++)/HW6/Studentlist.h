//Name: Sucharita Das
#ifndef STUDENTLIST_H
#define  STUDENTLIST_H
#include <string>
#include <iostream>
using namespace std;


template <typename DATA>
struct Node //Strauct Node
{
	DATA data, *next;

	// default constructor, constructor with args, and copy constructor for a node
	Node() : data(), next(NULL) { };
	Node(DATA newData, DATA *newPtr = NULL) : data(newData), next(newPtr) { }
	Node(Node<DATA> &aNode) : data(aNode.data), next(aNode.next) { }
	// we got copy constructors on copy constructors for days

  // destructor to obey the rule of three, but List will actually handle deallocation
	~Node();
	Node<DATA>& operator=(const Node &sNode);
};

template <typename DATA>
Node<DATA>::~Node()
{
	//empty
}

template <typename DATA>
Node<DATA>& Node<DATA>::operator=(const Node<DATA> &sNode)
{
	if (this == &sNode)
		return *this;
	data = sNode.data;
	next = sNode.next;
	return *this;
}

template <typename DATA>
class List
{
public:
	List();//default constructor
	List(int _size);
	List(const List<DATA> &v);//Copy constructor
	List& operator =(const List<DATA> &v);
	//List<T>& operator =(const List<T>& rightSide);
	~List(); //Destructor
	void clear();// Clear function
	void push_front(DATA data);//add node from front
	void push_back(DATA _data);//add node from back
	
	void pop_front() throw (int);//remove data from front
	void pop_back() throw (int);// remove dta from back

	DATA& at(int index) throw(int);
	void print(ostream &out);// print function
	DATA& operator[](int index) { return dynamicArray[index]; }
	

private:
	List<DATA> *headPtr;//
	
};
#endif