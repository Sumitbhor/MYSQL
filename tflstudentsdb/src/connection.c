#include"../include/header.h"

typedef struct {
    MYSQL *conn;
} DBManager;

// Function to initialize and connect
void initDB(DBManager *db) {
    db->conn = mysql_init(NULL);
    if (db->conn == NULL) {
        fprintf(stderr, "mysql_init() failed\n");
        exit(EXIT_FAILURE);
    }

    if (mysql_real_connect(db->conn, "localhost", "root", "root123", "tflstudentdb", 0, NULL, 0) == NULL) {
        fprintf(stderr, "mysql_real_connect() failed\n");
        mysql_close(db->conn);
        exit(EXIT_FAILURE);
    }

    printf("Connected successfully!\n");
}

// Function to clean up
void closeDB(DBManager *db) {
    mysql_close(db->conn);
}
