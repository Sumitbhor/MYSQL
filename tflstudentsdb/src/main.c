<<<<<<< HEAD
#include "../src/connection.c"
=======
#include "..\include\header.h"
>>>>>>> 4f97761d21707a551d128842ec42d0fa979d3930

int main() {
    DBManager db;
    initDB(&db);
    int choice = 0;
int totalstudent;
int main(){
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