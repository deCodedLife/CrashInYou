#ifndef MAINAPI_H
#define MAINAPI_H

#include <QObject>
#include "siteapi.h"
#include "databaseapi.h"

struct Auth {
    QString username;
    QString password;
    QString salt;
    QString input;
    QString output;
    QString hashes;
};

class MainApi : public QObject
{
    Q_OBJECT
public:
    MainApi(QObject * parent = nullptr);
    Q_INVOKABLE QString listCleaner(QString input, QString output);
private:
    QString search(QString line, QString pattern);
    void write(Auth userdata);
    QString readCurrent(QString file, int line);
    SiteApi net;
    DatabaseApi *db = new DatabaseApi("bin/users.bin");
};

#endif // MAINAPI_H
