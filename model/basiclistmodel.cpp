#include "basiclistmodel.h"
#include "qdebug.h"
#include <QTime>

BasicListModel::BasicListModel(QObject *parent)
    :QAbstractListModel(parent)
{
}

BasicListModel::~BasicListModel()
{}

int BasicListModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_listmodel.count();
}

QVariant BasicListModel::data(const QModelIndex &index, int role) const
{
    if(index.row() < 0 || index.row() > m_listmodel.count()) {
        qDebug() << "the index of data is out of range!";
        return QVariant();
    }
    QVariantMap tmpVariant= m_listmodel.at(index.row()).toMap();
    switch (role) {
    case Path:
        return tmpVariant.value("path").toString();
    case MusicName:
        return tmpVariant.value("musicName").toString();
    case Singer:
        return tmpVariant.value("singer").toString();
    case MusicTime:
        return intToTime(tmpVariant.value("musicTime").toInt());
    case Album:
        return tmpVariant.value("album").toString();
    case Format:
        return tmpVariant.value("format").toString();
    default:
        return QVariant();
    }
}

void BasicListModel::addMusics(const QVariantList &musicList)
{
    int size = musicList.count();
    if(size > 0) {
        beginInsertRows(QModelIndex(), rowCount(), rowCount() + size - 1);
        m_listmodel.append(musicList);
        endInsertRows();
    }
}

void BasicListModel::addMusic(QString path, QString musicName, QString singer, int musicTime, QString album, QString format)
{
    QVariantMap map;
    map["path"] = path;
    map["musicName"] = musicName;
    map["singer"] = singer;
    map["musicTime"]= musicTime;
    map["album"] = album;
    map["format"] = format;
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_listmodel.append(map);
    endInsertRows();
}

void BasicListModel::clearMusics()
{
    beginRemoveRows(QModelIndex(), 0, rowCount());
    m_listmodel.clear();
    endRemoveRows();
    qDebug() << "m_listmodel: " << m_listmodel.count();
}

QString BasicListModel::getIndexPath(const int row) const
{
    if(row < 0 || row > m_listmodel.count())
        return QString();
    QString tmpStr;
    tmpStr = m_listmodel.at(row).toMap().value("path").toString();
    return tmpStr;
}

QHash<int, QByteArray> BasicListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Path] = "path";
    roles[MusicName] = "musicName";
    roles[Singer] = "singer";
    roles[MusicTime] = "musicTime";
    roles[Album] = "album";
    roles[Format] = "format";
    return roles;
}

QString BasicListModel::intToTime(const int secs) const
{
    QTime startTime(0,0,0);
    QTime endTime;
    endTime = startTime.addSecs(secs);
    return endTime.toString("mm:ss");
}
