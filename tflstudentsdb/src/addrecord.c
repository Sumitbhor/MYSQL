#include "../include/header.h"

int addrecord(student *ptrstudent, MYSQL *conn) {
    printf("Enter your ID:\n");
    scanf("%d", &ptrstudent->id);

    printf("Enter your first name:\n");
    scanf("%s", ptrstudent->firstname);

    printf("Enter your last name:\n");
    scanf("%s", ptrstudent->lastname);

    printf("Enter your email:\n");
    scanf("%s", ptrstudent->emailID);

    printf("Enter your mobile number:\n");
    scanf("%s", &ptrstudent->mobileno);

    char query[500];
    sprintf(query, "INSERT INTO students (id, First_name, Last_name, Email, Phone_no) VALUES (%d, '%s', '%s', '%s', %d)", 
        ptrstudent->id, ptrstudent->firstname, ptrstudent->lastname, ptrstudent->emailID, ptrstudent->mobileno);

    if (mysql_query(conn, query)) {
        printf("Insert failed. Error: %s\n", mysql_error(conn));
        return 0;
    }

    return 1;
}
