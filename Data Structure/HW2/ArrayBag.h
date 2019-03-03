//Sucahrita Das
/** ADT bag: Array-based implementation.
@file ArrayBag.h */


#ifndef BAG_
#define BAG_

#include <vector>

typedef int ItemType;
class ArrayBag
{
private:
	static const int DEFAULT_BAG_SIZE = 100;
	ItemType items[DEFAULT_BAG_SIZE]; // array of bag items
	int itemCount;                    // current count of bag items
	int maxItems;                     // max capacity of the bag

									  // Returns either the index of the element in the array items that
									  // contains the given target or -1, if the array does not contain
									  // the target.
	int getIndexOf(const ItemType& target) const;

public:
	ArrayBag();
	
	int getCurrentSize() const;
	std::vector<ItemType> IntVector() const;
	bool isEmpty() const;
	bool addition(const ItemType& newEntry);
	bool remove(const ItemType& anEntry);
	int TotalSize() const;
	void clear();
	bool contains(const ItemType& anEntry) const;
	int getFrequencyOf(const ItemType& anEntry) const;
	const int operator[](const int index) const;
	int operator[](const int index);
}; // end Bag


#endif
