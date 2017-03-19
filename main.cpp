#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlContext>
#include "mediaplayer.h"
#include "localFunction/localmusicfunction.h"
#include "localFunction/searchpathfunc.h"

//void initFunction(QQuickView* view)
//{
//    LocalMusicFunction* localMusicFunction = new LocalMusicFunction();
//    view->engine()->rootContext()->setContextProperty("localMusicFunction", localMusicFunction);
//}

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    MediaPlayer *mediaPlayer = new MediaPlayer();
    LocalMusicFunction *localMusicFunction = new LocalMusicFunction();
    SearchPathFunc * searchPathFunc = SearchPathFunc::getInstance();
    QQuickView view;
    view.setFlags(Qt::Window|Qt::FramelessWindowHint);
    view.setSource(QUrl("qrc:/main.qml"));
    view.setIcon(QIcon(":/res/icons/ic_music_note.svg"));
    view.engine()->rootContext()->setContextProperty("MainApp",&view);
    view.engine()->rootContext()->setContextProperty("mediaPlayer",mediaPlayer);
    view.engine()->rootContext()->setContextProperty("localMusicFunction", localMusicFunction);
    //localMusicFunction->startSearchMusics();        //searchMusics
    view.engine()->rootContext()->setContextProperty("searchPathFunc", searchPathFunc);
    view.show();

    return app.exec();
}
