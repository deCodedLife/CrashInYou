#ifndef SITEAPI_H
#define SITEAPI_H

#include <QObject>
#include "networklib.h"
#include "databaseapi.h"
#include <QJsonObject>

class SiteApi : public QObject
{
    Q_OBJECT
public:
    SiteApi(QObject *parent = nullptr);
    DatabaseApi *db = new DatabaseApi("bin/userdata.bin");
    NetworkLib net;
};

#endif // SITEAPI_H
