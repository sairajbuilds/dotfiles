import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick

FloatingWindow {
    id: osd
    visible: osdVisible
    width: 200
    height: 48

    property bool osdVisible: false
    property int volume: 0

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.anchors.bottom: true
    WlrLayershell.anchors.horizontalCenter: true
    WlrLayershell.margins.bottom: 80

    Timer {
        id: hideTimer
        interval: 1500
        onTriggered: osd.osdVisible = false
    }

    function show(vol) {
        volume = vol
        osdVisible = true
        hideTimer.restart()
    }

    Rectangle {
        anchors.fill: parent
        radius: 24
        color: "#ee1a1b26"

        Row {
            anchors.centerIn: parent
            spacing: 12

            Text {
                property string icon: osd.volume === 0 ? "󰝟" :
                    osd.volume < 50 ? "󰕾" : "󰕿"
                text: icon
                color: "#a9b1d6"
                font.pixelSize: 18
                font.family: "Iosevka NF"
                anchors.verticalCenter: parent.verticalCenter
            }

            Rectangle {
                width: 100
                height: 6
                radius: 3
                color: "#414868"
                anchors.verticalCenter: parent.verticalCenter

                Rectangle {
                    width: parent.width * (osd.volume / 100)
                    height: parent.height
                    radius: 3
                    color: "#a9b1d6"

                    Behavior on width {
                        NumberAnimation { duration: 100 }
                    }
                }
            }

            Text {
                text: osd.volume + "%"
                color: "#a9b1d6"
                font.pixelSize: 13
                font.family: "Iosevka NF"
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
