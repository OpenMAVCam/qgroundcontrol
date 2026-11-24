pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import QGroundControl
import QGroundControl.Controls

ColumnLayout {
    id: root

    spacing: ScreenTools.defaultFontPixelHeight

    readonly property var _activeVehicle: QGroundControl.multiVehicleManager.activeVehicle
    readonly property var _cameraManager: _activeVehicle ? _activeVehicle.cameraManager : null
    readonly property var _camera: _cameraManager && _cameraManager.cameras.count > 0
                                   ? _cameraManager.currentCameraInstance : null
    readonly property bool _connected: !!(_activeVehicle && !_activeVehicle.vehicleLinkManager.communicationLost
                                        && _camera && _camera.componentId > 0)

    QGCPalette { id: qgcPal; colorGroupEnabled: true }

    QGCLabel {
        Layout.fillWidth: true
        text: qsTr("Camera")
        font.pointSize: ScreenTools.largeFontPointSize
        font.bold: true
    }

    QGCLabel {
        Layout.fillWidth: true
        text: qsTr("Camera Information")
        font.bold: true
    }

    Repeater {
        model: [
            { label: qsTr("Manufacturer"), value: root._connected ? root._camera.vendor : "" },
            { label: qsTr("Model"), value: root._connected ? root._camera.modelName : "" },
            { label: qsTr("Firmware Version"), value: root._connected ? root._camera.firmwareVersion : "" },
            { label: qsTr("Component ID"), value: root._connected ? String(root._camera.componentId) : "" }
        ]

        ColumnLayout {
            id: informationField

            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 2

            required property var modelData

            QGCLabel {
                Layout.fillWidth: true
                text: informationField.modelData.label
                color: qgcPal.text
                opacity: 0.7
            }

            QGCLabel {
                Layout.fillWidth: true
                text: informationField.modelData.value || qsTr("Not available")
                wrapMode: Text.Wrap
            }
        }
    }

    RowLayout {
        Layout.fillWidth: true
        spacing: ScreenTools.defaultFontPixelWidth

        QGCColoredImage {
            Layout.preferredWidth: ScreenTools.defaultFontPixelHeight
            Layout.preferredHeight: ScreenTools.defaultFontPixelHeight
            source: "qrc:/InstrumentValueIcons/checkmark-outline.svg"
            color: qgcPal.colorGreen
            visible: root._connected
        }

        QGCLabel {
            objectName: "cameraConnectionStatus"
            Layout.fillWidth: true
            text: root._connected ? qsTr("Connected") : qsTr("Not connected")
            color: root._connected ? qgcPal.colorGreen : qgcPal.text
        }
    }
}
