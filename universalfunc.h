//通用的函数类

#ifndef UNIVERSALFUNC_H
#define UNIVERSALFUNC_H

#include <QObject>
#include <QTextCodec>
#include "taglib/tag.h"

class UniversalFunc : public QObject
{
    Q_OBJECT
public:
    explicit UniversalFunc(QObject *parent = 0);
    ~UniversalFunc();

signals:

public slots:
};

QStringList findFiles(const QString &, QStringList);

namespace Universal {
static void cvtTString(TagLib::String& srcText,QString& text){
    QTextCodec* textCode = QTextCodec::codecForName("GB18030");
    if(srcText.isLatin1()){
        text = textCode->toUnicode(srcText.toCString());
    }else{
        text = QString::fromUtf8(srcText.toCString(true));
    }
}
}

#endif // UNIVERSALFUNC_H
