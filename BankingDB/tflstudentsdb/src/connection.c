#include "../include/header.h"

<<<<<<< HEAD

// Function to initialize and connect
MYSQL* initDB() {
    MYSQL *conn;
    conn= mysql_init(NULL);
    if (conn == NULL) {
=======
void initDB(DBManager *db) {
    db->conn = mysql_init(NULL);
    if (db->conn == NULL) {
>>>>>>> e37476177ecf926e8d1841e1d3c03db81e6ebfc4
        fprintf(stderr, "mysql_init() failed\n");
        exit(EXIT_FAILURE);
    }

<<<<<<< HEAD
    if (mysql_real_connect(conn, "localhost", "root", "root123", "tflstudentdb", 0, NULL, 0) == NULL) {
=======
    if (mysql_real_connect(db->conn, "localhost", "root", "password", "tflstudentdb", 0, NULL, 0) == NULL) {
>>>>>>> e37476177ecf926e8d1841e1d3c03db81e6ebfc4
        fprintf(stderr, "mysql_real_connect() failed\n");
        mysql_close(conn);
        exit(EXIT_FAILURE);
    }

    printf("Connected successfully!\n");
    return conn;
}

<<<<<<< HEAD
// Function to clean up
void closeDB(MYSQL *conn) {
    mysql_close(conn);
=======
void closeDB(DBManager *db) {
    mysql_close(db->conn);
>>>>>>> e37476177ecf926e8d1841e1d3c03db81e6ebfc4
}
 