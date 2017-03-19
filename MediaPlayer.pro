TEMPLATE = app

QT += qml quick widgets multimedia core

CONFIG += c++11

SOURCES += main.cpp \
    mediaplayer.cpp \
    model/basiclistmodel.cpp \
    localFunction/localmusicfunction.cpp \
    model/searchpath.cpp \
    localFunction/searchpathfunc.cpp \
    universalfunc.cpp \
    mediaanilysis.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    mediaplayer.h \
    model/basiclistmodel.h \
    localFunction/localmusicfunction.h \
    model/searchpath.h \
    localFunction/searchpathfunc.h \
    universalfunc.h \
    mediaanilysis.h \
    music.h

QMAKE_CXXFLAGS += -I /usr/local/include/taglib/
LIBS += -ltag
