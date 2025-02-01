import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Controls.Material 2.1
import QtQuick.Effects
import io.qt.textproperties 1.0

Window {

    width: 640
    height: 580
    visible: true
    title: qsTr("Hello World")
    color: "#232323"

    Debloater{
        id: debloater
    }

    FontLoader {
        id: productsans
        source: "qrc:/res/fonts/ProductSansRegular.ttf"

    }

    Rectangle {
        id: mainPage
        width: parent.width
        height: parent.height
        color: "#232323"

        Text {
            id: welcome_main
            text: "Welcome To"
            font.family: productsans.name
            font.pixelSize: 26
            font.bold: true
            color: "white"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: parent.height / 5.3
        }
        Text {
            text: "Android Debloater !"
            font.family: productsans.name
            font.pixelSize: 36
            font.bold: true
            color: "white"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: parent.height / 3.7
        }
        Button {
            id: next_but
            text: "Next"
            font.family: productsans.name
            width: 100
            height: 60
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: parent.height / 2

            background: Rectangle {
                radius: 6
                color: customButton.down ? "#1E88E5" : (customButton.hovered ? "#42A5F5" : "#2196F3")
                border.color: "#fff"
                border.width: 2
            }
            font.pixelSize: 16


            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    mainPage.visible = false
                    deviceCheck.visible = true

                }
            }
        }
    }

    Rectangle {
        id: deviceCheck
        width: parent.width
        height: parent.height
        visible: false
        color: "#232323"

        Text {
            text: "Check for connected device"
            font.family: productsans.name
            font.pixelSize: 26
            font.bold: true
            color: "white"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: parent.height / 5.3
        }

        BusyIndicator {
            id: busyIndicator
            anchors.top: parent.top
            visible: false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: parent.height / 3.5
        }

        Button {
            text: "Check"
            font.family: productsans.name
            width: 100
            height: 60
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: parent.height / 2

            background: Rectangle {
                radius: 6
                color: customButton.down ? "#1E88E5" : (customButton.hovered ? "#42A5F5" : "#2196F3")
                border.color: "#fff"
                border.width: 2
            }
            font.pixelSize: 16

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    busyIndicator.visible = true
                    checkDeviceTimer.start()

                }
            }
        }

        Timer {
            id: checkDeviceTimer
            interval: 2000
            running: false
            onTriggered: {
                busyIndicator.visible = false
                var device = debloater.check_device()
                if (device === "No devices connected."){
                    connectedDevice.text = device
                }
                else{
                    connectedDevice.text = "Connected device : " + device
                    deviceCheck.visible = false
                    searchPage.visible = true
                    }
            }
        }

    }

    Rectangle{
        id : searchPage
        width: parent.width
        height: parent.height
        visible: false
        color: "#232323"

        Text {
            text: "Which Application you would like to uninstall"
            font.family: productsans.name
            font.pixelSize: 20
            font.bold: true
            color: "white"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin:parent.height / 20

        }

        Label{
            id : connectedDevice
            font.family: productsans.name
            font.pixelSize: 16
            font.bold: true
            color: "white"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: parent.height / 3

        }
        TextField {
            id: appName
            placeholderText : "Search"
            placeholderTextColor: "#888"
            width: parent.width / 2
            height: 40
            font.family: productsans.name
            font.pixelSize: 16
            color: "#000"
            background: Rectangle {
                color: "#fff"
                radius: 6
                border.color: "#ccc"
                border.width: 1
            }
            onPressed: appName.placeholderText=""
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: parent.width / 6
            anchors.topMargin: parent.height / 6.5

        }

        Button{
            id: customButton
            text: "Search"
            width: 100
            height: 50
            font.family: productsans.name
            font.pixelSize: 16
            background: Rectangle {
                radius: 6
                color: customButton.down ? "#1E88E5" : (customButton.hovered ? "#42A5F5" : "#2196F3")
                border.color: "#fff"
                border.width: 2
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {

                    debloater.app_name(appName.text)
                    searchPage.visible = false
                    packagePage.visible = true

                }
            }
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: parent.width / 1.4
            anchors.topMargin: parent.height / 6.8
        }





    }

    // Rectangle{
    //     id : searching
    //     width: parent.width
    //     height: parent.height
    //     visible: false
    //     color: "#232323"
    //     Text {
    //         text: "Searching"
    //         font.pixelSize: 16
    //         font.bold: true
    //         color: "white"
    //         anchors.top: parent.top
    //         anchors.horizontalCenter: parent.horizontalCenter
    //         anchors.topMargin: 150
    //     }


    // }

    Rectangle{
        id: packagePage
        width: parent.width
        height: parent.height
        visible: false
        color: "#232323"


            ListView {
                id: packageListView
                anchors.fill: parent
                anchors.top: parent.top
                anchors.left : parent.left
                anchors.leftMargin: 60
                anchors.topMargin :100
                model: ListModel {
                    id: packageModel
                }

                delegate: Item {
                    width: 400
                    height: 40

                    Rectangle {
                        width: parent.width
                        height: parent.height
                        color: "#2E2E2E"
                        border.color: "#AAAAAA"

                        Text {
                            text: model.packageName
                            color: "white"
                            anchors.centerIn: parent
                        }
                    }
                }
            }

            Button {
                text: "Load Packages"
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    packageModel.clear();

                           var packages = debloater.load_pkgs();
                           for (var i = 0; i < packages.length; i++) {
                               packageModel.append({ "packageName": packages[i] });
                           }
                }
            }


    }
}
