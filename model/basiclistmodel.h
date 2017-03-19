#ifndef BASICLISTMODEL
#define BASICLISTMODEL
#include <QAbstractListModel>

class BasicListModel: public QAbstractListModel
{
    Q_OBJECT
public:
    BasicListModel(QObject *parent = Q_NULLPTR);
    virtual ~BasicListModel();
public:
    enum ListRoles {
        Path = Qt::UserRole + 1,
        MusicName,
        Singer,
        MusicTime,
        Album,
        Format
    };

    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    void addMusics(const QVariantList &);
    void addMusic(QString, QString, QString, int,  QString, QString);
    void clearMusics();
    QString getIndexPath(const int) const;

protected:
    QHash<int, QByteArray> roleNames() const;
private:
    QVariantList m_listmodel;
    QString intToTime(const int) const;
};

#endif
