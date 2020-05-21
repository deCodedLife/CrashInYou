import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Item {

    property string image_link: ""
    property string nickName: ""
    property string youtubeLink: ""

    RowLayout {
        anchors.fill: parent

        Image {
            source: image_link
            width: 72
            height: 72
            layer.enabled: true
            layer.effect: OpacityMask { maskSource: mask }
        }

        Rectangle {
            id: mask
            width: 48
            height: 48
            radius: 5
            visible: false
            antialiasing: true
        }

        Rectangle { Layout.fillWidth: true }

        ColumnLayout {

            Layout.fillWidth: true

            Text {
                text: nickName
                Layout.fillWidth: true
                color: "white"
                font.pixelSize: 24
            }

            Text {
                color: colors.colorAccent
                font.pixelSize: 18
                Layout.fillWidth: true
                text: "<a href='"+youtubeLink+"' style='text-decoration: none'>Youtube канал</a>"
                linkColor: colors.colorAccent
                onLinkActivated: Qt.openUrlExternally(youtubeLink)
            }

        }
    }
    Colors { id: colors }
}
