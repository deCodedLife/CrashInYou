#include "mainapi.h"

MainApi::MainApi(QObject *parent)
    : QObject(parent)
{
}

QString MainApi::search(QString data, QString pattern) {
    QList<QString> text = data.split("\n");
    QList<int> enteries;
    for (int i = 0; i < text.length(); i++) {
        QList<QString> part = text.at(i).split(pattern);
        if (part.length() > 1) return part.at(1);
    }
    return "";
}

void MainApi::write(Auth userData) {
    if ( userData.username == nullptr ) return;
    if ( userData.password == nullptr ) return;
    QFile outputFile(userData.output);
    QFile hashesFile(userData.hashes);
    if ( !outputFile.open(QIODevice::WriteOnly | QIODevice::Append) ||
         !hashesFile.open(QIODevice::WriteOnly | QIODevice::Append))
        return;
    QTextStream streamOutput(&outputFile);
    QTextStream streamHashes(&hashesFile);
    streamOutput << userData.username + ":" + userData.password << "\n";
    streamHashes << userData.password;
    if (userData.salt != nullptr) streamHashes << ":" + userData.salt;
    streamHashes << "\n";
    outputFile.close();
    hashesFile.close();
}

QString MainApi::readCurrent(QString file, int line) {
    QFile inputFile(file);
    QString current;
    if ( !inputFile.open(QIODevice::ReadOnly) ) return "";
    QTextStream stream(&inputFile);
    int i = 0;
    while ( i != line ) {
        current = stream.readLine();
        i++;
    }
    return current;
}

QString MainApi::listCleaner(QString input, QString output) {
    QString hashes = output + "-hashes.txt";
    QString UsernamePatern = "Username : ";
    QString PasswordPattern = "Password : ";
    QString SaltPattern = "Salt : ";
    QFile inputFile(input);
    if ( !inputFile.open(QIODevice::ReadOnly | QIODevice::Text) )
        return "Can't open file: " + input;
    QTextStream stream(&inputFile);
    QString data = stream.readAll();
    QList<QString> parts = data.split("\n\n");
    inputFile.close();
    for (int i = 0; i < parts.length(); i++) {
        Auth *userData = new Auth();
        userData->input = input;
        userData->output = output;
        userData->hashes = hashes;
        QString hasUsername = search(parts.at(i), UsernamePatern);
        QString hasPassword = search(parts.at(i), PasswordPattern);
        QString hasSalt = search(parts.at(i), SaltPattern);

        if (hasUsername != "") {
            userData->username = hasUsername;
            if(hasPassword != "")
                userData->password = hasPassword;
            else userData->password = nullptr;
            if (hasSalt != "")
                userData->salt = hasSalt;
            else userData->salt = nullptr;
        } else userData->username = nullptr;
        write(*userData);
    }
    return "fine";
}
