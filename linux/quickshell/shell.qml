import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

ShellRoot {
    PanelWindow {
        id: bar
        anchors.top: true
        anchors.left: true
        anchors.right: true
        implicitHeight: 52
        color: "transparent"
        exclusiveZone: 52

        property string batCapacity: "..."
        property string batStatus: "Discharging"
        property string volume: "..."
        property string netName: "..."
        property int brightness: 0
        property int brightnessMax: 509
	property string mediaTitle: ""
	property string mediaArtist: ""
	property string mediaStatus: "Stopped"

        Process {
            id: batReader
            command: ["bash", "-c", "cat /sys/class/power_supply/macsmc-battery/capacity"]
            running: true
            stdout: SplitParser {
                onRead: data => bar.batCapacity = data.trim()
            }
        }

        Process {
            id: batStatusReader
            command: ["bash", "-c", "cat /sys/class/power_supply/macsmc-battery/status"]
            running: true
            stdout: SplitParser {
                onRead: data => bar.batStatus = data.trim()
            }
        }

        Process {
    id: volReader
    command: ["bash", "-c", "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf \"%d\", $2*100}'"]
    running: true
    stdout: SplitParser {
        onRead: data => {
            bar.volume = data.trim()
            volumeOsd.osdVolume = parseInt(data.trim())
            volumeOsd.osdVisible = true
            hideTimer.restart()
        }
    }
}

        Process {
            id: volWatcher
            command: ["bash", "-c", "pactl subscribe | grep --line-buffered sink"]
            running: true
            stdout: SplitParser {
                onRead: data => {
                    volReader.running = false
                    volReader.running = true
                }
            }
        }

        Process {
            id: netReader
            command: ["bash", "-c", "nmcli -t -f NAME,TYPE,STATE connection show --active | grep wireless | cut -d: -f1"]
            running: true
            stdout: SplitParser {
                onRead: data => bar.netName = data.trim() === "" ? "Disconnected" : data.trim()
            }
        }

        // Watch brightness sysfs file directly for instant updates
        Process {
            id: brightWatcher
            command: ["bash", "-c", "while true; do cat /sys/class/backlight/apple-panel-bl/brightness; inotifywait -q -e modify /sys/class/backlight/apple-panel-bl/brightness 2>/dev/null || sleep 0.5; done"]
            running: true
            stdout: SplitParser {
                onRead: data => {
    var val = parseInt(data.trim())
    if (!isNaN(val)) {
        bar.brightness = Math.round(val * 100 / bar.brightnessMax)
        brightnessOsd.osdBrightness = bar.brightness
        brightnessOsd.brightOsdVisible = true
        brightHideTimer.restart()
    }
}
            }
        }

	Process {
    id: mediaTitleReader
    command: ["bash", "-c", "playerctl metadata title 2>/dev/null || echo ''"]
    running: true
    stdout: SplitParser {
        onRead: data => bar.mediaTitle = data.trim()
    }
}

Process {
    id: mediaArtistReader
    command: ["bash", "-c", "playerctl metadata artist 2>/dev/null || echo ''"]
    running: true
    stdout: SplitParser {
        onRead: data => bar.mediaArtist = data.trim()
    }
}

Process {
    id: mediaStatusReader
    command: ["bash", "-c", "playerctl status 2>/dev/null || echo 'Stopped'"]
    running: true
    stdout: SplitParser {
        onRead: data => bar.mediaStatus = data.trim()
    }
}

Process {
    id: mediaWatcher
    command: ["bash", "-c", "playerctl --follow status 2>/dev/null"]
    running: true
    stdout: SplitParser {
        onRead: data => {
            bar.mediaStatus = data.trim()
            mediaTitleReader.running = false
            mediaTitleReader.running = true
            mediaArtistReader.running = false
            mediaArtistReader.running = true
        }
    }
}

        Timer {
            interval: 30000
            repeat: true
            running: true
            onTriggered: {
                batReader.running = false
                batReader.running = true
                batStatusReader.running = false
                batStatusReader.running = true
                netReader.running = false
                netReader.running = true
            }
        }

        Item {
            anchors.fill: parent

            Rectangle {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.margins: 8
                width: leftRow.width + 24
                height: 36
                radius: 18
                color: "#cc1a1b26"

                RowLayout {
                    id: leftRow
                    anchors.centerIn: parent
                    spacing: 10

                    RowLayout {
                        spacing: 6
                        Repeater {
                            model: 5
                            delegate: Rectangle {
                                property int wsId: index + 1
                                property bool isActive: Hyprland.focusedWorkspace?.id === wsId
                                property bool hasWindows: Hyprland.workspaces.values.some(w => w.id === wsId)
                                width: 24
                                height: 24
                                radius: 12
                                color: isActive ? "#a9b1d6" : hasWindows ? "#414868" : "transparent"
                                Text {
                                    anchors.centerIn: parent
                                    text: wsId
                                    color: isActive ? "#1a1b26" : "#a9b1d6"
                                    font.pixelSize: 11
                                    font.bold: true
                                    font.family: "Iosevka NF"
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: Hyprland.dispatch("workspace " + wsId)
                                }
                            }
                        }
                    }

                    Rectangle {
                        width: 1
                        height: 20
                        color: "#414868"
                    }

                    Text {
                        text: Hyprland.focusedClient?.title?.substring(0, 30) ?? "Desktop"
                        color: "#7aa2f7"
                        font.pixelSize: 12
                        font.family: "Iosevka NF"
                        elide: Text.ElideRight
                        Layout.maximumWidth: 200
                    }
                }
            }

		// Media island - only visible when playing
            Rectangle {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: leftRow.width + 48
                anchors.topMargin: 8
                width: mediaRow.width + 24
                height: 36
                radius: 18
                color: "#cc1a1b26"
                visible: bar.mediaTitle !== "" && bar.mediaStatus !== "Stopped"

                Row {
                    id: mediaRow
                    anchors.centerIn: parent
                    spacing: 10

                    Text {
                        property string icon: bar.mediaStatus === "Playing" ? "󰏤" : "󰐊"
                        text: icon
                        color: "#9ece6a"
                        font.pixelSize: 14
                        font.family: "Iosevka NF"
                        anchors.verticalCenter: parent.verticalCenter
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                mediaPlayPause.running = false
                                mediaPlayPause.running = true
                            }
                        }
                    }

                    Text {
                        text: (bar.mediaArtist !== "" ? bar.mediaArtist + " — " : "") +
                              bar.mediaTitle.substring(0, 25)
                        color: "#9ece6a"
                        font.pixelSize: 12
                        font.family: "Iosevka NF"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Process {
                    id: mediaPlayPause
                    command: ["playerctl", "play-pause"]
                }
            }

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.margins: 8
                width: 220
                height: 36
                radius: 18
                color: "#cc1a1b26"
                Text {
                    anchors.centerIn: parent
                    text: clock.text
                    color: "#a9b1d6"
                    font.pixelSize: 14
                    font.bold: true
                    font.family: "Iosevka NF"
                }
                Timer {
                    id: clock
                    property string text: Qt.formatDateTime(new Date(), " ddd, MMM d   hh:mm")
                    interval: 1000
                    repeat: true
                    running: true
                    onTriggered: text = Qt.formatDateTime(new Date(), " ddd, MMM d   hh:mm")
                }
            }

            Rectangle {
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: 8
                width: 420
                height: 36
                radius: 18
                color: "#cc1a1b26"

                RowLayout {
                    anchors.centerIn: parent
                    spacing: 16

                    Text {
                        text: "󰤨  " + bar.netName
                        color: bar.netName === "Disconnected" ? "#f7768e" : "#a9b1d6"
                        font.pixelSize: 13
                        font.family: "Iosevka NF"
                    }

                    Text {
                        property string icon: bar.brightness < 30 ? "󰃞" :
                            bar.brightness < 70 ? "󰃟" : "󰃠"
                        text: icon + "  " + bar.brightness + "%"
                        color: "#a9b1d6"
                        font.pixelSize: 14
                        font.family: "Iosevka NF"
                    }

                    Text {
                        property string icon: parseInt(bar.volume) === 0 ? "󰝟" :
                            parseInt(bar.volume) < 50 ? "󰕾" : "󰕿"
                        text: icon + "  " + bar.volume + "%"
                        color: "#a9b1d6"
                        font.pixelSize: 14
                        font.family: "Iosevka NF"
                    }

                    Text {
                        property string icon: bar.batStatus === "Charging" ? "󰂄" :
                            parseInt(bar.batCapacity) > 80 ? "󰁹" :
                            parseInt(bar.batCapacity) > 60 ? "󰂁" :
                            parseInt(bar.batCapacity) > 40 ? "󰁿" :
                            parseInt(bar.batCapacity) > 20 ? "󰁽" : "󰁺"
                        text: icon + "  " + bar.batCapacity + "%"
                        color: parseInt(bar.batCapacity) < 20 ? "#f7768e" : "#a9b1d6"
                        font.pixelSize: 14
                        font.family: "Iosevka NF"
                    }
                }
            }
        }
    }

// Volume OSD
    PanelWindow {
        id: volumeOsd
        anchors.bottom: true
        anchors.left: true
        anchors.right: true
        implicitHeight: 80
        color: "transparent"
        exclusiveZone: 0
        visible: osdVisible

        property bool osdVisible: false
        property int osdVolume: 0

        Timer {
            id: hideTimer
            interval: 1500
            onTriggered: volumeOsd.osdVisible = false
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 220
            height: 48
            radius: 24
            color: "#ee1a1b26"
            visible: volumeOsd.osdVisible

            Row {
                anchors.centerIn: parent
                spacing: 12

                Text {
                    property string icon: volumeOsd.osdVolume === 0 ? "󰝟" :
                        volumeOsd.osdVolume < 50 ? "󰕾" : "󰕿"
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
                        width: parent.width * (volumeOsd.osdVolume / 100)
                        height: parent.height
                        radius: 3
                        color: "#a9b1d6"
                        Behavior on width {
                            NumberAnimation { duration: 100 }
                        }
                    }
                }

                Text {
                    text: volumeOsd.osdVolume + "%"
                    color: "#a9b1d6"
                    font.pixelSize: 13
                    font.family: "Iosevka NF"
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }

// Brightness OSD
    PanelWindow {
        id: brightnessOsd
        anchors.bottom: true
        anchors.left: true
        anchors.right: true
        implicitHeight: 80
        color: "transparent"
        exclusiveZone: 0
        visible: brightOsdVisible

        property bool brightOsdVisible: false
        property int osdBrightness: 0

        Timer {
            id: brightHideTimer
            interval: 1500
            onTriggered: brightnessOsd.brightOsdVisible = false
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 220
            height: 48
            radius: 24
            color: "#ee1a1b26"
            visible: brightnessOsd.brightOsdVisible

            Row {
                anchors.centerIn: parent
                spacing: 12

                Text {
                    property string icon: brightnessOsd.osdBrightness < 30 ? "󰃞" :
                        brightnessOsd.osdBrightness < 70 ? "󰃟" : "󰃠"
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
                        width: parent.width * (brightnessOsd.osdBrightness / 100)
                        height: parent.height
                        radius: 3
                        color: "#e0af68"
                        Behavior on width {
                            NumberAnimation { duration: 100 }
                        }
                    }
                }

                Text {
                    text: brightnessOsd.osdBrightness + "%"
                    color: "#a9b1d6"
                    font.pixelSize: 13
                    font.family: "Iosevka NF"
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
}
