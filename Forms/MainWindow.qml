import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import Qt.labs.platform 1.0 as Source
import QtQuick.Dialogs 1.2

Item {

    id: root
    width: parent.width
    height: parent.height

    property var link_core: root.link_core
    property var listContacts: [
        {
            "image_link" : "qrc:/Graphics/neron_icon.jpg",
            "nickName" : "Dark Light Neron",
            "link" : "https://www.youtube.com/user/Neron9463/videos",
            "linkType" : "Youtube канал"
        },
        {
            "image_link" : "qrc:/Graphics/TomyRoYT.jpg",
            "nickName": "TomyRoYT",
            "link" : "https://www.youtube.com/channel/UCF0vE0MCE7LgoBLjYFhyiRA/videos",
            "linkType" : "Youtube канал"
        },
        {
            "image_link" : "qrc:/Graphics/purp1espace.jpg",
            "nickName" : "Purp1espace",
            "link" : "https://t.me/purp1espace",
            "linkType" : "Telegram"
        }

    ]

    Rectangle {
        anchors.fill: parent
        color: colors.backgroundColor

        Rectangle {
            anchors.fill: parent
            id: blackScreen
            color: "black"
            opacity: .2
            z: 5
            visible: false
            function show() { blackScreen.visible = true }
            function hide() { blackScreen.visible = false }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    leftPanel.hide()
                }
            }
        }

        RowLayout {

            z: 6
            anchors.fill: parent

            LeftPanel {
                id: leftPanel
                manager: pageManager
                width: leftPanel.closed ? 48 : 200
                Layout.fillHeight: true
                blackBackground: blackScreen
                z: 10
                onClosedChanged: {
                    if (!closed) blackScreen.show()
                    else blackScreen.hide()
                    width = closed ? 48 : 200
                }
            }

            StackView {
                Layout.fillHeight: true
                Layout.fillWidth: true
                id: mainPages
                initialItem: main
                z: 3
            }
        }

    }

    Component {
        id: main

        Item {
            id: mainPage

            anchors.fill: parent
            anchors.topMargin: 5
            anchors.bottomMargin: 5

            ColumnLayout {

                anchors.fill: parent
                spacing: 5

                Text {
                    text: "Наши контакты"
                    color: "white"
                    font.pixelSize: 28
                }

                Text {
                    text: "Наш сайт: <a style='text-decoration: overline' href='http://crashinyou.me/'>crashinyou.me</a>"
                    color: "grey"
                    font.pixelSize: 16
                    textFormat: Text.StyledText
                    linkColor: colors.colorAccent
                    onLinkActivated: Qt.openUrlExternally("http://crashinyou.me/")
                }

                Text {
                    text: "<a style='text-decoration: overline' href='https://t.me/crashinyou1'>Официальный канал команды CrashInYou</a>"
                    color: "grey"
                    font.pixelSize: 16
                    textFormat: Text.StyledText
                    linkColor: colors.colorAccent
                    onLinkActivated: Qt.openUrlExternally("https://t.me/crashinyou1")
                }

                Text {
                    text: "<a style='text-decoration: overline' href='https://t.me/crashinyouchat'>Общий чат. Здесь Вы можете обсудить что угодно</a>"
                    color: "grey"
                    font.pixelSize: 16
                    textFormat: Text.StyledText
                    linkColor: colors.colorAccent
                    onLinkActivated: Qt.openUrlExternally("https://t.me/crashinyouchat")
                }
                Text {
                    Layout.fillWidth: true
                    text: "<a style='text-decoration: overline' href='https://t.me/CrashInYouFAQ'>Официальный информационный канал команды Crash In You</a>"
                    color: "grey"
                    font.pixelSize: 16
                    textFormat: Text.StyledText
                    linkColor: colors.colorAccent
                    onLinkActivated: Qt.openUrlExternally("https://t.me/CrashInYouFAQ")
                }

                Rectangle {
                    Layout.fillWidth: true
                    height: 1
                    color: "black"
                }

                ListView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    model: root.listContacts
                    spacing: 10
                    delegate: Contact {
                        width: parent.width
                        height: 100
                        image_link: modelData["image_link"]
                        nickName: modelData["nickName"]
                        link: modelData["link"]
                        linkType: modelData["linkType"]
                    }
                }
            }
        }
    }

    Component {

        id: filter

        Item {

            id: filterPage

            property string inputFile: "";
            property string outputFile: "";

            Source.FileDialog {
                id: fileDlg
                property bool input: true
                onFileChanged: {
                    var file;
                    if (Qt.platform.os == "windows")
                        file = currentFile.toLocaleString().split("file:///")[1]
                    else file = currentFile.toLocaleString().split("file://")[1]
                    if (input) {
                        inputFile.text = file
                        filterPage.inputFile = file
                    } else {
                        outputFile.text = file
                        filterPage.outputFile = file
                    }
                }
            }

            anchors.fill: parent
            anchors.margins: 20

            ColumnLayout {

                spacing: 20
                anchors.fill: parent

                Rectangle { Layout.fillHeight: true }

                Text {
                    text: "Фильтр"
                    color: "white"
                    font.pixelSize: 24
                }

                Text {
                    Layout.fillWidth: true
                    text: "Это обновление софта, которое фильтрует вашу информацию, собранную из чекера в текстовый документ, и преобразовывает в два файла: один с ник:хеш, другой с хешами для hashcat.
Вам нужно выбрать исходный файл и файл, в который нужно сохранить отфильтрованную информацию."
                    color: "grey"
                    font.pixelSize: 18
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                }

                TextField {
                    Layout.fillWidth: true
                    id: inputFile
                    placeholderText: "Путь к основному файлу"

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            fileDlg.input = true;
                            fileDlg.fileMode = Source.FileDialog.OpenFile
                            fileDlg.open()
                        }
                    }
                }

                TextField {
                    Layout.fillWidth: true
                    id: outputFile
                    placeholderText: "Путь к файлу сохранения"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            fileDlg.input = false;
                            fileDlg.fileMode = Source.FileDialog.SaveFile
                            fileDlg.open()
                        }
                    }
                }

                Button {
                    highlighted: true
                    text: "Submit"
                    onClicked: {
                        if ( filterPage.inputFile == "" || filterPage.outputFile == "" ) {
                            textDlg.title = "Error";
                            if ( filterPage.inputFile == "" ) {
                                textDlg.text = "Отсутствует главный файл!";
                                textDlg.visible = true;
                            } if ( filterPage.outputFile == "" ) {
                                textDlg.text = "Отсутствует файл сохранения";
                                textDlg.visible = true;
                            }
                        } else {
                            var output = link_core.listCleaner(filterPage.inputFile, filterPage.outputFile)
                            if ( output != "fine" ) {
                                textDlg.title = "Error";
                                textDlg.text = output;
                                textDlg.visible = true;
                            } else {
                                textDlg.title = "Info";
                                textDlg.text = "Готово";
                                textDlg.visible = true;
                                filterPage.inputFile = "";
                                filterPage.outputFile = "";
                                inputFile.text = "";
                                outputFile.text = "";
                            }
                        }
                    }
                }

                Rectangle { Layout.fillHeight: true }
            }
        }
    }

    Timer {
        id: pageManager
        property int index: -1
        interval: 0
        running: false
        onTriggered: {
            if (index != -1) {
                if (index == 0) mainPages.push(main)
                if (index == 1) mainPages.push(filter)
            }
            console.log('Yebat')
        }
    }

    MessageDialog {
        id: textDlg
    }

    Colors{ id: colors }
}
