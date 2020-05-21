import QtQuick 2.0
import LoadScreenText 0.1

Item {

    width: parent.width
    height: parent.height

    Rectangle {
        anchors.fill: parent
        color: colors.backgroundColor

        Image {
            opacity: .0
            anchors.centerIn: parent
            source: "qrc:/../Graphics/logo.png"

            NumberAnimation on opacity {
                from: 0
                to: 1
                duration: 600
                easing.type: Easing.InOutQuart
            }
        }

        Text {
            id: loadScreenText
            text: _text.text
            color: "white"
            anchors.bottom: parent.bottom
            font.pixelSize: 18
        }
    }

    LoadScreenText { id: _text }
    Colors{ id: colors }
}
