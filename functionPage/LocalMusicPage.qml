import QtQuick 2.6
import QtQuick.Controls 1.4
import QtQml.Models 2.2
import "../ui"

Item {
    id: localMusicPage
    property string pageName: "qrc:/functionPage/LocalMusicPage.qml"
    property int songNum: 0
    Rectangle {
        id: backgroundRec
        anchors.fill: parent
        color: "#FCFCFC"
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
                    onClicked: {}
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
        model: listModel
        selectionMode: SelectionMode.SingleSelection
        anchors {
            top: thindivider.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        selection: sel

//        itemDelegate: Item {
//            Rectangle {
//                anchors.fill: parent
//                color: "blue"
////                Text {
////                    anchors.verticalCenter: parent.verticalCenter
////                    color: styleData.textColor
////                    elide: styleData.elideMode
////                    text: styleData.value
////                }
//            }
//        }

        TableViewColumn {
            title: "Name"
            role: "name"
            resizable: true
        }
        TableViewColumn {
            title: "Type"
            role: "type"
            resizable: true
        }
        TableViewColumn {
            title: "Age"
            role: "age"
            resizable: true
        }
        TableViewColumn {
            title: "Size"
            role: "size"
            resizable: true
        }

    }

    ItemSelectionModel {
        id: sel
        model: listModel
    }

    ListModel {
        id: listModel
        ListElement {
            name: "Polly"
            type: "Parrot"
            age: 12
            size: "Small"
        }
        ListElement {
            name: "Penny"
            type: "Turtle"
            age: 4
            size: "Small"
        }
    //![0]
        ListElement {
            name: "Warren"
            type: "Rabbit"
            age: 2
            size: "Small"
        }
        ListElement {
            name: "Spot"
            type: "Dog"
            age: 9
            size: "Medium"
        }
        ListElement {
            name: "Schrödinger"
            type: "Cat"
            age: 2
            size: "Medium"
        }
        ListElement {
            name: "Joey"
            type: "Kangaroo"
            age: 1
            size: "Medium"
        }
        ListElement {
            name: "Kimba"
            type: "Bunny"
            age: 65
            size: "Large"
        }
        ListElement {
            name: "Rover"
            type: "Dog"
            age: 5
            size: "Large"
        }
        ListElement {
            name: "Tiny"
            type: "Elephant"
            age: 15
            size: "Large"
        }
    //![1]
    }
}
