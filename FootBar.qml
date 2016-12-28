import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.1
import "./ui"

Item {

    IconButton {
        id: previewBtn
        width: 36
        height: 36
        anchors {
            verticalCenter: parent.verticalCenter
            right: playingBtn.left; rightMargin: 40
        }
        backgroundColor: "red"
        radius: width/2
        iconSource: "qrc:/res/icons/ic_play_arrow.svg"
    }
    IconButton {
        id: playingBtn
        width: 40
        height: 40
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left; leftMargin: 105
        }
        radius: width/2
        iconSource: "qrc:/res/icons/ic_play_arrow.svg"
    }
    IconButton {
        id: nextBtn
        width: 36
        height: 36
        anchors {
            verticalCenter: parent.verticalCenter
            left: playingBtn.right; leftMargin: 40
        }
        radius: width/2
        iconSource: "qrc:/res/icons/ic_play_arrow.svg"
    }
}
