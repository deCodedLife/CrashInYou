#include "siteapi.h"

SiteApi::SiteApi(QObject *parent)
    : QObject(parent)
{
    db->loadDB();
    QJsonObject userdata;
    userdata = db->getUserData();
    qDebug() << userdata;
    //QString netReply = net.get("");
    //qDebug() << netReply;
}
