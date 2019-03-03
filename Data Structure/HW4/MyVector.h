//Sucharita Das
//StudentId : 109103020
//CSCI: Data Structure
//HW4
#ifndef MYVECTOR_
#define MYVECTOR_

namespace HW4
{
    typedef int T;
    class MyVector //class name MyVector
    {
    private:
        int vsize = 0;
        T* vec = nullptr;
		T val;
		MyVector* begptr = nullptr;
		MyVector* nptr = nullptr;
    public:
        MyVector();
        T operator[] (int index);
        void pop_back();//pop_back function
        void push_back(T value); //push back function to enter data from back
        int size(); //returns the vector size
        bool empty();//determine if is empty
        int search(T Value);
        
        
    };
    
}//namespace
#endif

