//Name: Sucharita Das
//Include the files
#ifndef FUNCTION_H
#define FUNCTION_H
#include <iostream>
#include <string>

using namespace std;
class Animal//paraent class
{
private://member declaration
	
	int weight;
	int height;
	
	string name;
	string color;
	int age;
	
	
public:
	Animal(); //Default constructor
	Animal(int age, int weight, int height, string color, string name, string breed);//Constructor
	 //all functions
	string getName();
	void  setName(string newName);
		
		
		string getColor() ;
		void setColor(string newColor);
		int getAge();
		void setAge(int newAge);

		virtual void print() 
		{
			cout << "Name : " << name;

			cout << "Color : " << color;

		};
};

//Derived class Dog...............................................
class Dog : public Animal
{
private://variables
	string breed;
	int weight, newAge;

public:
	//all functions
	 void subtract10(int weight) { };
	 int getubtract10();
	 void setubtract10(int newWeight);
	 string getBreed();
	 void  setBreed(string newBreed);
	 void print();
	 
};

//Derived class Fish.........................................................
class Fish : public Animal
{
private://variables
	string habitat;
	string freshwater;
	string Predator;
public:
	//all functions
	string getHabitat();
	void setHabitat(string newHabitat);
	string getFreshwater();
	void setFreshwater(string newFreshwater);
	string getPredator();
	void setPredator(string newPredator);
	 
    void print();
};

//Derived class Horse................................................................
class Horse : public Animal
{
private://variables
	int height;
	string maneColor;
public://all functions
	int getHeight() {};
	void setHeight(int newHeight);
	string getManeColor();
	void setManeColor(string newManeColor);
	void setadd1(int height);
	int getadd1();
	
	void print();
};

//Derived class Monkey...................................................
class Monkey : public Animal
{private://variables
	string wild;
	string home;
	string endangered;
public://all functions
	string getWild();
	void setWild(string newWild);
	string gethome();
	void sethome(string newhome);
	void setchangeEndangered(string newEndangered);
	string getchangeEndangered() ;
	
	void print();
};

//Derived class Lizard.............................................
class Lizard : public Animal
{
public://variables
	string habitat;
	int weight;
	string Protected;
public://all functions
	string getHabitat();
	void setHabitat(string newHabitat);
	int getWeight();
	void setWeight(int newWeight);
	string getProtected();
	void setProtected(string newProtected);
	void print();
};
#endif