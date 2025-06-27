#include "..\include\header.h"

int main() 
{
    DBManager db;
    initDB(&db);
    int choice = 0;
int totalstudent;

    printf("total number of student ");
    scanf("%d",&totalstudent); 

    struct Student data[totalstudent];
    while (choice!= 5){
        printf("enter your choice ");
        printf("1.addrecord ");
        printf("2.displayrecord ");
        printf("3.update ");
        printf("4.delete ");
        printf("5.exit ");
    switch (choice)
    {
    case 1 :
         for (int i = 0; i < totalstudent; i++){
        addrecord(data[totalstudent],)
        }
        break;
    
    default:
        break;
    }
    }
    closeDB(&db);
    return 0;
}