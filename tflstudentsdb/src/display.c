#include <stdio.h>
#include <mysql.h>

// Function to display records from the 'student' table
void displayTopics() {
    MYSQL_RES *res;
    MYSQL_ROW row;

    // Execute SQL query
    if (mysql_query(conn, "SELECT * FROM student")) {
        fprintf(stderr, "SELECT * FROM student failed. Error: %s\n", mysql_error(conn));
        return;
    }

    // Store the result set
    res = mysql_store_result(conn);
    if (res == NULL) {
        fprintf(stderr, "mysql_store_result() failed. Error: %s\n", mysql_error(conn));
        return;
    }

    // Fetch and display each row
    while ((row = mysql_fetch_row(res)) != NULL) {
        printf("ID: %s, Title: %s, URL: %s\n", row[0], row[1], row[2]);
    }

    // Clean up
    mysql_free_result(res);
}
