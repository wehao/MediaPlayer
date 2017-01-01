import QtQuick 2.4
import Material 0.2 as Material

Item {
    property alias color: slider.color
    Row {
        anchors.fill: parent
        spacing: 10
        IconButton {
            width: 30
            height: 30
            anchors.verticalCenter: parent.verticalCenter
            iconSource: "qrc:/res/icons/ic_music.svg"
            iconColor: "black"
            colorize: true
            backgroundColor: "lightyellow"
        }

        Material.Slider {
            id: slider
            width: parent.width * 0.7
            height: 30
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset:5
            //width:
        }

    }

}
