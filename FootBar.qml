import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.1
import "./ui"

Item {
    id: footBarItem
    property bool playing: mediaPlayer.playState
    IconButton {
        id: previewBtn
        width: 36
        height: 36
        anchors {
            verticalCenter: parent.verticalCenter
            right: playingBtn.left; rightMargin: 40
        }
        //backgroundColor: "red"
        iconSource: "qrc:/res/icons/ic_skip_previous.svg"
        iconColor: "white"
        colorize: true
        iconRadius: width/2
    }
    IconButton {
        id: playingBtn
        width: 44
        height: 44
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left; leftMargin: 105
        }
        radius: width/2
        iconSource: footBarItem.playing?"qrc:/res/icons/ic_pause.svg":"qrc:/res/icons/ic_play_arrow.svg"
        iconColor: "white"
        colorize: true
        iconRadius: width/2
        onItemClicked: {
            mediaPlayer.play()
        }
    }
    IconButton {
        id: nextBtn
        width: 36
        height: 36
        anchors {
            verticalCenter: parent.verticalCenter
            left: playingBtn.right; leftMargin: 40
        }
        iconSource: "qrc:/res/icons/ic_skip_next.svg"
        iconColor: "white"
        colorize: true
        iconRadius: width/2
        iconSize: 20
    }

    ProgressBar {
        id: progressBar
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: nextBtn.right
        anchors.leftMargin: 40
        width: 450
        height: 30
        color: mainColor
    }

    VolumeBar {
        id: volBar
        anchors.left: progressBar.right
        anchors.verticalCenter: parent.verticalCenter
        width: 180
        height: 30
        color: mainColor
        property int volValue: value
        value: mediaPlayer.volumn
        onVolValueChanged: {
            mediaPlayer.volumn = volValue
        }
        //Slider {}
    }

    IconButton {
        id: playModeBtn
        anchors.left: volBar.right
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        width: 30
        height: 30
        backgroundColor: "lightyellow"
        iconColor: "black"
        colorize: true
        iconSource: "qrc:/res/icons/repeat.svg"
    }

//    IconButton {
//        id: lyricBtn
//        anchors.left: playModeBtn.right
//        anchors.leftMargin: 12
//        anchors.verticalCenter: parent.verticalCenter
//        width: 30
//        height: 30
//        backgroundColor: "lightyellow"
//        iconColor: "black"
//        colorize: true
//        iconSource: "qrc:/res/icons/repeat.svg"
//    }
    Text {
        id: lyricBtn
        anchors.left: playModeBtn.right
        anchors.leftMargin: 12
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -6
        width: 30
        height: 30
        text: "词"
        //verticalAlignment: Text.AlignHCenter
        font.pixelSize: 26
    }

    IconButton {
        id: playListBtn
        anchors.left: lyricBtn.right
        anchors.leftMargin: 12
        anchors.verticalCenter: parent.verticalCenter
        width: 30
        height: 30
        backgroundColor: "lightyellow"
        iconColor: "black"
        colorize: true
        iconSource: "qrc:/res/icons/media_playlist.svg"
    }
}
