// utility functions for reading CSV functions to/from vectors of unordered maps
#include "DataSet.h"
//*Reads csv file as a unordered_map object for each row
//return a vector in which each entry is a unordered_map representing the row from the csv

pair<vector<string>, vector<unordered_map<string, string>>> csvreadfunction(istream &in) {
       //Reading the titles is a special case; the first row isn't treated the same as the other rows
    //1. Read the whole title line
    vector<string> titles;
    string titleLine;
    getline(in, titleLine);

    //2. Read each comma-separated value within that title line as a single title
    istringstream titleStream(titleLine);
    do {
        string title;
        getline(titleStream, title, ',');
        titles.push_back(title);
    } while (!titleStream.eof());

    //Instantiate the DataSet object we're going to return
    vector<unordered_map<string, string>> DataSet;


    //Rows starts
    while (!in.eof()) {
        // 1. Read the entire row
        string line;
        getline(in, line);
        istringstream lineStream(line);

        // 2. Instantiate a unordered_map to store the row's contents (this is the part inspired by JSON objects)
        unordered_map<string, string> row;

        // 3. Read each comma-separated value within that row as a single field value where the key is given by the column header
        unsigned int i = 0;
        do {
            string cell;
            if (lineStream.peek() == '"') {
                while (lineStream.peek() == '"') {
                    lineStream.ignore();
                    string temp;
                    getline(lineStream, temp, '"');

                    cell += temp;
                    if (lineStream.peek() != '"') {
                        lineStream.ignore();
                    } else {
                        cell += "\"";
                    }
                }
            } else {
                getline(lineStream, cell, ',');
            }

            if (i >= titles.size()) {
                throw runtime_error("wrogly formatted csv!!");
            }
            row[titles[i]] = cell;
            i++;
        } while (!lineStream.eof());

        DataSet.push_back(row);
    }

    return pair<vector<string>, vector<unordered_map<string, string>>>(titles, DataSet);
};


// outputs a CSV cell to a write stream

void outputCell(ostream &out, string cell) {
    bool wrap = false;
    if (cell.find(",") != std::string::npos) wrap = true;
    if (cell.find("\"") != std::string::npos) wrap = true;

    if (wrap) out << "\"";
    out << cell;
    if (wrap) out << "\"";
}

// writes every row of a csv file as a unordered_map object where the keys are the header cells and values

void writeMapsAsCsv(ostream &out, vector<string> titles, vector<unordered_map<string, string>> DataSet) {
    //1. Write the titles
    for (unsigned int i = 0; i < titles.size(); i++) {
        outputCell(out, titles[i]);
        if (i < titles.size() - 1) out << ",";
    }
    cout << endl;
    //2. Write the rows
    for (unsigned int j = 0; j < DataSet.size(); j++) {
        unordered_map<string, string> row = DataSet[j];
        for (unsigned int i = 0; i < titles.size(); i++) {
            outputCell(out, row[titles[i]]);
            if (i < titles.size() - 1) out << ",";
			cout << row[titles[i]];
			if (i < titles.size() - 1) out << ",";
			cout << ",";
        }
        out << endl;
		cout << endl;
    }
}

void writedatascreen( vector<string> titles, vector<unordered_map<string, string>> DataSet) {
	int reccount;
	int reccount1=0;
	string opt = "Y";
	cout <<"File may be too large, provide number of records you want to see it in one shot...."<<endl;
	cin >> reccount;
	for (unsigned int i = 0; i < DataSet.size(); i++)
	{
		if (reccount1 <= DataSet.size())
		{
			cout << "Do you want to continue ? Enter Y/N : ";
			cin >> opt;
			cout << endl;
			if (opt == "Y" || opt == "y")
			{
				//1. Write the titles
				for (unsigned int i = 0; i < titles.size(); i++) {
					//outputCell(out, titles[i]);
					if (i < titles.size() - 1)
					{
						cout << titles[i];
						cout << ",";
					}
				}
				cout << endl;
				//2. Write the rows
			//	for (unsigned int j = 0; j < DataSet.size(); j++) {
				for (int j = reccount1; j < reccount + reccount1; j++) {
					unordered_map<string, string> row = DataSet[j];
					for (unsigned int i = 0; i < titles.size(); i++) {
						//	outputCell(out, row[titles[i]]);
						if (i < titles.size() - 1)
							cout << row[titles[i]];
						if (i < titles.size() - 1)
							cout << ",";
					}
					cout << endl;

				}
			 reccount1 = reccount1 + reccount;

			}
			else
			{
				cout << "Exiting !!!" << endl;
				break;
			}
		}
	}
}
