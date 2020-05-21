import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Item {
    id: button
    width: parent.width
    height: parent.height
    anchors.leftMargin: 5
    anchors.rightMargin: 5

    property string text: ""
    property string image: image

    signal event()

    Rectangle {

        id: buttonBackground
        clip: true
        color: colors.backgroundColor
        anchors.fill: parent

        Rectangle {
            color: "black"
            opacity: .3
            anchors.fill: parent
        }

        Rectangle {
            id: enteredLayer
            color: "white"
            opacity: .2
            visible: false
            anchors.fill: parent
        }

        RowLayout {

            anchors.fill: parent
            spacing: 20

            Image {
                id: img
                source: image
                sourceSize: Qt.size(32, 32)
                width: 32
                height: 32
                y: parent.height / 2 - 24 / 2
                antialiasing: true
                x: 3

                ColorOverlay {
                    id: buttonColor
                    source: img
                    anchors.fill: parent
                    color: "white"
                    antialiasing: true
                    visible: true
                }


                NumberAnimation on x {
                    id: toggleImage
                    to: button.width < 100 ? 3 : 8
                    duration: 200
                    easing.type: Easing.Linear
                    running: false
                }
            }

            Text {
                color: colors.colorAccent
                text: button.text
                Layout.fillWidth: true
                y: button.height / 2 - paintedHeight / 2
            }
        }

    }

    onWidthChanged: {
        toggleImage.to = button.width < 100 ? 3 : 8
        toggleImage.running = true
    }

    MouseArea {
        z: 20
        //propagateComposedEvents: true
        anchors.fill: parent
        hoverEnabled: true
        onHoveredChanged: {
            if ( containsMouse ) {
                enteredLayer.visible = true
                buttonColor.color = colors.colorAccent
            } else {
                enteredLayer.visible = false
                buttonColor.color = "white"
            }
        }
        onClicked: {
            console.log('Huyak')
            button.event()
        }
    }

    Colors { id: colors }
}
