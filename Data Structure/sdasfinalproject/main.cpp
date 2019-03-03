#include "MenuDisplay.h"
int main() {

    //Start the menu system
    MenuDisplay menu(cin, cout);
    menu.loop();

    //Return a nominal status code
    return 0;
}