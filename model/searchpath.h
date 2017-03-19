#ifndef SEARCHPATH_H
#define SEARCHPATH_H

#include <QAbstractListModel>

class SearchPath: public QAbstractListModel
{
    Q_OBJECT
public:
    enum PathRoles {
        Path = Qt::UserRole + 1,
        Opened
    };
public:
    SearchPath(QAbstractListModel *parent = 0);
    ~SearchPath();
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    void addPath(const QString, const bool);
    void updatePaths();
    void enablePath(const QString, const bool);
    QVariantList getPathList() const;
signals:
    void pathListChanged();
protected:
    QHash<int, QByteArray> roleNames() const;
private:
    QVariantList m_pathList;
};

#endif // SEARCHPATH_H
