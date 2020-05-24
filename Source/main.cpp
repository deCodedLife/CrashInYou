#include <QApplication>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "loadscreentext.h"
#include "mainapi.h"

int main(int argc, char *argv[])
{
    qmlRegisterType<MainApi>("CoreApi", 0, 1, "CoreApi");
    qmlRegisterType<LoadScreenText>("LoadScreenText", 0, 1, "LoadScreenText");

    #ifdef __linux__
        QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
        QApplication app(argc, argv);
    #elif
        QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
        QGuiApplication app(argc, argv);
    #endif

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/Forms/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
