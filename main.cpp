#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlContext>
#include "mediaplayer.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    MediaPlayer *mediaPlayer = new MediaPlayer();
    QQuickView view;
    view.setFlags(Qt::Window|Qt::FramelessWindowHint);
    view.setSource(QUrl("qrc:/main.qml"));
    view.setIcon(QIcon(":/res/icons/ic_music_note.svg"));
    view.engine()->rootContext()->setContextProperty("MainApp",&view);
    view.engine()->rootContext()->setContextProperty("mediaPlayer",mediaPlayer);
    view.show();

    return app.exec();
}
