import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import CoreApi 0.1

Window {
    id: root

    visible: true
    width: Screen.width / 2
    height: Screen.height / 2
    title: qsTr("CrashInYou")

    maximumHeight: Screen.hright / 2
    maximumWidth: Screen.width / 2
    minimumHeight: Screen.height/ 2
    minimumWidth: Screen.width / 2

    Material.accent: colors.colorAccent
    Material.theme: Material.Dark

    StackView {
        anchors.fill: parent
        id: stackView
        initialItem: loadScreen
    }

    Component {
        id: mainPageItem
        MainWindow {
            width: root.width
            height: root.height
            link_core: core
        }
    }

    Component {
        id: loadScreen
        LoadScreen {
            width: root.width
            height: root.height
        }
    }

    CoreApi { id: core }
    Colors  { id: colors }

    Timer {
        interval: 3000
        id: loading // I create this sh*t, for imitate "work"
        onTriggered: {
            stackView.push(mainPageItem);
            root.minimumHeight = Screen.height / 1.4
            root.maximumHeight = Screen.height
            root.minimumWidth = Screen.width / 1.4
            root.maximumWidth = Screen.width
        }
        running: false
    }

    Component.onCompleted: {
        loading.running = true;
    }
}
