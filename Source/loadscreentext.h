#ifndef LOADSCREENTEXT_H
#define LOADSCREENTEXT_H

#include <QObject>

class LoadScreenText : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString text READ text WRITE text)

public:
    LoadScreenText(QObject *parent = nullptr);

    void text(QString text);
    QString text();

private:
    QString _text;
};

#endif // LOADSCREENTEXT_H
