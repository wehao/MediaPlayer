#ifndef MUSIC_H
#define MUSIC_H
#include <QString>

class Music
{
public:
    Music(){}
    QString m_title;
    QString m_artist;
    QString m_album;
    int m_duration;
    QString m_path;
    QString m_format;
};

#endif // MUSIC_H
