#include "../include/header.h"

int main() 
{
    DBManager db;
<<<<<<< HEAD
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

=======
    initDB(&db);
    int choice = 0;
<<<<<<< HEAD
int totalstudent;

=======
    int totalstudent;
>>>>>>> 0cffca23bd2e5efc0a0087aad6c283cdb725daf0
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
                DBManager db;
                for (int i = 0; i < totalstudent; i++){
                addrecord(data[totalstudent],db.conn);
                }
            break;
            
            default:
                break;
        }
    }
>>>>>>> 959b05d60b60c62d0d58c0462a357c622396da25
    closeDB(&db);
    return 0;
}
