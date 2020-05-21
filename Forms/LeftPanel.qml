import QtQuick 2.0

Item {

    id: leftPanel

    property bool closed: true
    property var blackBackground: blackBackground
    property var pages: [
        {
            "text" : "Главная",
            "image": "qrc:/Graphics/videocam-white-48dp.svg"
        },
        {
            "text" : "Фильтр",
            "image": "qrc:/Graphics/logo.png"
        },
        /*
        {
            "text" : "RuMine",
            "image": "qrc:/Graphics/logo.png"
        },
        {
            "text" : "Настройки",
            "image": "qrc:/Graphics/logo.png"
        }
        */
    ]
    property var manager: leftPanel.manager

    width: parent.width
    height: parent.height

    Rectangle {
        width: 1
        height: parent.height
        color: "black"
        opacity: 1
        anchors.right: parent.right
    }

    Rectangle {

        id: leftPanelBackground
        width: parent.width
        height: parent.height
        color: colors.backgroundColor
        clip: true

        MouseArea {
            propagateComposedEvents: true
            anchors.fill: parent
            onClicked: {
                leftPanel.closed = !leftPanel.closed
            }
        }

        Rectangle {
            anchors.fill: parent
            color: "black"
            opacity: .3
        }

        ListView {
            anchors.fill: parent
            model: pages
            delegate: ListButton {
                text: modelData["text"]
                image: modelData["image"]
                width: parent.width - 10
                height: 48
                x: 5
                onEvent: {
                    manager.index = index
                    manager.running = true
                }
            }
        }

    }

    onClosedChanged: {
        if (!closed) blackBackground.show();
        else blackBackground.hide();
    }

    function hide () {
        closed = !closed
    }

    Colors { id: colors }
}
