#include "networklib.h"

NetworkLib::NetworkLib()
    : hasConnection(false),
      api("http://CrashInYou.me")
{
}

QString NetworkLib::get( QString url ) {
    QEventLoop loop;
    QNetworkRequest netRequest;
    netRequest.setUrl(QUrl(api + url));
    netReply = netMgr->get( netRequest );
    netMgr->connect(netMgr, SIGNAL( finished(QNetworkReply*) ), &loop, SLOT(quit()));
    loop.exec();
    QString result = netReply->readAll();
    if ( !netReply->bytesAvailable() || result == "" )
        hasConnection = true;
    else
        hasConnection = false;
    return result;
}


bool NetworkLib::getStatus() {
    return hasConnection;
}
