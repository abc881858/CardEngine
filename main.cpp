#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
//#include "qmlandroidorientation.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

//    QmlAndroidOrientation orientation;
//    orientation.setOrientationLandscape();

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
