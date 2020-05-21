#ifndef DATABASEAPI_H
#define DATABASEAPI_H

#include <QtSql>
#include <QObject>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonDocument>

class DatabaseApi
{
public:
    DatabaseApi( QString database );
    void loadDB();
    QJsonObject getUserData();
private:
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
};

#endif // DATABASEAPI_H
