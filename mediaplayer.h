#ifndef MEDIAPLAYER_H
#define MEDIAPLAYER_H

#include <QObject>
#include <QMediaPlayer>
#include <QMediaPlaylist>
#include <QMediaContent>

class MediaPlayer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool playState READ playState NOTIFY playStateChanged)
    Q_PROPERTY(int volumn READ volumn WRITE setVolumn NOTIFY volumnChanged)
public:
    explicit MediaPlayer(QObject *parent = 0);
    Q_INVOKABLE void play();
    Q_INVOKABLE void addMedia(const QString &);
    int volumn() const;
    void setVolumn(const int);
    bool playState() const;

signals:
void playStateChanged();
void volumnChanged();
public slots:

private:
    QMediaPlayer mediaPlayer;
    QMediaPlaylist *playList;
    bool m_playState;
    void setPlayState(const bool);

};

#endif // MEDIAPLAYER_H
