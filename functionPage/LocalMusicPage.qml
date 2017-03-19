import QtQuick 2.6
import QtQuick.Controls 1.4
import QtQml.Models 2.2
import "../ui"
import Material 0.2 as Material
import QtQuick.Dialogs 1.2

Item {
    id: localMusicPage
    property string pageName: "qrc:/functionPage/LocalMusicPage.qml"
    property int songNum: localMusicFunction.localMusicNums
    Rectangle {
        id: backgroundRec
        anchors.fill: parent
        color: "#FCFCFC"
    }

    FileDialog {
        id: fileDialog
        title: "选择添加目录——MediaPlayer"
        folder: shortcuts.home
        selectFolder: true
        onAccepted: {
            console.log("You chose: " + fileDialog.folder)
            searchPathFunc.addPath(fileDialog.folder, true)
        }
        onRejected: {
            console.log("Canceled")
        }
    }

    FDialog {
        id: choosePathDialog
        overlayLayer: "dialogOverlay"
        width: 360
        height: 400
        contentMargins: 20
        titlePixsize: 26
        title: "选择本地音乐文件夹"
        positiveButtonText: "添加文件夹"
        negativeButtonText: "确认"
        onRejected: {
            close()
            localMusicFunction.startSearchMusics();
            console.log("~~~~" + localMusicFunction.localMusicModel.rowCount())
        }
        onAccepted: {
            fileDialog.open()
        }
        ListView {
            id: pathListView
            width: choosePathDialog.width
            height: 242
            clip: true
            contentHeight: childrenRect.height
            spacing: 10
            x: 20
            y: 80
            Component.onCompleted: console.log("height is: " + height)
            model: searchPathFunc.searchPath
            //snapMode: ListView.SnapToItem
            delegate: Item {
                width: parent.width
                height: 30
                Material.CheckBox {
                    id: checkbox
                    width: 50
                    height: 50
                    anchors {
                        left: parent.left
                    }
                    checked: model.opened
                    //Component.onCompleted: checked = model.opened
                    onClicked: {
                        console.log("checked is " + checked)
                        searchPathFunc.enablePath(model.path, checked)
                    }
                }
                Text {
                    id: pathText
                    anchors.left: checkbox.right
                    anchors.verticalCenter: checkbox.verticalCenter
                    text: model.path
                    verticalAlignment: Text.AlignHCenter
                }
            }
        }
    }

    Item {
        id: titleItem
        height: 30
        anchors {
            top: parent.top
            topMargin: 20
            left: parent.left
            leftMargin: 30
        }
        Row {
            anchors.fill: parent
            spacing: 10
            Text {
                text: "本地音乐"
                height: 30
                font {
                    pixelSize: 22
                }
                color: "#000"
                verticalAlignment: Text.AlignBottom
            }
            Text {
                text: songNum + "首音乐,"
                height: 30
                font.pixelSize: 15
                opacity: 0.5
                verticalAlignment: Text.AlignBottom
            }
            Text {
                text: "选择目录"
                height: 30
                color: "blue"
                font.pixelSize: 15
                verticalAlignment: Text.AlignBottom
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        choosePathDialog.show()
                    }
                }
            }
        }
    }
    ThinDivider {
        id: divider
        width: parent.width
        anchors.top: titleItem.bottom
        anchors.topMargin: 5
    }

    Button {
        id: playAllBtn
        width: 100
        height: 28
        anchors {
            left: parent.left
            leftMargin: 30
            top: divider.bottom
            topMargin: 10
        }
        text: "播放全部"
    }
    Button {
        id: addToPlayListBtn
        width: 30
        height: 28
        anchors {
            left: playAllBtn.right
            top: playAllBtn.top
        }
        text: "+"
    }

    //搜索条
    Rectangle {
        id: searchBar
        width: 200
        height: 28
        radius: 14
        anchors.right: parent.right
        anchors.rightMargin: 30
        anchors.top: divider.bottom
        anchors.topMargin: 10
        border.color: "#F5F5DC"
        border.width: 1

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

    ThinDivider {
        id: thindivider
        width: parent.width
        anchors.top: searchBar.bottom
        anchors.topMargin: 10
    }

    TreeView {
        id: localMusicList
        model: localMusicFunction.localMusicModel
        selectionMode: SelectionMode.SingleSelection
        anchors {
            top: thindivider.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        width: parent.width
        onDoubleClicked: {
            console.log("index is " + index)
            mediaPlayer.addMedia(localMusicFunction.getIndexPath(index));
        }
        //selection: sel

        TableViewColumn {
            title: "序号"
            role: "index"
            resizable: true
            width: 50
        }
        TableViewColumn {
            title: "音乐标题"
            role: "musicName"
            resizable: true
            width: 200
        }
        TableViewColumn {
            title: "歌手"
            role: "singer"
            resizable: true
            width: 180
        }
        TableViewColumn {
            title: "时长"
            role: "musicTime"
            resizable: true
            width: 90
        }
        TableViewColumn {
            title: "专辑"
            role: "album"
            resizable: true
            width: 190
        }
        TableViewColumn {
            title: "格式"
            role: "format"
            resizable: true
            width: 42
        }
    }

    ItemSelectionModel {
        id: sel
        model: localMusicFunction.localMusicModel
    }
}
