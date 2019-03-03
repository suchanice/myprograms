#include "MenuDisplay.h"
/*Initial Constructor*/
MenuDisplay::MenuDisplay(istream &in, ostream &out) : in(in), out(out) {
    this->DataSetNames.push_back("Actors File");
    this->DataSetNames.push_back("Pictures File");
    this->DataSetNames.push_back("Nominations File");
}
// Boolean declaration and the menu display
bool MenuDisplay::rootMenu() {
    this->out << "===================Menu System===================" << endl;
    this->out << "Make sure to use option 1 or option 2 to load before attempting to view/modify data." << endl;
    this->out << "1. Load ALL CSV files (it might take up to 3 min)" << endl;
	this->out << "2. Display Records" << endl;
    this->out << "3. Add a record" << endl;
    this->out << "4. Find a record (by exact value)" << endl;
    this->out << "5. Modify a record" << endl;
    this->out << "6. Delete a record" << endl;
    this->out << "7. Sort records by field" << endl;
    this->out << "8. Search for a records (by partial match)" << endl;
    this->out << "9. Write to CSV file" << endl;
    this->out << "q. Exit" << endl;
    this->out << endl;
    this->out << "Select one of the options above using its number." << endl;
    this->out << "> ";

    char selection;
    this->in >> selection;
//switch statement to select multiple selection
    switch (selection) {
        case '1':
            this->loadfiles();
            break;
		case '2':
			this->displaydata();
			break;
         case '3':
            this->addrecord();
            break;
        case '4':
            this->findrecord();
            break;
        case '5':
            this->modifyrecord();
            break;
        case '6':
            this->deleterecord();
            break;
        case '7':
            this->sortrecord();
            break;
        case '8':
            this->partialsearchrecord();
            break;
        case '9':
            this->writerecord();
            break;
        case 'q':
            this->out << "Thank you! Exiting !!" << endl;
            return false;
        default:
            this->out << "Sorry. That selection (" << selection
                      << ") isn't valid. Please pick one of the numbers from the menu." << endl;
    }

    return true;
}

//looping though main menu
void MenuDisplay::loop() {
    while (rootMenu());
}

//method to load the csv
void MenuDisplay::loadfromcsv(string name, string path) {
    bool valid = false;
    for (unsigned int i = 0; i < this->DataSetNames.size(); i++) {
        if (DataSetNames[i] == name) valid = true;
    }
    if (!valid) {
        this->out << "Not a valid DataSet!" << endl;
        return;
    }

    try {
        ifstream in;
        in.open(path);
        db[name] = readDataSet(in);
        in.close();
    } catch (runtime_error e) {
        this->out << "Wrong format of the file!" << endl;
        this->out << e.what();
    }
}

//method to select DataSet used by menu display
string MenuDisplay::selectDataSet() {
    string name;
    bool valid = false;
    while (!valid) {
        this->out << "DataSet name is (use exact name) : " << endl;
        this->out << "Valid selections: ";
        for (unsigned int i = 0; i < this->DataSetNames.size(); i++) {
            this->out << DataSetNames[i];
            if (i < this->DataSetNames.size() - 1) this->out << ", ";
        }
        this->out << endl;
        this->out << "> ";
        getline(this->in, name);

        for (unsigned int i = 0; i < this->DataSetNames.size(); i++) {
            if (DataSetNames[i] == name) valid = true;
        }
    }
    return name;
}

//print row for DataSet names
void MenuDisplay::printRow(vector<string> titles, unordered_map<string, string> row) {
    for (unsigned int i = 0; i < titles.size(); i++) {
        string title = titles[i];
        this->out << title << ": " << row[title] << endl;
    }
}

const unordered_map<string, DataSet> &MenuDisplay::getDb() const {
    return db;
}

//load the file as per selection
void MenuDisplay::loadfiles() {
    loadfromcsv("Actors File", "actor-actress.csv");
	cout << "Actors file got loaded !" << endl;
    loadfromcsv("Pictures File", "pictures.csv");
	cout << "Pictures file got loaded !" << endl;
	cout << "Please wait until the Nomination file is loaded..it is a bigger file, might take 2-3 min..please be patient !" << endl;
    loadfromcsv("Nominations File", "nominations.csv");
	cout << "Nominations file got loaded !" << endl;
}

//adding a record
void MenuDisplay::addrecord() {
    this->in.ignore();
    string DataSetName = this->selectDataSet();
    DataSet DataSet = db[DataSetName];
    vector<string> DataSetTitles = DataSet.getTitles();
    unordered_map<string, string> row;
    for (unsigned int i = 0; i < DataSetTitles.size(); i++) {
        string title = DataSetTitles[i];
        this->out << "Enter data for \"" << title << "\"" << endl;
        this->out << "> ";
        string value;
        getline(this->in, value);
        row[title] = value;
    }
    DataSet.add(row);
    this->out << "Entry added !" << endl;
}

//method to find a record as per selection
void MenuDisplay::findrecord() {
    this->in.ignore();
    string DataSetName = this->selectDataSet();
    this->out << "Enter field name for search !" << endl;
    this->out << "Valid fields: ";
    DataSet DataSet = db[DataSetName];
    vector<string> DataSetTitles = DataSet.getTitles();
    for (unsigned int i = 0; i < DataSetTitles.size(); i++) {
        string title = DataSetTitles[i];
        this->out << title;
        if (i < DataSetTitles.size() - 1) this->out << ", ";
    }
    this->out << endl;
    this->out << "> ";
    string title;
    getline(this->in, title);
    this->out << "Enter the details you are searching : " << endl;
    this->out << "> ";
    string value;
    getline(this->in, value);
    try {
        unordered_map<string, string> result = DataSet.findByValue(title, value);

        this->out << "The entry is : " << endl;
        this->printRow(DataSetTitles, result);
    } catch (runtime_error e) {
        this->out << "Sorry,  nothing is found with this search criteria !!" << endl;
    }
}

//Modify method as per the search
void MenuDisplay::modifyrecord() {
    this->in.ignore();
    string DataSetName = this->selectDataSet();

    this->out << "Enter field name for search !" << endl;
    this->out << "Valid fields: ";
    DataSet DataSet = db[DataSetName];
    vector<string> DataSetTitles = DataSet.getTitles();
    for (unsigned int i = 0; i < DataSetTitles.size(); i++) {
        string title = DataSetTitles[i];
        this->out << title;
        if (i < DataSetTitles.size() - 1) this->out << ", ";
    }
    this->out << endl;
    this->out << "> ";
    string title;
    getline(this->in, title);
    this->out << "What value are you searching for?" << endl;
    this->out << "> ";
    string value;
    getline(this->in, value);

    try {
        unordered_map<string, string> result = DataSet.findByValue(title, value);

        this->out << "Found the following entry: " << endl;
        this->printRow(DataSetTitles, result);

        unordered_map<string, string> row;
        for (unsigned int i = 0; i < DataSetTitles.size(); i++) {
            string title = DataSetTitles[i];
            this->out << "Please enter a value for \"" << title << "\"" << endl;
            this->out << "> ";

            string value;
            getline(this->in, value);

            row[title] = value;
        }

        DataSet.replaceByValue(title, value, row);

        this->out << "Successfully modified entry." << endl;
    } catch (runtime_error e) {
        this->out << "Sorry, we couldn't find anything matching those criteria." << endl;
    }
}

//delete a record
void MenuDisplay::deleterecord() {
    this->in.ignore();
    string DataSetName = this->selectDataSet();

    this->out << "Enter the field name for search !" << endl;
    this->out << "Valid fields: ";
    DataSet DataSet = db[DataSetName];
    vector<string> DataSetTitles = DataSet.getTitles();
    for (unsigned int i = 0; i < DataSetTitles.size(); i++) {
        string title = DataSetTitles[i];
        this->out << title;
        if (i < DataSetTitles.size() - 1) this->out << ", ";
    }
    this->out << endl;
    this->out << "> ";

    string title;
    getline(this->in, title);

    this->out << "What value are you searching for?" << endl;
    this->out << "> ";

    string value;
    getline(this->in, value);

    try {
        DataSet.removeByValue(title, value);

        this->out << "Successfully removed entry." << endl;
    } catch (runtime_error e) {
        this->out << "Sorry, we couldn't find anything matching those criteria." << endl;
    }
}
//sort records as per search
void MenuDisplay::sortrecord() {
    this->in.ignore();
    string DataSetName = this->selectDataSet();

    this->out << "Enter the field name for search !" << endl;
    this->out << "Valid fields: ";
    DataSet DataSet = db[DataSetName];
    vector<string> DataSetTitles = DataSet.getTitles();
    for (unsigned int i = 0; i < DataSetTitles.size(); i++) {
        string title = DataSetTitles[i];
        this->out << title;
        if (i < DataSetTitles.size() - 1) this->out << ", ";
    }
    this->out << endl;
    this->out << "> ";

    string title;
    getline(this->in, title);

    try {
        DataSet.printInOrderBy(title);
    } catch (runtime_error e) {
        this->out << "Sorry, no column by that name was found." << endl;
    }
}

//from DataSet name, do partial search
void MenuDisplay::partialsearchrecord() {
    this->in.ignore();
    string DataSetName = this->selectDataSet();
    this->out << "Enter the field name for search !" << endl;
    this->out << "Valid fields: ";
    DataSet DataSet = db[DataSetName];
    vector<string> DataSetTitles = DataSet.getTitles();
    for (unsigned int i = 0; i < DataSetTitles.size(); i++) {
        string title = DataSetTitles[i];
        this->out << title;
        if (i < DataSetTitles.size() - 1) this->out << ", ";
    }
    this->out << endl;
    this->out << "> ";
    string title;
    getline(this->in, title);
    this->out << "What value are you searching for?" << endl;
    this->out << "> ";
    string value;
    getline(this->in, value);

    try {
        unordered_map<string, string> result = DataSet.findByPartialValue(title, value);
        this->out << "Found the following entry: " << endl;
        this->printRow(DataSetTitles, result);
    } catch (runtime_error e) {
        this->out << "Sorry, we couldn't find anything matching those criteria." << endl;
    }
}
//write the DataSet in a file as per selection
void MenuDisplay::writerecord() {
    this->in.ignore();
    string DataSetName = this->selectDataSet();
    DataSet DataSet = db[DataSetName];
    this->out << "Please provide the path" << endl;
    this->out << "> ";
    string path;
    getline(this->in, path);
	ofstream out;
    out.open(path);
	DataSet.writeDataSet(out);
	out.close();
}
//display data method, a certain numbers at a time as per selection
void MenuDisplay::displaydata() {
	this->in.ignore();
	string DataSetName = this->selectDataSet();
	DataSet DataSet = db[DataSetName];
	DataSet.writedata();
}