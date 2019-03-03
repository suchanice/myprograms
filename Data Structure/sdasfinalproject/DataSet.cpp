
#include "DataSet.h"
// DataSet data structure with for column names from the top of the CSV
DataSet::DataSet(vector<string> titles, vector<unordered_map<string, string>> rawData) : titles(titles),rawData(rawData) {
    for (unsigned int i = 0; i < titles.size(); i++) {
        string titleToIndex = this->titles[i];
        auto *tree = new BSTree<unordered_map<string, string>, string>();
        for (unsigned int j = 0; j < rawData.size(); j++) {
            unordered_map<string, string> row = this->rawData[j];
            string key = row[titleToIndex];
            tree->addNode(key, row);
        }
        this->indexedData[titles[i]] = tree;
    }
}

ostream &operator<<(ostream &out, unordered_map<string, string> row) {
	unordered_map<string, string>::iterator it = row.begin();
	while (it != row.end()) {
		out << it->first << ": " << it->second << endl;
		it++;
	}
	return out;
}

ostream &operator<<(ostream &out, const GeneralData &data) {
	out << data.number << "\t" << data.name << endl;
	return out;
}

/*search for and return a row from the DataSet by selecting a binary search tree sorted by column rathar than cell */
unordered_map<string, string> DataSet::findByValue(string columnValue, string cellValue) {
    BSTree<unordered_map<string, string>, string> *t = this->indexedData[columnValue];
    if (t == nullptr) {
        throw runtime_error("no index on that column");
    }
    Node<unordered_map<string, string>, string> *n = t->findNode(cellValue);
    if (n != nullptr) return n->Data();
    throw runtime_error("no object found with that key/field combination");
};
// findByPartialValue methond to search for a row by searching for an exact match on a field
unordered_map<string, string> DataSet::findByPartialValue(string columnValue, string cellValue) {
    for (unsigned int i = 0; i<rawData.size(); i++) {
        unordered_map<string, string> row = this->rawData[i];
        if (row[columnValue].find(cellValue) !=  string::npos) {
            return row;
        }
    }
    throw runtime_error("No match found");
};

// Delete a row by field 
void DataSet::removeByValue(string columnValue, string cellValue) {
    BSTree<unordered_map<string, string>, string> *t = this->indexedData[columnValue];
    if (t == nullptr) throw runtime_error("no index on that column");
    Node<unordered_map<string, string>, string> *n = t->findNode(cellValue);
    if (n == nullptr) throw runtime_error("no object found with that key/field combination");

    unordered_map<string, string> row = n->Data();

    for (unsigned int i = 0; i < titles.size(); i++) {
        string titleToIndex = this->titles[i];

        BSTree<unordered_map<string, string>, string> *t = this->indexedData[titleToIndex];

        string key = row[titleToIndex];
        t->deleteNode(key);
    }
};

/* delete a row by searching for an exact match on a field then replace it  */
void DataSet::replaceByValue(string columnValue, string cellValue,unordered_map<string, string> row) {
    this->removeByValue(columnValue, cellValue);
    this->add(row);
}

//print function
void DataSet::printInOrderBy(string key) {
    this->indexedData[key]->printInorder();
}

 // insert a single row into the DataSet
void DataSet::add(unordered_map<string, string> row) {
    for (unsigned int i = 0; i < titles.size(); i++) {
        string titleToIndex = this->titles[i];
        if (row.find(titleToIndex) == row.end()) {
            throw runtime_error("cannot add row to DataSet; it is missing columns");
        }
    }
    rawData.push_back(row);
    for (unsigned int i = 0; i < titles.size(); i++) {
        string titleToIndex = this->titles[i];

        BSTree<unordered_map<string, string>, string> *t = this->indexedData[titleToIndex];
        if (t == nullptr) throw runtime_error("no index on that column");

        string key = row[titleToIndex];
        t->addNode(key, row);
    }
}

//return titles
const vector<string> &DataSet::getTitles() const {
    return titles;
}

// write a DataSet to a CSV output stream
void DataSet::writeDataSet(ostream &out) {
    writeMapsAsCsv(out, this->getTitles(), this->rawData);
}

//calling the write data screen function through write data
void DataSet::writedata() {
	writedatascreen( this->getTitles(), this->rawData);
}
//read a DataSet from a CSV input stream
DataSet readDataSet(istream &in) {
    pair<vector<string>, vector<unordered_map<string, string>>> result = csvreadfunction(in);
    vector<string> titles = result.first;
    vector<unordered_map<string, string>> dataSet = result.second;
    return DataSet(titles, dataSet);
}