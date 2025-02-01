import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Controls.Material 2.1
import QtQuick.Effects
import io.qt.textproperties 1.0

Window {

    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    color: "#232323"

    Debloater{
        id: debloater
    }

    Rectangle {
        id: mainPage
        width: parent.width
        height: parent.height
        color: "#232323"

        Text {
            id: welcome_main
            text: "Welcome To"
            font.pixelSize: 26
            font.bold: true
            color: "white"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: parent.height / 5.3
        }
        Text {
            text: "Android Debloater !"
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
                    searchPage.visible = true
                    welcome_main.text = debloater.debloat()

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
            font.pixelSize: 16
            font.bold: true
            color: "white"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin:10
        }



            TextField {
                id: appName
                placeholderText : "Search"
                placeholderTextColor: "#888"
                width: 300
                height: 40
                font.pixelSize: 16
                color: "#000"
                background: Rectangle {
                    color: "#fff"
                    radius: 6
                    border.color: "#ccc"
                    border.width: 1
                }
                onPressed: appName.placeholderText=""
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 120

            }

            Button{
                id: customButton
                text: "Search"
                width: 100
                height: 50
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
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 460
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
