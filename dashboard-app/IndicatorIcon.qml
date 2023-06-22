import QtQuick

Item {
    id: root
    required property var value
    required property string on
    required property string off
    property alias mirror: image.mirror
    property int blinkRate: 0

    width: image.width
    height: image.height

    Image {
        id: image

        source: {
            if (blinkRate === 0) {
                source: value ? on : off
            } else {
                source: value && blinkTimer.blinkOn ? on : off
            }
        }

        Timer {
            id: blinkTimer
            property bool blinkOn: false
            repeat: true
            interval: blinkRate / 2
            onTriggered: blinkOn = !blinkOn
        }
    }

    onValueChanged: {
        blinkTimer.blinkOn = false
        value && blinkRate > 0 ? blinkTimer.start() : blinkTimer.stop()
    }
}
