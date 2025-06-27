//#include "../include/header.h"
#include <iostream>
#include <mysql/mysql.h>
// function to display rec from database named tflstudent

void displayTopics(){
            MYSQL_RES *res;
            MYSQL_ROW row;

            // Execute SQL query to select all topics
            if (mysql_query(conn, "SELECT * FROM student")) {
                cerr << "SELECT * FROM student failed. Error: " << mysql_error(conn) << "\n";
                return;
            }

            // Store the result set
            res = mysql_store_result(conn);
            if (res == NULL) {
                cerr << "mysql_store_result() failed. Error: " << mysql_error(conn) << "\n";
                return;
            }

            // Fetch and display each row
            while ((row = mysql_fetch_row(res)) != NULL) {
                cout << "ID: " << row[0] << ", Title: " << row[1] << ", URL: " << row[2] << "\n";
            }

            // Clean up
            mysql_free_result(res);

        }