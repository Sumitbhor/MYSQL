#include "../include/header.h"

void initDB(DBManager *db) {
    db->conn = mysql_init(NULL);
    if (db->conn == NULL) {
        fprintf(stderr, "mysql_init() failed\n");
        exit(EXIT_FAILURE);
    }

    if (mysql_real_connect(db->conn, "localhost", "root", "password", "tflstudentdb", 0, NULL, 0) == NULL) {
        fprintf(stderr, "mysql_real_connect() failed\n");
        mysql_close(db->conn);
        exit(EXIT_FAILURE);
    }

    printf("Connected successfully!\n");
}

void closeDB(DBManager *db) {
    mysql_close(db->conn);
}
