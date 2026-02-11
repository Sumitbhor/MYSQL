#ifndef HEADER_H
#define HEADER_H
<<<<<<< HEAD

#include<stdio.h>
#include<stdlib.h>
#include <string.h>
#include<mysql.h>


=======
>>>>>>> e37476177ecf926e8d1841e1d3c03db81e6ebfc4

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql.h>

typedef struct student {
    int id;
    char firstname[30];
    char lastname[30];
    char emailID[50];
<<<<<<< HEAD
    char mobileno[10] ;
};

int addrecord(struct student *ptrstudent, MYSQL *conn);
MYSQL* initDB();
void displayTopics( MYSQL *conn) ;
void closeDB(MYSQL *conn) ;
int deleterecord(int id, MYSQL *conn);
=======
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

>>>>>>> e37476177ecf926e8d1841e1d3c03db81e6ebfc4
#endif