#include "../include/header.h"

typedef struct {
    MYSQL *conn;
} DBManager;

void initDB(DBManager *db) {
    db->conn = mysql_init(NULL);
    if (db->conn == NULL) {
        fprintf(stderr, "mysql_init() failed\n");
        exit(EXIT_FAILURE);
    }

    if (mysql_real_connect(db->conn, "localhost", "root", "password", "tflstudentdb", 0, NULL, 0) == NULL) {
        fprintf(stderr, "mysql_real_connect() failed\n");
        mysql_close(db->conn);
        exit(EXIT_FAILURE);
    }

    printf("Connected successfully!\n");
}

void closeDB(DBManager *db) {
    mysql_close(db->conn);
}

int main() {
    DBManager db;
    initDB(&db);

    int id;
    char fname[30], lname[20], email[50];
    int phone;
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
    scanf("%d", &phone);

    snprintf(query, sizeof(query),
             "UPDATE students SET First_name='%s', Last_name='%s', Email='%s', Phone_no=%d WHERE id=%d",
             fname, lname, email, phone, id);

    if (mysql_query(db.conn, query)) {
        fprintf(stderr, "Update failed: %s\n", mysql_error(db.conn));
        closeDB(&db);
        return EXIT_FAILURE;
    }

    printf("Student record updated successfully.\n");
    closeDB(&db);
    return 0;
}
