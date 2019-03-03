//Sucharita Das
//Data Structure Homework 6

#include "DicEntry.h"
using namespace std;

DicEntry::DicEntry() {}

wordType DicEntry::getaWord()
{
	return word;
}

void DicEntry::setaWord(wordType _Word)
{
	word = _Word;
}

bool compare(DicEntry& first, DicEntry& second) // boolean function to compair word and word and retun words
{
	return first.getaWord() < second.getaWord();
}

int findFront(list<DicEntry> &Listofwords, wordType &findString)
{
	// forward iterator
	list<DicEntry>::iterator fwd;

	bool isFound = false;
	int Cnt = 0;
	for (fwd = Listofwords.begin(); fwd != Listofwords.end(); ++fwd) {
		// increment the count for the current step taken
		Cnt += 1;

		// if we found the word break out of the loop
		if (fwd->getaWord() == findString) {
			isFound = true;
			break;
		}
	}
	if (isFound) return Cnt;
	else return -1;
}


void reverseList(ostream& output, list<DicEntry> &Listofwords)// print each word 
{
	list<DicEntry>::reverse_iterator r_it;
	for (r_it = Listofwords.rbegin(); r_it != Listofwords.rend(); ++r_it)
	{
		output << r_it->getaWord() << endl;
	}
}



bool operator <(const DicEntry& first, const DicEntry& second) //boolen function to overload the oparator
{
	return first.word < second.word;
}


//this is find from back function
int findEnd(list<DicEntry> &Listofwords, wordType &findString)
{
	list<DicEntry>::reverse_iterator r_it;
	bool isFound = false;
	int Cnt = 0;
	for (r_it = Listofwords.rbegin(); r_it != Listofwords.rend(); ++r_it) 
	{
		Cnt += 1;
		if (r_it->getaWord() == findString)
		{
			isFound = true;
			break;
		}
	}

	if (isFound) return Cnt;
	else return -1;
}
