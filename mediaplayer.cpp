#include "mediaplayer.h"
#include <QDebug>

MediaPlayer::MediaPlayer(QObject *parent) : QObject(parent), player(0)
{
    //player = new QMediaPlayer;
}

void MediaPlayer::play()
{
//    qDebug() << "playmusic";
//    player->setMedia(QUrl::fromLocalFile("/home/wehao/音乐/CloudMusic/蔡健雅 - 失忆症.mp3"));
//    player->setVolume(30);
//    player->play();

    ///player = new QMediaPlayer;
    //connect(player, SIGNAL(positionChanged(qint64)), this, SLOT(positionChanged(qint64)));
    player.setMedia(QUrl::fromLocalFile("/home/wehao/音乐/CloudMusic/11-11-태연.mp3"));
    player.setVolume(20);
    player.play();
}
