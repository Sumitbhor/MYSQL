#ifndef HEADER_H
#define HEADER_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql.h>

typedef struct student {
    int id;
    char firstname[30];
    char lastname[30];
    char emailID[50];
    int mobileno;
} student;

typedef struct {
    MYSQL *conn;
} DBManager;

// Function declarations
void initDB(DBManager *db);
void closeDB(DBManager *db);
int addrecord(student *ptrstudent, MYSQL *conn);
int deleterecord(int id, MYSQL *conn);
void displayTopics(MYSQL *conn);
void updateRecord(MYSQL *conn);

#endif