import QtQuick 2.4
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
        anchors.top: myMusicText.bottom
        height: 30
        text: "在线音乐"
        imageSource: "qrc:/res/icons/ic_music.svg"
    }
    IconText {
        id: localMusic
        width: parent.width
        anchors.top: onLineMusic.bottom
        height: 30
        text: "在线音乐"
        imageSource: "qrc:/res/icons/ic_music_note.svg"
    }
}
