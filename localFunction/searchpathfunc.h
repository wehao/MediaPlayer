#ifndef SEARCHPATHFUNC_H
#define SEARCHPATHFUNC_H

#include <QObject>
#include "model/searchpath.h"

class SearchPathFunc: public QObject
{
    Q_OBJECT
    Q_PROPERTY(SearchPath* searchPath READ searchPath NOTIFY searchPathChanged)
public:
    static SearchPathFunc *getInstance();
    ~SearchPathFunc();
    SearchPath* searchPath() const;
    Q_INVOKABLE void addPath(QString, const bool);
    Q_INVOKABLE void enablePath(const QString, const bool);
    QStringList getSearchPath();
signals:
    void searchPathChanged();
private slots:
    void sendSearchPathChanged();
private:
    explicit SearchPathFunc(QObject *parent = 0);
    static SearchPathFunc* instance;
    SearchPath *m_searchPath;
};

#endif // SEARCHPATHFUNC_H
