<<<<<<< HEAD
#include "../src/connection.c"
=======
#include "..\include\header.h"
>>>>>>> 4f97761d21707a551d128842ec42d0fa979d3930

int main() {
    DBManager db;
    initDB(&db);

    // You can add queries here...

    closeDB(&db);
    return 0;
}