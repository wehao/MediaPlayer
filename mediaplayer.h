#ifndef MEDIAPLAYER_H
#define MEDIAPLAYER_H

#include <QObject>
#include <QMediaPlayer>

class MediaPlayer : public QObject
{
    Q_OBJECT
public:
    explicit MediaPlayer(QObject *parent = 0);
    Q_INVOKABLE void play();

signals:

public slots:

private:
    QMediaPlayer player;

};

#endif // MEDIAPLAYER_H
