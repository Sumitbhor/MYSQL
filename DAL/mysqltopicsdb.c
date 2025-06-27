#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include "mysql.h"

int main(){
//structers provided for mysql

MYSQL *conn;
MYSQL_RES *res ;
MYSQL_ROW row ;

conn = mysql_init(NULL);
if (conn == NULL)
{
    fprintf(stderr,"mysql_init() failed\n");
    return EXIT_FAILURE;
}


}