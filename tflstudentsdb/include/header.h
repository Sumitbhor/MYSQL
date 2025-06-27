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
    char emailID[50];
    int mobileno ;
};