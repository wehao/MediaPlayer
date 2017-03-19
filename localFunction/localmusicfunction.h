#ifndef LOCALMUSICFUNCTION_H
#define LOCALMUSICFUNCTION_H
#include <QObject>
#include <QThread>
#include "model/basiclistmodel.h"
class SearchPathFunc;

class LocalMusicFunction: public QThread
{
    Q_OBJECT
    Q_PROPERTY(BasicListModel* localMusicModel READ localMusicModel NOTIFY localMusicModelChanged)
    Q_PROPERTY(int localMusicNums READ localMusicsNums NOTIFY localMusicNumsChanged)
public:
    LocalMusicFunction(QThread *parent = 0);
    ~LocalMusicFunction();
    BasicListModel* localMusicModel() const;
    int localMusicsNums() const;
    Q_INVOKABLE void startSearchMusics();
    Q_INVOKABLE QString getIndexPath(const QModelIndex &) const;
signals:
    void localMusicModelChanged();
    void localMusicNumsChanged();
protected:
    void run() override;
private:
    BasicListModel * m_localMusicModel;
    void searchMusics();
};
#endif
