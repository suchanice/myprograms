//Sucharita Das
//Data Structure Homework 6

#ifndef DicEntry_h
#define DicEntry_h
#include <string>
#include <list>
#include <iostream>

using namespace std;
typedef string wordType;

class DicEntry
{
private:
	wordType word;
	wordType defn;  //setting definition

public:
	// typedef string wordType;
	DicEntry();
	wordType getaWord();
	// return word
	void setaWord(wordType _word);
//	{ word = _word; };
	friend bool operator <(const DicEntry& first, const DicEntry& second);
	//return word < entry.word

};
void reverseList(ostream& output, list<DicEntry> &Listofwords);//resurve list function 

bool compare(DicEntry& first, DicEntry& second);//this is for compair the words

int findFront(list<DicEntry> &Listofwords, wordType &findString);//This is find forword function

int findEnd(list<DicEntry> &Listofwords, wordType &findString);// this is find from back function



#endif