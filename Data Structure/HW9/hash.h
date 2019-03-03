//Sucharita Das
//HW9
//SellingCheck function

//Declearing all library

#ifndef _HASH_H
#define _HASH_H

#include <vector>
#include <string>

class hashTable {

public:
	hashTable(int size = 0);
	int insert(const std::string &key, void *pv = NULL);

	
	// If so, return true; otherwise, return false.
	bool contains(const std::string &key);


private:


	
	class hashItem //class declearation 
	{
	public:
		std::string key;
		bool booked;//boolean function
		bool deletefun;
		void *pv;//pointed to pv
	};

	int capacity; 
	int filled; // Number of occupied items in the table.
	// Uses a precomputed sequence of selected prime numbers.
	static unsigned int PrimeNum(int size);
	// The hash function.
	int hash(const std::string &key);
	// Returns true on success, false if memory allocation fails.
	bool rehash();
	// Return the position if found, -1 otherwise.
	int findPosition(const std::string &key);
	std::vector<hashItem> data; // The actual entries are here.
		
};

#endif 