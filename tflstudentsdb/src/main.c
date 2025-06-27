#include "../include/header.h"

int main() {
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

    closeDB(&db);
    return 0;
}
