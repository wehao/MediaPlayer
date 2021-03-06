import QtQuick 2.4
import QtQuick.Controls 1.2
import QtGraphicalEffects 1.0

Item{
    id: iconText
    property alias imageSource: image.source
    property alias text: msgText.text
    property alias font: msgText.font
    property bool colorize: false

    Image {
        id: image
        anchors{
            verticalCenter: parent.verticalCenter
            left: parent.left; leftMargin: 10
        }
        width: 30
        height: 30
        sourceSize: Qt.size(30, 30)
        visible: source != "" && !iconText.colorize
    }
    ColorOverlay {
        id: iconOverlay
        anchors.fill: image
        source: image
        color: "black"
        visible: iconText.colorize
    }

    Text {
        id: msgText
        anchors {
            left: image.right; leftMargin: 10
            verticalCenter: image.verticalCenter
        }
        font.pixelSize: 18
    }

    AnimatedImage {
        id: aniIcon
        width: 30
        height: 30
        anchors {
            right: parent.right; rightMargin: 5
            verticalCenter: parent.verticalCenter
        }
        source: "qrc:/res/icons/ic_playing_ani.gif"
        visible: true
    }
}
