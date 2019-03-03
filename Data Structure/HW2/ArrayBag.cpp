/** @file ArrayBag.cpp */
//Sucahrita Das
#include "ArrayBag.h"


ArrayBag::ArrayBag() : itemCount(0), maxItems(DEFAULT_BAG_SIZE)
{
} // This function is for default constructor


int ArrayBag::getCurrentSize() const
{
	return itemCount;
} // This function is for  getCurrentSize


bool ArrayBag::isEmpty() const
{
	return itemCount == 0;
} // This function is for  isEmpty


bool ArrayBag::addition(const ItemType& newEntry)
{
	bool hasRoomToAdd = (itemCount < maxItems);
	if (hasRoomToAdd)
	{
		items[itemCount] = newEntry;
		itemCount++;
	} 

	return hasRoomToAdd;
} // This function is for addition


bool ArrayBag::remove(const ItemType& anEntry)
{
	int locatedIndex = getIndexOf(anEntry);
	bool canRemoveItem = !isEmpty() && (locatedIndex > -1);
	if (canRemoveItem)
	{
		itemCount--;
		items[locatedIndex] = items[itemCount];
	} // This function is for  if

	return canRemoveItem;
} // This function is for  remove


void ArrayBag::clear()
{
	itemCount = 0;
} // This function is for  clear


int ArrayBag::getFrequencyOf(const ItemType& anEntry) const
{
	int frequency = 0;
	int searchIndex = 0;
	while (searchIndex < itemCount)
	{
		if (items[searchIndex] == anEntry)
		{
			frequency++;
		} 

		searchIndex++;
	} 

	return frequency;
} // This function is for  getFrequencyOf


bool ArrayBag::contains(const ItemType& anEntry) const
{
	return getIndexOf(anEntry) > -1;
} // This function is for  contains

std::vector<ItemType> ArrayBag::IntVector() const
{
	std::vector<ItemType> ArrayBagContents;
	for (int i = 0; i < itemCount; i++)
		ArrayBagContents.push_back(items[i]);
	return ArrayBagContents;
} //This function is for  IntVector

  // private

int ArrayBag::getIndexOf(const ItemType& target) const
{
	bool found = false;
	int result = -1;
	int searchIndex = 0;
	while (!found && (searchIndex < itemCount))
	{
		if (items[searchIndex] == target)
		{
			found = true;
			result = searchIndex;
		}
		else
		{
			searchIndex++;
		} 
	} 

	return result;
} // This function is for  getIndexOf



int ArrayBag::TotalSize() const
{
	return maxItems;
}
// Totalsize function to return maximum items 

const int ArrayBag::operator[](const int index) const
{
	return items[index];
}//This function is for operator overloading

int ArrayBag::operator[](const int index)
{
	return items[index];
} // This function is for operator overloading

