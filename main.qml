import QtQuick 2.5
import QtQuick.Controls 1.4
import Qt.labs.controls 1.0
import "./music"
import "./ui"

Item {
    id: appWindow
    visible: true
    width: 1024
    height: 670
    Item {
        id: hearderItem
        width: parent.width
        height: 50
        anchors.top: parent.top
        Rectangle {
            id: backgroundRec
            anchors.fill: parent
            color: "#aa2116"
            MouseArea {
                anchors.fill: parent
                property point clickPos: "0,0"
                onPressed: {
                    clickPos = Qt.point(mouse.x, mouse.y)
                }
                onPositionChanged: {
                    var delta = Qt.point(mouse.x - clickPos.x, mouse.y - clickPos.y)
                    MainApp.setX(MainApp.x + delta.x);
                    MainApp.setY(MainApp.y + delta.y);
                }
            }
            IconButton {
                id: quitBtn
                anchors.right: parent.right
                width: 50
                height: 50
                iconSize: 30
                iconSource: "qrc:/res/icons/ic_quit.svg"
                //iconColor: hovered?"white":"#d3d7d4"
                iconColor: "white"
                colorize: true
                onClicked: MainApp.close();
            }
            IconButton {
                id: minBtn
                anchors.right: quitBtn.left
                width: 50
                height: 50
                iconSize: 30
                iconSource: "qrc:/res/icons/ic_quit.svg"
                onHoveredChanged: {
                    if(hovered)
                        iconColor = "white"
                    else iconColor = "#d3d7d4"
                }
                iconColor: "#d3d7d4"
                colorize: true
                onClicked: MainApp.showMinimized()
            }
        }
    }

//    StackView {
//        id: mainStackView
//        anchors.fill: parent
//        initialItem:temp
//    }

    Item {
        id: listItem
        width: 250
        anchors {
            top: hearderItem.bottom
            bottom: footItem.top
        }
        Rectangle {
            anchors.fill: parent
            color: "#F8F8FF"
        }
        SideBar {
            id: sideBar
            width: parent.width
            height: parent.height
        }
    }

//    Component {
//        id: temp
//        Temp {
//            width: appWindow.width
//            height: appWindow.height
//        }
//    }

    Item {
        id: footItem
        width: parent.width
        height: 50
        anchors.bottom: parent.bottom
        Rectangle {
            id: footerBackgroundRec
            anchors.fill: parent
            color: "lightyellow"
        }
        FootBar {
            width: parent.width
            height: parent.height
        }
    }
}
