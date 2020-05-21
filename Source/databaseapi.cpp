#include "databaseapi.h"

DatabaseApi::DatabaseApi(QString dbName)
{
    if ( !QDir().exists("bin") )
        QDir().mkdir("bin");
    db.setDatabaseName(dbName);
}

void DatabaseApi::loadDB() {
    QSqlQuery query;
    QList<QLatin1String> tables;
    tables.append(QLatin1String("user"));
    tables.append(QLatin1String("options"));
    tables.append(QLatin1String("data"));
    if ( !db.open() )
        return;
    for ( int i = 0; i < tables.length(); i++ ) {
        if ( !db.contains( tables.at(i) ) ) {
            if ( i == 0 )
                query.exec("CREATE TABLE user ( password TEXT NOT NULL, hash INT NOT NULL)");
            if ( i == 1 )
                query.exec("CREATE TABLE options ( api TEXT NOT NULL, theme INT NOT NULL)");
            if ( i == 2 )
                query.exec("");
        }
    }
}

QJsonObject DatabaseApi::getUserData() {
    QSqlQuery query;
    QJsonObject userdata;
    if ( !db.open() )
        return userdata;
    query.exec("select * from user");
    query.next();
    userdata["password"] = query.value(0).toString();
    userdata["hash"] = query.value(1).toString();
}
