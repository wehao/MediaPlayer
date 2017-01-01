import QtQuick 2.4
import Material 0.2 as Material

Item {
    property alias color: slider.color
    Row {
        anchors.fill: parent
        Text {
            id: playedTime
            width: parent.width * 0.15
            anchors.verticalCenter: parent.verticalCenter
            font {
                pixelSize: 15
            }
            text: "01:30"
            horizontalAlignment: Text.AlignHCenter
        }

        Material.Slider {
            id: slider
            width: parent.width * 0.7
            height: 30
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset:5
            //width:
        }
        Text {
            id: totalTime
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width * 0.15
            font {
                pixelSize: 15
            }
            text: "03:30"
            horizontalAlignment: Text.AlignHCenter
        }
    }

}
