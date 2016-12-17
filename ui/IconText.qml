import QtQuick 2.4
import Material 0.2 as Material

Material.View{
    id: iconText
    property alias imageSource: image.source
    property alias text: msgText.text
    property alias font: msgText.font

    Image {
        id: image
        anchors{
            verticalCenter: parent.verticalCenter
            left: parent.left; leftMargin: 10
        }
        sourceSize: Qt.size(30, 30)
    }
    Text {
        id: msgText
        anchors {
            left: image.right; rightMargin: 30
            verticalCenter: parent.verticalCenter
        }
        font.pixelSize: 18
    }

    AnimatedImage {
        id: aniIcon
        width: 30
        height: 30
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
        source: "qrc:/res/icons/ic_playing_ani.gif"
        anchors.centerIn: parent
        visible: true
    }
}
