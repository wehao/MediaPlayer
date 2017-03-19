#include "localmusicfunction.h"
#include "qdebug.h"
#include "searchpathfunc.h"
#include "music.h"
#include "mediaanilysis.h"
#include "taglib/fileref.h"
#include "taglib/tag.h"
#include <QString>
#include "universalfunc.h"

LocalMusicFunction::LocalMusicFunction(QThread *parent):
    QThread(parent),
    m_localMusicModel(new BasicListModel())
{
}

LocalMusicFunction::~LocalMusicFunction()
{
    delete m_localMusicModel;
}

BasicListModel* LocalMusicFunction::localMusicModel() const
{
    return m_localMusicModel;
}

int LocalMusicFunction::localMusicsNums() const
{
    return m_localMusicModel->rowCount();
}

void LocalMusicFunction::startSearchMusics()
{
    qDebug() << "Start Search Music!";
    m_localMusicModel->clearMusics();       //clear all musics
    this->start(QThread::LowPriority);
}

QString LocalMusicFunction::getIndexPath(const QModelIndex &index) const
{
    return m_localMusicModel->getIndexPath(index.row());
}

void LocalMusicFunction::run()
{
    searchMusics();
}

void LocalMusicFunction::searchMusics()
{
    SearchPathFunc* searchPathFunc = SearchPathFunc::getInstance();
    QStringList musicFiles;       //universalfunc.h
    QStringList searchPaths = searchPathFunc->getSearchPath();
    for(int i = 0; i < searchPaths.count(); i++) {
        qDebug() << searchPaths.at(i);
    }
    QStringList musicFormat;
    musicFormat << "*.mp3" << "*.ape" << "*.ogg" << "*.wav" << "*.flac" << "*.asf" << "*.mp4" <<  "*.m4a";
    for(int index = 0; index < searchPaths.count(); index++) {
        QStringList onePathMusics = ::findFiles(searchPaths.at(index), musicFormat);
        musicFiles.append(onePathMusics);
    }
    qDebug() << "musicFiles count is: " << musicFiles.count();

    //解析每一个文件路径的媒体
    for(int i = 0; i < musicFiles.count(); i++) {
        Music music;
        QString tmpStr = musicFiles.at(i);
        qDebug() << "filePath" << tmpStr.toStdString().c_str();
        TagLib::FileRef fileRef(tmpStr.toStdString().c_str());          //const char*
        MediaAnilysis::mediaInfoAnalysis(music, fileRef);
        m_localMusicModel->addMusic(music.m_path, music.m_title, music.m_artist, music.m_duration, music.m_album, music.m_format);
    }
    qDebug() << "end analysis";
    emit(localMusicNumsChanged());
}



