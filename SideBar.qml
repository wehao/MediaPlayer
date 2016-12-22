import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.1
import "./ui"

Flickable {
    id: sideBar
//    width: parent.width
//    height: parent.height
    Text {
        id: myMusicText
        width: parent.width
        height: 30
        x: 10
        text:"我的音乐"
        font.pixelSize: 20
        color: "black"
        opacity: 0.6
    }
    IconText {
        id: onLineMusic
        width: parent.width
        anchors.top: myMusicText.bottom;
        anchors.topMargin: 5
        height: 30
        text: "在线音乐"
        imageSource: "qrc:/res/icons/ic_music.svg"
    }
    IconText {
        id: localMusic
        width: parent.width
        anchors.top: onLineMusic.bottom
        height: 30
        text: "本地音乐"
        imageSource: "qrc:/res/icons/ic_music_note.svg"
    }

    Item {
        id: createMusicListItem
        width: parent.width
        height: 30
        anchors.top: localMusic.bottom
        anchors.topMargin: 15
        Text {
            id: listText
            height: parent.height
            anchors.left: parent.left
            anchors.leftMargin: 10
            text: "创建的歌单"
            font.pixelSize: 18
            opacity: 0.6
        }
        Button {
            id: addList
            width: 16
            height: 16
            anchors {
                right: dropBtn.left; rightMargin: 4
                verticalCenter: parent.verticalCenter
            }
            opacity: hovered? 1:0.3
            text: "+"
            style: ButtonStyle {
                background: Rectangle {
                    anchors.fill: parent
                    color: "yellow"
                }
            }
            onClicked: console.log("kkk")
        }

        Button {
            id: dropBtn
            width: 16
            height: 16
            anchors {
                right: parent.right; rightMargin: 15
                verticalCenter: parent.verticalCenter
            }
            text: ">"
            opacity: hovered? 1:0.3
            style: ButtonStyle {
                background: Rectangle {
                    anchors.fill: parent
                    color: "yellow"
                }
            }
        }
    }

    ListView {
        id: musicListView
        anchors.top: createMusicListItem.bottom
        anchors.topMargin: 5
        width: parent.width
        height: 360
    }

    Item {
        id: musicInfo
        width: parent.width
        height: 65
        anchors {
            bottom: parent.bottom
        }
        Image {
            id: albumImage
            width: parent.height
            height: width
            source: "qrc:/res/icons/temp.jpg"
        }
        Item {
            id: songInfo
            anchors {
                left: albumImage.right; leftMargin: 5
            }
            width: 135
            height: parent.height
            Text {
                id: songNameText
                width: parent.width
                height: parent.height/2
                anchors.top: parent.top
                text: "name"
                verticalAlignment: Text.AlignBottom
                font.pixelSize: 24
            }
            Text {
                id: artistText
                width: parent.width
                height: parent.height/2
                anchors.bottom: parent.bottom
                text: "name"
                verticalAlignment: Text.AlignTop
                font.pixelSize: 18
            }
        }
        IconButton {
            id: favoriteBtn
            width: 30
            height: 30
            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right; rightMargin: 10
            }

            property bool collection: false
            iconSource: "qrc:/res/icons/favorite.svg"
            backgroundColor: "#F8F8FF"
            iconColor: "#FF3030"
            opacity: hovered? 0.6:0.3
            colorize: collection
            onClicked: {
                collection = !collection
            }
        }
        Rectangle {
            anchors.fill: parent
            border.color: "#D4D4D4"
            border.width: 1
            color: "transparent"
        }
    }
}
