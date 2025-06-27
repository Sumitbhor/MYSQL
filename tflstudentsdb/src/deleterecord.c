#include "../include/header.h"

int deleterecord(int id, MYSQL *conn) {
    char query[256];
    sprintf(query, "DELETE FROM students WHERE id = %d", id);

    if (mysql_query(conn, query)) {
        fprintf(stderr, "DELETE failed: %s\n", mysql_error(conn));
        return -1;
    }

    printf("Record with ID %d deleted successfully.\n", id);
    return 0;
}
