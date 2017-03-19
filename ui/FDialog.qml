/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2014-2016 Michael Spencer <sonrisesoftware@gmail.com>
 *               2015 Bogdan Cuza <bogdan.cuza@hotmail.com>
 *               2015 Mikhail Ivchenko <ematirov@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import QtQuick.Layouts 1.1
import Material 0.3 as Material
import Material.Extras 0.1

/*!
   \qmltype Dialog
   \inqmlmodule Material
   \brief Dialogs inform users about critical information, require users to make
   decisions, or encapsulate multiple tasks within a discrete process
 */
Material.PopupBase {
    id: dialog
    property real unitsdp: 1

    overlayLayer: "dialogOverlayLayer"
    overlayColor: Qt.rgba(0, 0, 0, 0.3)

    opacity: showing ? 1 : 0
    visible: opacity > 0

    //width: dialogContainer.width + 2 * contentMargins

//    height: Math.min(parent.height - 64 * platformdp,
//                     headerView.height +
//                     content.contentHeight +
//                     (floatingActions ? 0 : buttonContainer.height))
        //height: headerView.contentHight  + (floatingActions ? 0 : buttonContainer.height)

        //Component.onCompleted: console.log("jjj" + dialog.width)

    property int contentMargins: 48

    property alias title: titleLabel.text
    property alias titlePixsize: titleLabel.font.pixelSize
    property alias buttonContainer: buttonContainer

    property alias text: textLabel.text

    /*!
       \qmlproperty Button negativeButton
       The negative button, displayed as the leftmost button on the right of the dialog buttons.
       This is usually used to dismiss the dialog.
     */
    property alias negativeButton: negativeButton

    /*!
       \qmlproperty Button primaryButton
       The primary button, displayed as the rightmost button in the dialog buttons row. This is
       usually used to accept the dialog's action.
     */
    property alias positiveButton: positiveButton

    property string negativeButtonText: "Cancel"
    property string positiveButtonText: "Ok"
    property alias positiveButtonEnabled: positiveButton.enabled

    property bool hasActions: true
    property bool floatingActions: false

//    default property alias dialogContent: column.data

    signal accepted()
    signal rejected()

    anchors {
        centerIn: parent
        verticalCenterOffset: showing ? 0 : -(dialog.height/3)

        Behavior on verticalCenterOffset {
            NumberAnimation { duration: 200 }
        }
    }

    Behavior on opacity {
        NumberAnimation { duration: 200 }
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Escape) {
            closeKeyPressed(event)
        }
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Back) {
            closeKeyPressed(event)
        }
    }

    function closeKeyPressed(event) {
        if (dialog.showing) {
            if (dialog.dismissOnTap) {
                dialog.close()
            }
            event.accepted = true
        }
    }

    function show() {
        open()
    }

    Material.View {
        id: dialogContainer
        anchors.fill: parent
        elevation: 5
        radius: 2 * unitsdp
        backgroundColor: "white"

        MouseArea{
            anchors.fill: parent
            propagateComposedEvents: false
            onClicked: {
                mouse.accepted = false
            }
        }
        Column {
            id: headerView
            spacing: 0
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                leftMargin: contentMargins
                rightMargin: contentMargins
            }
            Item {
                width: parent.width
                height: contentMargins
                visible: titleLabel.visible || textLabel.visible
            }
            Text{
                id: titleLabel
                width: parent.width
                wrapMode: Text.Wrap
                visible: title != ""
                font.family: "Roboto"
                font.pixelSize: 32
                font.weight: Font.Medium
            }
            Item {
                width: parent.width
                height: 24
                visible: titleLabel.visible
            }
            Text{
                id: textLabel
                width: parent.width
                wrapMode: Text.Wrap
                color: Qt.rgba(0,0,0,0.54)
                visible: text != ""
                font.family: "Roboto"
                font.pixelSize: 28
                font.weight: Font.Medium
            }
            Item {
                width: parent.width
               // height: 32
                height: 13
                visible: textLabel.visible
            }
        }

        Item {
            id: buttonContainer
            height:40
            anchors {
                right: parent.right
                left: parent.left
                bottom: parent.bottom
                bottomMargin: 20
            }
            Material.View {
                id: buttonView
                height: parent.height
                backgroundColor:floatingActions ? "transparent" : "white"
                fullWidth: true
                radius: dialogContainer.radius
                elevationInverted: true
                anchors {
                    right: parent.right
                    left: parent.left
                }
                Material.Button {
                    id: negativeButton
                    height: parent.height
                    width: 100
                    text: negativeButtonText
                    anchors {
                        verticalCenter: parent.verticalCenter
                        right: positiveButton.visible ? positiveButton.left : parent.right
                        rightMargin:16
                    }
                    onClicked: {
                        rejected();
                    }
                }
                Material.Button {
                    id: positiveButton
                    height: parent.height
                    width: 100
                    text: positiveButtonText
                    anchors {
                        verticalCenter: parent.verticalCenter
                        rightMargin: 72
                        right: parent.right
                    }
                    onClicked: {
                        accepted();
                    }
                }
            }
        }

    }
}
