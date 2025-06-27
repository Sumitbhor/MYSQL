#include<stdio.h>
#include<stdlib.h>
#include <string.h>
#include<mysql.h>

int addrecord(struct student *ptrstudent, MYSQL *conn);
int deleterecord(int id, MYSQL *conn) ;
void initDB(DBManager *db);
int main();
void displayTopics();



struct student
{
    int id ;
    char firstname[10] ;
    char lastname[10] ;
    char emailID[50];
    int mobileno ;
};