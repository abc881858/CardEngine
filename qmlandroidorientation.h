#pragma once
#include <QObject>
#include <QtAndroidExtras/QAndroidJniObject>
#include <QtAndroidExtras/QAndroidJniEnvironment>
#include <QtAndroidExtras/QtAndroid>

using namespace QtAndroid;

class QmlAndroidOrientation : public QObject
{
    Q_OBJECT
public:
    explicit QmlAndroidOrientation(QObject *parent = nullptr);

    Q_INVOKABLE void setOrientationPortrait();
    Q_INVOKABLE void setOrientationLandscape();

private:
    QAndroidJniEnvironment env;
    QAndroidJniObject activity;
};
