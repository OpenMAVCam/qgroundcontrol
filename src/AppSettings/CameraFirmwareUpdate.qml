import QtQuick
import QtQuick.Layouts

import QGroundControl
import QGroundControl.Controls

SettingsGroupLayout {
    id: root

    heading: qsTr("Firmware Update")
    showDividers: false
    contentSpacing: ScreenTools.defaultFontPixelHeight

    property string _firmwareFile: ""

    QGCButton {
        objectName: "cameraSelectFirmwareButton"
        Layout.fillWidth: true
        text: qsTr("Select Firmware File")
        iconSource: "qrc:/InstrumentValueIcons/folder-outline.svg"
        onClicked: firmwareFileDialog.openForLoad()
    }

    QGCLabel {
        objectName: "cameraFirmwareFile"
        Layout.fillWidth: true
        text: root._firmwareFile
        visible: root._firmwareFile.length > 0
        wrapMode: Text.WrapAnywhere
    }

    QGCButton {
        objectName: "cameraUpdateFirmwareButton"
        Layout.fillWidth: true
        text: qsTr("Update Firmware")
        primary: true
        enabled: false
    }

    QGCLabel {
        Layout.fillWidth: true
        text: qsTr("Camera firmware updates are not available yet.")
        wrapMode: Text.Wrap
    }

    QGCFileDialog {
        id: firmwareFileDialog
        title: qsTr("Select Camera Firmware File")
        folder: QGroundControl.settingsManager.appSettings.savePath.rawValue
        nameFilters: [qsTr("All files (*)")]
        onAcceptedForLoad: (file) => { root._firmwareFile = file }
    }
}
