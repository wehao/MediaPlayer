import QtQuick 2.6
//import QtQuick.Controls 2.0
import "../ui"

Item {
    id: mainItem
    width: parent.width
    height: parent.height
    clip: true

    Flickable {
        id: mainFlickable
        anchors.fill: parent
        contentHeight: Math.max(mainColumn.implicitHeight, height)
        clip: true
        //ScrollBar.vertical: ScrollBar { }
        boundsBehavior: Flickable.StopAtBounds
        Column {
            id: mainColumn
            anchors.fill: parent

            Repeater {
                id: repeater
                model: 12
                delegate: Item {
                    id: simpleItem
                    width: parent.width
                    height: 100
                    Rectangle {
                        anchors.fill: parent
                        color: "lightblue"
                    }
                    Text {
                        id: tempText
                        text: qsTr("text")
                    }
                }
            }
        }
    }

    Scroolbar {
        id: scrollbar
        flickableItem: mainFlickable
        thickness: 10
    }

}
