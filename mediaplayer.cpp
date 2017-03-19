#include "mediaplayer.h"
#include <QDebug>
#include "taglib/tag.h"
#include "taglib/fileref.h"
#include "universalfunc.h"

MediaPlayer::MediaPlayer(QObject *parent) :
    QObject(parent),
    playList(new QMediaPlaylist()),
    m_playState(false)
{
    //player = new QMediaPlayer;
    mediaPlayer.setPlaylist(playList);
    mediaPlayer.setVolume(40);
}

void MediaPlayer::play()
{
    //player = new QMediaPlayer;
    //connect(player, SIGNAL(positionChanged(qint64)), this, SLOT(positionChanged(qint64)));
    if(m_playState == true) {
        mediaPlayer.pause();
        setPlayState(false);
        return;
    }
//    player.setMedia(QUrl::fromLocalFile("/home/wehao/音乐/CloudMusic/11-11-태연.mp3"));
//    player.setVolume(20);
    mediaPlayer.play();
    setPlayState(true);
}

void MediaPlayer::addMedia(const QString &mediaString)
{
    qDebug() << playList->currentIndex();
    QMediaContent *tmpMediaContent = new QMediaContent(QMediaResource(QUrl::fromLocalFile(mediaString)));
    bool success = playList->insertMedia(playList->currentIndex(), *tmpMediaContent);
    qDebug() << "addMedia: " << success;
    playList->setCurrentIndex(0);
    mediaPlayer.play();
    setPlayState(true);
}

int MediaPlayer::volumn() const
{
    return mediaPlayer.volume();
}

void MediaPlayer::setVolumn(const int vol)
{
    if(vol != mediaPlayer.volume()) {
        mediaPlayer.setVolume(vol);
        emit(volumnChanged());
    }
}

bool MediaPlayer::playState() const
{
    return m_playState;
}

void MediaPlayer::setPlayState(const bool state)
{
    if(state != m_playState) {
        m_playState = state;
        emit(playStateChanged());
    }
}
