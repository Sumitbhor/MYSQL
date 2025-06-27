#include "connection.c"

int main() {
    DBManager db;
    initDB(&db);

    // You can add queries here...

    closeDB(&db);
    return 0;
}