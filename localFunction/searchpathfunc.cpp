#include "searchpathfunc.h"
#include "qdebug.h"

SearchPathFunc::SearchPathFunc(QObject *parent):
    QObject(parent),
    m_searchPath(new SearchPath())
{
    connect(m_searchPath, SIGNAL(pathListChanged()), this, SLOT(sendSearchPathChanged()));
}

SearchPathFunc* SearchPathFunc::instance = NULL;

SearchPathFunc* SearchPathFunc::getInstance()
{
    if(instance == NULL) {
        instance = new SearchPathFunc();
    }
    return instance;
}

SearchPathFunc::~SearchPathFunc()
{
    delete instance;
    instance = NULL;
}

SearchPath* SearchPathFunc::searchPath() const
{
    return m_searchPath;
}

void SearchPathFunc::addPath(QString path, const bool opened)
{
    QString subPath = path.remove("file://");
    qDebug() << "subPath: " << subPath;
    m_searchPath->addPath(subPath, opened);
}

void SearchPathFunc::enablePath(const QString path, const bool enable)
{
    qDebug() << "enablePath";
    m_searchPath->enablePath(path, enable);
}

QStringList SearchPathFunc::getSearchPath()
{
    QVariantList tmpPathList = m_searchPath->getPathList();
    QStringList retStrList;
    for(int index = 0; index < tmpPathList.count(); index++) {
        retStrList.append(tmpPathList.at(index).toMap().value("path").toString());
    }
    return retStrList;
}

void SearchPathFunc::sendSearchPathChanged()
{
    emit(searchPathChanged());
}



