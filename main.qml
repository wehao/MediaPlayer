import QtQuick 2.5
import QtQuick.Controls 1.4
import Qt.labs.controls 1.0
import Material 0.2 as Material
import "./music"
import "./ui"

Item {
    id: appWindow
    visible: true
    width: 1024
    height: 670
    property color mainColor: "#aa2116"
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
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                width: 40
                height: 40
                iconSize: 40
                iconSource: "qrc:/res/icons/ic_quit.svg"
                iconColor: hoverd?"white":"#C7C7C7"
                colorize: true
                onItemClicked: MainApp.close();
            }
            IconButton {
                id: minBtn
                anchors.right: quitBtn.left
                anchors.verticalCenter: parent.verticalCenter
                width: 40
                height: 40
                iconSize: 40
                iconSource: "qrc:/res/icons/ic_quit.svg"
                iconColor: hoverd?"white":"#C7C7C7"
                colorize: true
                onItemClicked: MainApp.showMinimized()
            }

            //搜索条
            Rectangle {
                width: 300
                height: 28
                radius: 14

                anchors.left: parent.left
                anchors.leftMargin: 300
                anchors.verticalCenter: parent.verticalCenter


                //输入框
                TextInput {
                    id:input
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    anchors.right: searchButton.left
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize:15
                    clip: true

                    //输入改变
                    onTextChanged:{
                        if(text === ""){
                            suggestion.hide();
                            return;
                        }
                       baiduMusic.getSuggestion(text)
                    }

                    onFocusChanged: {
                        if(!focus){
                            suggestion.hide();
                        }
                    }

                    //编辑完成，按enter键
                    onAccepted :{
                        search();
                    }
                }

                //搜索按钮
                Rectangle {
                    id:searchButton
                    height: 20
                    width: 20
                    anchors.right: parent.right
                    anchors.rightMargin: 14
                    anchors.verticalCenter: parent.verticalCenter
                    Image {
                        id: searchIcon
                        anchors.fill: parent
                        source: "qrc:/res/icons/search.png"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:  search()
                    }
                }
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
