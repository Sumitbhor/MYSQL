<<<<<<< HEAD
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
=======
#include<stdio.h>
#include<stdlib.h>
#include <string.h>
#include<mysql.h>

<<<<<<< HEAD
int addrecord(struct student *ptrstudent, MYSQL *conn);
int deleterecord(int id, MYSQL *conn) ;
void initDB(DBManager *db);
int main();
void displayTopics();



=======
>>>>>>> 0cffca23bd2e5efc0a0087aad6c283cdb725daf0
struct student
{
    int id ;
    char firstname[10] ;
    char lastname[10] ;
>>>>>>> 959b05d60b60c62d0d58c0462a357c622396da25
    char emailID[50];
    int mobileno[20];
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
