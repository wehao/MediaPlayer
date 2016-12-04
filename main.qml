import QtQuick 2.5
import QtQuick.Controls 1.4
import Qt.labs.controls 1.0
import "./music"
import "./ui"

ApplicationWindow {
    id: appWindow
    visible: true
    width: 1024
    height: 670
    title: qsTr("MediaPlayer")
    flags: Qt.Window | Qt.FramelessWindowHint
    header: Item {
        id: hearderItem
        width: parent.width
        height: 50
        Rectangle {
            id: backgroundRec
            anchors.fill: parent
            color: "red"
            MouseArea {
                anchors.fill: parent
                property point clickPos: "0,0"

                onPressed: {
                    clickPos = Qt.point(mouse.x, mouse.y)
                }
                onPositionChanged: {
                    var delta = Qt.point(mouse.x - clickPos.x, mouse.y - clickPos.y)
                    appWindow.setX(appWindow.x + delta.x, appWindow.y + delta.y)
                }
            }
//            Button {
//                id: quitBtn
//                width: 50
//                height: 50
//                text: "X"
//                anchors {
//                    right: parent.right
//                }
//                onClicked: {
//                    Qt.quit()
//                }
//            }
            IconButton {
                id: quitBtn
                anchors.right: parent.right
                width: 50
                height: 50
                iconSource: "qrc:/res/icons/ic_quit.svg"
                colorize: true
                iconSize: 30
                onClicked: Qt.quit()
                onHoveredChanged: {
                    if(hovered)
                        iconColor = "white"
                    else iconColor = "gray"
                }
                iconColor: "gray"
            }
            IconButton {
                id: maxBtn
                anchors.right: quitBtn.left
                width: 50
                height: 50
                iconSize: 30
                iconSource: "qrc:/res/icons/ic_quit.svg"
                onHoveredChanged: {
                    if(hovered)
                        iconColor = "white"
                    else iconColor = "gray"
                }
                iconColor: "gray"
                colorize: true
                onClicked: Qt.MaximumSize
            }
            IconButton {
                id: minBtn
                anchors.right: maxBtn.left
                width: 50
                height: 50
                iconSize: 30
                iconSource: "qrc:/res/icons/ic_quit.svg"
                onHoveredChanged: {
                    if(hovered)
                        iconColor = "white"
                    else iconColor = "gray"
                }
                iconColor: "gray"
                colorize: true
                onClicked: appWindow.width = 0
            }
        }
    }

    StackView {
        id: mainStackView
        anchors.fill: parent
        initialItem:temp
    }

    Component {
        id: temp
        Temp {
            width: appWindow.width
            height: appWindow.height - hearderItem.height - footItem.height
        }
    }

    footer: Item {
        id: footItem
        width: parent.width
        height: 50
        Rectangle {
            id: footerBackgroundRec
            anchors.fill: parent
            color: "yellow"
        }
    }
}
