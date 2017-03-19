#include "universalfunc.h"
#include <QDir>

UniversalFunc::UniversalFunc(QObject *parent) : QObject(parent)
{

}

UniversalFunc::~UniversalFunc()
{}

QStringList findFiles(const QString &startDir, QStringList filters)
{
    QStringList names;
    QDir dir(startDir);

    foreach (QString file, dir.entryList(filters, QDir::Files))
        names += startDir + '/' + file;

    foreach (QString subdir, dir.entryList(QDir::AllDirs | QDir::NoDotAndDotDot))
        names += findFiles(startDir + '/' + subdir, filters);
    return names;
}
