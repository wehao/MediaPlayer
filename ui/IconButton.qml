import QtQuick 2.4
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.0


Button {
    id: mainItem
    width: parent.width
    height: parent.height

    property alias backgroundColor: backgoundRec.color
    property alias iconSource: icon.source
    property alias iconColor: overlay.color
    property bool colorize: false
    property alias radius: backgoundRec.radius
    property int iconSize
    property alias sourceSize: icon.sourceSize

    //signal clicked()
    Rectangle {
        id: backgoundRec
        anchors.fill: parent
        color: "red"
    }
    Image {
        id: icon
        anchors.centerIn: parent
        width: iconSize?iconSize:parent.width
        height: iconSize?iconSize:parent.height
        ColorOverlay {
            id: overlay
            anchors.fill: parent
            source: icon
            color: "white"
            visible: colorize
        }
    }

}
