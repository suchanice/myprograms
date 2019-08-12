package stack

//import "errors"

type Stack []interface{}

func New() Stack {
	return make(Stack, 0)
}

func (this *Stack) IsEmpty() bool {
	return len(*this) == 0
}

func (this *Stack) Push(v interface{}) error {
	*this = append(*this, v)
	return nil
}

func (this *Stack) Pop() (interface{}) {
    if len(*this) == 0 {
		return nil
	}
	v := (*this)[len(*this)-1]
	*this = (*this)[:len(*this)-1]
	return v
}

func (this *Stack) Top() (interface{}) {
	if len(*this) == 0 {
		return nil
	}
	return (*this)[len(*this)-1]
}
