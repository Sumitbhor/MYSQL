#include<stdio.h>
#include<stdlib.h>
#include <string.h>
#include<mysql.h>
int addrecord(struct student *ptrstudent, MYSQL *conn);

struct student
{
    int id ;
    char firstname[10] ;
    char lastname[10] ;
    char emailID[50];
    int mobileno ;
};