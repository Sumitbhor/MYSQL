#include<stdio.h>
#include<stdlib.h>
#include <string.h>
#include<mysql.h>
<<<<<<< HEAD



int addrecord(struct student *ptrstudent, MYSQL *conn);

=======
int addrecord(struct student *ptrstudent, MYSQL *conn);
>>>>>>> 8ba03a59b3d40c48cf62f0f858cc39c49ecc4861
struct student
{
    int id ;
    char firstname[10] ;
    char lastname[10] ;
    char emainID[50];
    int mobileno ;
};