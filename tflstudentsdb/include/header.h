#include<stdio.h>
#include<stdlib.h>
#include <string.h>
#include<mysql.h>
<<<<<<< HEAD
using namespace std;
void 
=======
int addrecord(struct student *ptrstudent, MYSQL *conn);
>>>>>>> 14b8eca0554fb711c492d8d6a22a7cb5c8597393
struct student
{
    int id ;
    char firstname[10] ;
    char lastname[10] ;
    char emainID[50];
    int mobileno ;
};