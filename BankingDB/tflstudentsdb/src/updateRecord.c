#include "../include/header.h"

void updateRecord(MYSQL *conn) {
    int id, phone;
    char fname[30], lname[20], email[50];
    char query[512];

    printf("Enter ID of student to update: ");
    scanf("%d", &id);
    getchar();

    printf("Enter new First Name: ");
    fgets(fname, sizeof(fname), stdin);
    fname[strcspn(fname, "\n")] = '\0';

    printf("Enter new Last Name: ");
    fgets(lname, sizeof(lname), stdin);
    lname[strcspn(lname, "\n")] = '\0';

    printf("Enter new Email: ");
    fgets(email, sizeof(email), stdin);
    email[strcspn(email, "\n")] = '\0';

    printf("Enter new Phone Number: ");
    scanf("%s", &phone);

    snprintf(query, sizeof(query),
             "UPDATE students SET First_name='%s', Last_name='%s', Email='%s', Phone_no=%s WHERE id=%d",
             fname, lname, email, phone, id);

    if (mysql_query(conn, query)) {
        fprintf(stderr, "Update failed: %s\n", mysql_error(conn));
    } else {
        printf("Student record updated successfully.\n");
    }
}
