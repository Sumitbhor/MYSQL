#include "../include/header.h"

<<<<<<< HEAD
int main() {

    int choice = 0;
    int totalstudent;
    MYSQL* conn=  initDB();
   
        while (choice!= 5){
            printf("\nenter your choice ");
            printf("\n1.addrecord ");
            printf("\n2.displayrecord ");
            printf("\n3.update ");
            printf("\n4.delete ");
            printf("\n5.exit ");
            scanf("%d",&choice);
=======
int main() 
{
    DBManager db;

    student s;
    int choice, id;

    initDB(&db);

    do {
        printf("\n------ STUDENT DATABASE MENU ------\n");
        printf("1. Add Record\n");
        printf("2. Update Record\n");
        printf("3. Delete Record\n");
        printf("4. Display Records\n");
        printf("5. Exit\n");
        printf("Enter your choice: ");
        scanf("%d", &choice);
        getchar();

        switch (choice) {
            case 1:
                if (addrecord(&s, db.conn))
                    printf(" Record added successfully!\n");
                else
                    printf(" Failed to add record.\n");
                break;

            case 2:
                updateRecord(db.conn);
                break;

            case 3:
                printf("Enter ID to delete: ");
                scanf("%d", &id);
                deleterecord(id, db.conn);
                break;

            case 4:
                if (mysql_query(db.conn, "SELECT * FROM students") == 0)
                    displayTopics(db.conn);
                else
                    fprintf(stderr, "Query Failed: %s\n", mysql_error(db.conn));
                break;

            case 5:
                printf("Exiting...\n");
                break;

            default:
                printf(" Invalid choice! Try again.\n");
        }

    } while (choice != 5);

    initDB(&db);
    int choice = 0;
int totalstudent;

    printf("total number of student ");
    scanf("%d",&totalstudent); 
>>>>>>> e37476177ecf926e8d1841e1d3c03db81e6ebfc4

                

            switch (choice)
            {
                case 1 :{
                    printf("total number of student ");
                    scanf("%d",&totalstudent); 

                        struct student data[totalstudent];
                    for (int i = 0; i<totalstudent; i++){
                    addrecord(&data[i],conn);
                    }
                }
                break;

                case 2:
                    displayTopics(conn);
                    break;
                
            /*  case 3 :
                    update (ptrstudent->id, conn);
                    break;*/
                
                case 4: {
                    int id;
                printf(" enter id :");
                scanf("%d", &id);
                
                    deleterecord(id, conn);
                    break;
                }

                case 5 : 
                        return 0 ;
                        break ;
                
                default:
                    break;
            }
        }
    closeDB(conn);
    return 0;
}


/* gcc -Iinclude -c .\src\connection.c -o ./build/connection.o -I "C:\Program Files\MySQL\MySQL Server 8.0\include" -L "C:\Program Files\MySQL\MySQL Server 8.0\lib" -l libmysql
 gcc -Iinclude -c .\src\addrecord.c -o ./build/addrecord.o -I "C:\Program Files\MySQL\MySQL Server 8.0\include" -L "C:\Program Files\MySQL\MySQL Server 8.0\lib" -l libmysql
 gcc -Iinclude -c .\src\delete.c -o ./build/delete.o -I "C:\Program Files\MySQL\MySQL Server 8.0\include" -L "C:\Program Files\MySQL\MySQL Server 8.0\lib" -l libmysql
 gcc -Iinclude -c .\src\display.c -o ./build/display.o -I "C:\Program Files\MySQL\MySQL Server 8.0\include" -L "C:\Program Files\MySQL\MySQL Server 8.0\lib" -l libmysql
 gcc -Iinclude -c .\src\main.c -o ./build/main.o -I "C:\Program Files\MySQL\MySQL Server 8.0\include" -L "C:\Program Files\MySQL\MySQL Server 8.0\lib" -l libmysql
 gcc -Iinclude -c .\src\update.c -o ./build/update.o -I "C:\Program Files\MySQL\MySQL Server 8.0\include" -L "C:\Program Files\MySQL\MySQL Server 8.0\lib" -l libmysql
 gcc addrecord.o connection.o delete.o display.o main.o -o db.exe -I "C:\Program Files\MySQL\MySQL Server 8.0\include" -L "C:\Program Files\MySQL\MySQL Server 8.0\lib" -l libmysql
 */