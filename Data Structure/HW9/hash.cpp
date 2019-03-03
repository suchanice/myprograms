//Sucharita Das
//HW9
//SellingCheck function
//Declearing all library

#include <iostream> 
#include <vector>
#include <string>
#include <exception>
#include "hash.h" //.h file declearation

using namespace std;

#define HASH_PRIME 101





hashTable::hashTable(int size) // The constructor initializes the hash table.
{
	capacity = PrimeNum(size);
	data.resize(capacity);
	for (int i = 0; i < data.size(); i++)
	{
		data[i].deletefun = false;
		data[i].booked = false;
	}
	filled = 0;
}


bool hashTable::contains(const string &key)// Check if the specified key is in the hash table.
{

	int i = findPosition(key);
	if (i == -1)
		return false;
	else
		return true;
}


int hashTable::findPosition(const string &key)// Search for an item with the specified key.
{

		
	int i = hash(key) % capacity;//hash key and its capasity

	while (data[i].booked == true) 
	{
		if ((data[i].key == key) && (data[i].deletefun == false))
			return i;

		i++;
	}

	return -1;//return
}


bool hashTable::rehash()// The rehash function; makes the hash table bigger.
{

	try {
		vector<hashItem> tmp = data; //using vector to store data temporaryly
		capacity = PrimeNum(capacity);
		filled = 0;
		data.clear();//clear the data
		data.resize(capacity);//resize the capacity
		for (int i = 0; i < tmp.size(); i++) 
		{
			if ((tmp[i].booked == true) && (tmp[i].deletefun == false))//boolean function
				insert(tmp[i].key, NULL);
		}

		return true;//return boolean
	}
	catch (exception& e) //catch the exception
	{
		cerr << "Resize failed: " << e.what() << endl;// resize failed
		return false;
	}
}

int hashTable::hash(const string &key) // The current capacity of the hash table.
{
	int hash = 0;
	unsigned int i = 0;

	for (i = 0; i < key.size(); i++)
		hash = hash * HASH_PRIME + key[i];

	hash %= capacity;
	if (hash < 0)
		hash += capacity;

	return hash;
}



unsigned int hashTable::PrimeNum(int size) // Return a prime number at least as large as size.
{

	
	int primeslist[] = { 73, 607, 2221, 10103, 60251, 100109, 104729, 100003, 2000009, 122949829, 472882049, 961748941 };//prime list

	int i = 0;

	while (primeslist[i] <= size)
		i++;

	return primeslist[i];//return primelist of the file
}

int hashTable::insert(const string &key, void *pv) 	// Insert the specified key into the hash table.
{

	if (filled > (capacity / 2))
	{
		if (rehash())
			return 0;
		else
			return 2;
	}

	if (contains(key) == true)
		return 1;

	int i = hash(key) % capacity;
	if (i < 0)
		i += capacity;

	while (data[i].booked == true)
	{
		i++;
		i %= capacity;
	}

	if ((data[i].booked == false) || (data[i].deletefun == true)) //compairing
	{
		data[i].key = key;
		data[i].booked = true;
		data[i].deletefun = false;
		data[i].pv = pv;
		filled++;
		return 0;
	}

	return -1;
}

