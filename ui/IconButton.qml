import QtQuick 2.4
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.1


Button {
    id: mainItem
    width: parent.width
    height: parent.height

    property color backgroundColor: "#aa2116"
    property var iconSource
    property color iconColor
    property bool colorize:false
    property real radius
    property int iconSize
    property int sourceSize: 30

    style: ButtonStyle {
        background: Rectangle {
            id: backgoundRec
            anchors.fill: parent
            color: mainItem.backgroundColor
            border.width: 0
            border.color: "transparent"

            Image {
                id: icon
                anchors.centerIn: parent
                width: mainItem.iconSize
                height: width
                source: mainItem.iconSource
                Component.onCompleted: console.log("source: " + source + " width: " + width + " color: " + overlay.color)
                ColorOverlay {
                    id: overlay
                    anchors.fill: parent
                    source: icon
                    //color: mainItem.iconColor
                    color: "white"
                    //visible: mainItem.colorize
                }
            }
        }
    }

}
