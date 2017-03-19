#include "mediaanilysis.h"
#include "taglib/mpegfile.h"
#include "taglib/audioproperties.h"
#include <QDebug>
#include "universalfunc.h"


const uchar MediaAnilysis::MAGICNUM_OGG[]={0x4f,0x67,0x67,0x53};
const uchar MediaAnilysis::MAGICNUM_MP3[]={};
const uchar MediaAnilysis::MAGICNUM_FLAC[]= {0x66,0x4c,0x61,0x43,0x00,0x00,0x00,0x22};
const uchar MediaAnilysis::MAGICNUM_MP4[]={0x00,0x00,0x00,0x20,0x66,0x74,0x79,0x70};
const uchar MediaAnilysis::MAGICNUM_M4A[]={0x00,0x00,0x00,0x20,0x66,0x74,0x79,0x70,0x4d,0x34,0x41,0x20};
const uchar MediaAnilysis::MAGICNUM_APE[]={0x4D,0x41,0x43,0x20};
const uchar MediaAnilysis::MAGICNUM_ASF[]= {0x30,0x26,0xB2,0x75,0x8E,0x66,0xCF,0x11,0xA6,0xD9,0x00,0xAA,0x00,0x62,0xCE,0x6C};//asf/wma/wmv

MediaAnilysis::MediaAnilysis()
{

}

MediaAnilysis::MediaType MediaAnilysis::mediaFormat(TagLib::FileRef& fileRef)
{
    TagLib::File* file = fileRef.file();
    MediaType mediaType = MediaType::Unknown;
    if(!fileRef.isNull()&& file->isValid()){
        file->seek(0);
        TagLib::ByteVector byteVector = file->readBlock(MAGIC_NUMBER_MAX_LENGTH);
        char* buff = byteVector.data();
//        qWarning()<<"mediaType open mediaType1 :"<<file->name()<<":"<<byteVector.size();
        if(byteVector.size() <= 0){
            mediaType =  Unknown;
        }else if(!memcmp(buff,MAGICNUM_ASF, 16)){
            mediaType = MediaType::ASF;
        }else if(!memcmp(buff, "RIFF", 4)){
            if(!memcmp(&buff[8], "WAVE", 4)){
               mediaType = MediaType::WAV;
            }else{
               mediaType = MediaType::Unknown;
            }
        }else if(!memcmp(&buff[4], "ftyp",4)){
            if(!memcmp(buff, MAGICNUM_M4A, 12)){
               mediaType = MediaType::M4A;
            }else{
               mediaType = MediaType::Unknown;
            }
        }else if(!memcmp(buff,MAGICNUM_FLAC,8)){
            mediaType = MediaType::Flac;
        }else if(!memcmp(buff,MAGICNUM_APE,4)){
            mediaType = MediaType::Ape;
        }else if(!memcmp(buff,MAGICNUM_OGG,4)){
            mediaType = MediaType::Ogg;
        }else{
            TagLib::MPEG::File mpegFile(file->name());
//            long firstFrameOffset = mpegFile.firstFrameOffset();
//            TagLib::MPEG::Header firstHeader(&mpegFile, firstFrameOffset);
            if(mpegFile.isValid()){
                mediaType = MediaType::MP3;
            }else{
                mediaType = MediaType::Unknown;
            }
        }
    }else{
        qWarning()<<"mediaType open error :";
        mediaType =  Unknown;
    }

    return mediaType;
}

void MediaAnilysis::mediaInfoAnalysis(Music &music, TagLib::FileRef &fileRef)
{
    qDebug() << "start Analysis Media!!";
    switch(mediaFormat(fileRef))
    {
    case Unknown:
        music.m_format = "unknown";
        break;
    case MP3:
        music.m_format = "mp3";
        break;
    case Flac:
        music.m_format = "flac";
        break;
    case Ogg:
        music.m_format = "ogg";
        break;
    case Ape:
        music.m_format = "ape";
        break;
    case ASF:
        music.m_format = "asf";
        break;
    case MP4:
        music.m_format = "mp4";
        break;
    case M4A:
        music.m_format = "m4a";
        break;
    case WAV:
        music.m_format = "wav";
        break;
    }

    TagLib::File *file = fileRef.file();
    music.m_path = file->name();
    if(music.m_format == "unknown") {
        int startPos = music.m_path.lastIndexOf("/");
        int endPos = music.m_path.lastIndexOf(".");
        QString title = music.m_path.mid(startPos + 1, endPos - startPos - 1);
        music.m_title = title;
        music.m_album = "unknown";
        music.m_artist = "unknown";
        music.m_duration = 0;
        return;
    }

    TagLib::String tmpStr;
    tmpStr = fileRef.tag()->album();
    Universal::cvtTString(tmpStr, music.m_album);
    if(music.m_album.isEmpty())
        music.m_album = "unknown";
    tmpStr = fileRef.tag()->artist();
    Universal::cvtTString(tmpStr, music.m_artist);
    if(music.m_artist.isEmpty())
        music.m_artist = "unknown";
    tmpStr = fileRef.tag()->title();
    Universal::cvtTString(tmpStr, music.m_title);
    if(music.m_title.isEmpty()) {
        int startPos = music.m_path.lastIndexOf("/");
        int endPos = music.m_path.lastIndexOf(".");
        QString title = music.m_path.mid(startPos + 1, endPos - startPos - 1);
        music.m_title = title;
    }
    music.m_duration = 0;
    if(!fileRef.isNull() && fileRef.audioProperties()) {
        TagLib::AudioProperties *properties = fileRef.audioProperties();
        music.m_duration = properties->length();
    }
}
