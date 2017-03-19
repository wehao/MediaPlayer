#include "searchpath.h"
#include "qdebug.h"

SearchPath::SearchPath(QAbstractListModel *parent):
    QAbstractListModel(parent)
{

}

SearchPath::~SearchPath()
{}

QVariant SearchPath::data(const QModelIndex &index, int role) const
{
    if(index.row() < 0 || index.row() > m_pathList.count())
        return QVariant();
    QVariantMap map = m_pathList.at(index.row()).toMap();
    switch(role)
    {
    case Path:
        return map.value("path").toString();
    case Opened:
        return map.value("opened").toString();
    default:
        return QVariant();
    }
}

int SearchPath::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_pathList.count();
}

void SearchPath::addPath(const QString path, const bool opened)
{
    bool exsitPath = false;
    for(int i = 0; i < m_pathList.count(); i++) {
        QString tmpPath = m_pathList.at(i).toMap().value("path").toString();
        if(QString::compare(path, tmpPath) == 0) {
            if(m_pathList.at(i).toMap().value("opened").toBool() == false) {
                beginRemoveRows(QModelIndex(), i, i);
                m_pathList.removeAt(i);
                endRemoveRows();
                beginInsertRows(QModelIndex(), i, i);
                QVariantMap object;
                object["path"]  = path;
                object["opened"] = opened;
                m_pathList.append(object);
                endInsertRows();
            }
            exsitPath = true;
            break;
        }
    }
    if(!exsitPath) {
        beginInsertRows(QModelIndex(), rowCount(), rowCount());
        QVariantMap object;
        object["path"]  = path;
        object["opened"] = opened;
        m_pathList.append(object);
        endInsertRows();
    }
}

void SearchPath::updatePaths()
{
    for(int index = 0; index < m_pathList.count(); index++) {
        if(m_pathList.at(index).toMap().value("opened").toBool() == false) {
            beginRemoveRows(QModelIndex(), index, index);
        }
    }
}

void SearchPath::enablePath(const QString path, const bool enable)
{
    for(int i = 0; i < m_pathList.count(); i++) {
        QString tmpPath = m_pathList.at(i).toMap().value("path").toString();
        if(QString::compare(path, tmpPath) == 0) {
            if(m_pathList.at(i).toMap().value("opened").toBool() != enable) {
                m_pathList.removeAt(i);
                QVariantMap object;
                object["path"]  = path;
                object["opened"] = enable;
                m_pathList.append(object);
                emit(pathListChanged());
            }
            break;
        }
    }
}

QVariantList SearchPath::getPathList() const
{
    return m_pathList;
}

QHash<int, QByteArray> SearchPath::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Path] = "path";
    roles[Opened] = "opened";
    return roles;
}

