#ifndef NETWORKLIB_H
#define NETWORKLIB_H

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QEventLoop>

class NetworkLib
{
public:
    NetworkLib();
    QString get(QString url);
    bool getStatus();
private:
    bool hasConnection;
    QNetworkAccessManager *netMgr = new QNetworkAccessManager();
    QNetworkReply *netReply;
    QNetworkRequest *netRequest;
    QString api;
};

#endif // NETWORKLIB_H
