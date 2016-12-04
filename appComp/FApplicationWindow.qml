/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014-2015 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, either version 2.1 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.4
import QtQuick.Controls 1.3 as Controls
import QtQuick.Window 2.2
import Material 0.2
import Material.Extras 0.1
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4

/*!
   \qmltype ApplicationWindow
   \inqmlmodule Material

   \brief A window that provides features commonly used for Material Design apps.

   This is normally what you should use as your root component. It provides a \l Toolbar and
   \l PageStack to provide access to standard features used by Material Design applications.

   Here is a short working example of an application:

   \qml
   import QtQuick 2.4
   import Material 0.2

   ApplicationWindow {
       title: "Application Name"

       initialPage: page

       Page {
           id: page
           title: "Page Title"

           Label {
               anchors.centerIn: parent
               text: "Hello World!"
           }
       }
   }
   \endqml
*/
Controls.ApplicationWindow {
    id: app

    /*!
       Set to \c true to include window decorations in your app's toolbar and hide
       the regular window decorations header.
     */
    property bool clientSideDecorations: false

    /*!
       \qmlproperty Page initialPage

       The initial page shown when the application starts.
     */
    property alias initialPage: __pageStack.initialItem

    /*!
       \qmlproperty PageStack pageStack

       The \l PageStack used for controlling pages and transitions between pages.
     */
    property alias pageStack: __pageStack

    /*!
       \qmlproperty AppTheme theme

       A grouped property that allows the application to customize the the primary color, the
       primary dark color, and the accent color. See \l Theme for more details.
     */
    property alias theme: __theme

    property int bottomBarHeight: 54

    AppTheme {
        id: __theme
    }

//    PlatformExtensions {
//        id: platformExtensions
//        decorationColor: __toolbar.decorationColor
//        window: app
//    }

    PageStack {
        id: __pageStack
        property string currentSource;
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: bottomBar.top
        }
        delegate:currentItem == initialItem?destopShow: slideRightLeft
        onCurrentItemChanged: {
            if(currentItem){
                currentSource = currentItem.appId
            }
        }
    }

    OverlayLayer {
        id: dialogOverlayLayer
        objectName: "dialogOverlayLayer"
    }

//    OverlayLayer {
//        id: tooltipOverlayLayer
//        objectName: "tooltipOverlayLayer"
//    }

    OverlayLayer {
        id: overlayLayer
    }

    Item{
        id:bottomBar
        width: parent.width
        height:bottomBarHeight
        anchors.bottom: parent.bottom
    }

    /*!
       Show an error in a dialog, with the specified secondary button text (defaulting to "Close")
       and an optional retry button.

       Returns a promise which will be resolved if the user taps retry and rejected if the user
       cancels the dialog.
     */
    function showError(title, text, secondaryButtonText, retry) {
        if (errorDialog.promise) {
            errorDialog.promise.reject()
            errorDialog.promise = null
        }

        errorDialog.negativeButtonText = secondaryButtonText ? secondaryButtonText : "Close"
        errorDialog.positiveButton.visible = retry || false

        errorDialog.promise = new Promises.Promise()
        errorDialog.title = title
        errorDialog.text = text
        errorDialog.open()

        return errorDialog.promise
    }

    Component.onCompleted: {
//        if (clientSideDecorations)
//            flags |= Qt.FramelessWindowHint

//        function calculateDiagonal() {
//            return Math.sqrt(Math.pow((Screen.width/Screen.pixelDensity), 2) +
//                    Math.pow((Screen.height/Screen.pixelDensity), 2)) * 0.039370;
//        }

//        Units.pixelDensity = Qt.binding(function() {
//            return Screen.pixelDensity
//        });

//        Units.multiplier = Qt.binding(function() {
//            var diagonal = calculateDiagonal();
//            var baseMultiplier = platformExtensions.multiplier
//            console.log("multiplier diagonal:"+diagonal+",baseMultiplier:"+baseMultiplier)
//            if (diagonal >= 3.5 && diagonal < 5) { //iPhone 1st generation to phablet
//                return baseMultiplier;
//            } else if (diagonal >= 5 && diagonal < 6.5) {
//                return baseMultiplier;
//            } else if (diagonal >= 6.5 && diagonal < 10.1) {
//                return baseMultiplier;
//            } else if (diagonal >= 10.1 && diagonal < 29) {
//                return 1.4 * baseMultiplier;
//            } else if (diagonal >= 29 && diagonal < 92) {
//                return 1.4 * baseMultiplier;
//            } else {
//                return 1.4 * baseMultiplier;
//            }
//        });

//        Device.type = Qt.binding(function () {
//            var diagonal = calculateDiagonal();

//            if (diagonal >= 3.5 && diagonal < 5) { //iPhone 1st generation to phablet
//                return Device.phone;
//            } else if (diagonal >= 5 && diagonal < 6.5) {
//                return Device.phablet;
//            } else if (diagonal >= 6.5 && diagonal < 10.1) {
//                return Device.tablet;
//            } else if (diagonal >= 10.1 && diagonal < 29) {
//                return Device.desktop;
//            } else if (diagonal >= 29 && diagonal < 92) {
//                return Device.tv;
//            } else {
//                return Device.unknown;
//            }
//        });

//        // Nasty hack because singletons cannot import the module they were declared in, so
//        // the grid unit cannot be defined in either Device or Units, because it requires both.
//        Units.gridUnit = Qt.binding(function() {
//            var isPortrait = app.width < app.height
//            if (Device.type === Device.phone || Device.type === Device.phablet) {
//                return isPortrait ? Units.dp(56) : Units.dp(48)
//            } else if (Device.type == Device.tablet) {
//                return Units.dp(64)
//            } else {
//                return Device.hasTouchScreen ? Units.dp(64) : Units.dp(48)
//            }
//        })
    }

    property StackViewDelegate destopShow: StackViewDelegate {
            pushTransition: StackViewTransition {
                PropertyAnimation {
                    target: exitItem
                    property: "y"
                    from: 0
                    to: target.height
                    duration: 350
                }

                PropertyAnimation {
                    target: exitItem
                    property: "z"
                    to: 0
                    duration: 0
                }

                PropertyAnimation {
                    target: exitItem
                    property: "opacity"
                    to: 1
                    duration: 0
                }

                ///
                PropertyAnimation {
                    target: enterItem
                    property: "y"
                    from: 80
                    to: 0
                    duration: 0
                }

                PropertyAnimation {
                    target: enterItem
                    property: "scale"
                    easing.type: Easing.OutQuart
                    from: 0.7
                    to: 1
                    duration: 750
                }

                PropertyAnimation {
                    target: enterItem
                    property: "z"
                    from: 0
                    to: 0
                    duration: 450
                }

                PropertyAnimation {
                    target: enterItem
                    property: "opacity"
                    from: 0.4
                    to: 1
                    duration: 450
                }
            }
        }

    property StackViewDelegate slideRightLeft: StackViewDelegate {
            pushTransition: StackViewTransition {
                PropertyAnimation {
                    target: enterItem
                    property: "y"
                    from:552//target.height
                    to: 0
                    duration: 650
                    easing.type: Easing.OutQuart
                }

                PropertyAnimation {
                    target: enterItem
                    property: "z"
                    from: 0
                    to: 2
                    duration: 0
                }

                PropertyAnimation {
                    target: enterItem
                    property: "opacity"
                    from: 0.8
                    to: 1
                    duration: 650
                }

                PropertyAnimation {
                    target: enterItem
                    property: "scale"
                    from: 0.8
                    to: 1
                    duration: 0
                }

                //
                PropertyAnimation {
                    target: exitItem
                    property: "y"
                    easing.type: Easing.OutQuint
                    from: 0
                    to: 30
                    duration: 450
                }

                PropertyAnimation {
                    target: exitItem
                    property: "scale"
                    from: 1
                    to: 0.9
                    duration:250
                }

                PropertyAnimation {
                    target: exitItem
                    property: "z"
                    from: 2
                    to: 0
                    duration: 200
                }

                PropertyAnimation {
                    target: exitItem
                    property: "opacity"
                    from: 1
                    to: 0
                    duration: 200
                }
            }
        }


}
