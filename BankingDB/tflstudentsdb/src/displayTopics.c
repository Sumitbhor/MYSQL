#include "../include/header.h"

void displayTopics(MYSQL *conn) {
    MYSQL_RES *res;
    MYSQL_ROW row;

    res = mysql_store_result(conn);
    if (res == NULL) {
        fprintf(stderr, "Result fetch failed: %s\n", mysql_error(conn));
        return;
    }

    while ((row = mysql_fetch_row(res)) != NULL) {
        printf("ID: %s, First Name: %s, Last Name: %s, Email: %s, Mobile No: %s\n",
               row[0], row[1], row[2], row[3], row[4]);
    }

    mysql_free_result(res);
}
