#include "../include/header.h"

int addrecord(student *ptrstudent, MYSQL *conn) {
    printf("Enter your ID:\n");
    scanf("%d", &ptrstudent->id);

    printf("Enter your first name:\n");
    scanf("%s", ptrstudent->firstname);

    printf("Enter your last name:\n");
    scanf("%9s", ptrstudent->lastname);

    printf("Enter your email:\n");
    scanf("%s", ptrstudent->emailID);

    printf("Enter your mobile number:\n");
<<<<<<< HEAD
    scanf("%s", ptrstudent->mobileno);

    char query[512];
    snprintf(query, sizeof(query),
        "INSERT INTO students (id, firstname, lastname, Email, mobile) "
        "VALUES (%d, '%s', '%s', '%s', '%s')",
        ptrstudent->id,
        ptrstudent->firstname,
        ptrstudent->lastname,
        ptrstudent->emailID,
        ptrstudent->mobileno
    );
=======
    scanf("%s", &ptrstudent->mobileno);

    char query[500];
    sprintf(query, "INSERT INTO students (id, First_name, Last_name, Email, Phone_no) VALUES (%d, '%s', '%s', '%s', %d)", 
        ptrstudent->id, ptrstudent->firstname, ptrstudent->lastname, ptrstudent->emailID, ptrstudent->mobileno);
>>>>>>> e37476177ecf926e8d1841e1d3c03db81e6ebfc4

    if (mysql_query(conn, query)) {
        printf("Insert failed. Error: %s\n", mysql_error(conn));
        return 0;
    }

<<<<<<< HEAD
    printf("Record added successfully.\n");
    return 1; // Success
}
=======
    return 1;
}
>>>>>>> e37476177ecf926e8d1841e1d3c03db81e6ebfc4
