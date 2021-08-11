#include "qmlandroidorientation.h"

QmlAndroidOrientation::QmlAndroidOrientation(QObject *parent) : QObject(parent)
{
    activity = androidActivity();
}

void QmlAndroidOrientation::setOrientationPortrait()
{
    activity.callMethod<void>("setRequestedOrientation", "(I)V", 1);
    if(env->ExceptionCheck())
    {
        env->ExceptionClear();
    }
}

void QmlAndroidOrientation::setOrientationLandscape()
{
    activity.callMethod<void>("setRequestedOrientation", "(I)V", 0);
    if(env->ExceptionCheck())
    {
        env->ExceptionClear();
    }
}
