import QtQuick 2.4
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.1

Item{
    id: mainItem
    property color backgroundColor: "#aa2116"
    property var iconSource
    property color iconColor
    property bool colorize:false
    property real radius
    property int iconSize
    property int sourceSize
    property alias iconRadius: backgroundRec.radius
    signal itemClicked
    property bool hoverd
    Rectangle {
        id: backgroundRec
        anchors.fill: parent
        color: mainItem.backgroundColor
    }
    Image {
        id: icon
        //anchors.centerIn: parent
        width: mainItem.iconSize
        height: width
        visible: !mainItem.colorize && source != ""
        source: mainItem.iconSource
        sourceSize: Qt.size(mainItem.sourceSize, mainItem.sourceSize)
        smooth: true
    }

    ColorOverlay {
        id: overlay
        anchors.fill: parent
        source: icon
        color: mainItem.iconColor
        visible: mainItem.colorize
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: itemClicked()
        onEntered: {hoverd = true}
        onExited: hoverd = false
    }
}
