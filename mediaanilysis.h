#ifndef MEDIAANILYSIS_H
#define MEDIAANILYSIS_H
#include "taglib/fileref.h"
#include <QString>
#include "music.h"

#define MAGIC_NUMBER_MAX_LENGTH 16
class MediaAnilysis
{
public:
    MediaAnilysis();
    enum MediaType{
        Unknown,
        MP3,
        Flac,
        Ogg,
        Ape,
        ASF,
        MP4,
        M4A,
        WAV
    };
    static const uchar MAGICNUM_OGG[];
    static const uchar MAGICNUM_MP3[];
    static const uchar MAGICNUM_FLAC[];
    static const uchar MAGICNUM_MP4[];
    static const uchar MAGICNUM_M4A[];
    static const uchar MAGICNUM_APE[];
    static const uchar MAGICNUM_ASF[];
    static MediaType mediaFormat(TagLib::FileRef& fileRef);
    static void mediaInfoAnalysis(Music&, TagLib::FileRef& );
};

#endif // MEDIAANILYSIS_H
