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

        Process {
            id: volReader
            command: ["bash", "-c", "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf \"%d\", $2*100}'"]
            running: true
            stdout: SplitParser {
                onRead: data => bar.volume = data.trim()
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

        Item {
            anchors.fill: parent

            // Left island - Workspaces + Active Window
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
                        id: wsRow
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

                    // Divider
                    Rectangle {
                        width: 1
                        height: 20
                        color: "#414868"
                    }

                    // Active window title
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

            // Center island - Clock
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

            // Right island - Network + Volume + Battery
            Rectangle {
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: 8
                width: 340
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
}
