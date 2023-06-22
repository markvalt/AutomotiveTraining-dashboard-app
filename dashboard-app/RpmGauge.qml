import QtQuick
import QtQuick.Controls

Image {
    id: root
    required property var backend

    source: "images/Gauge_RPM.png"
    x: 45
    y: 70

    Image {
        id: needleImg
        source: "images/SpeedometerNeedle.png"
        x: 28
        y: 166

        transform: Rotation {
            origin.x: needleImg.width * 0.78;
            origin.y: needleImg.height * 0.5;
            axis { x: 0; y: 0; z: 1 }
            angle: 0 + backend.rpm / 8000 * 180

            Behavior on angle { PropertyAnimation { easing.type: Easing.OutCubic; duration: 500 } }
        }
    }

    Image {
        source: "images/gaugeCenterBig.png"
        anchors.centerIn: parent
    }

    Label {
        text: {
            var gears = ['R', 'N', '1', '2', '3', '4', '5']
            text: gears[backend.gear]
        }

        font.pixelSize: 40
        color: "#eeeeee"
        anchors.horizontalCenter: parent.horizontalCenter
        y: 158
    }

    Label {
        text: formatNumberLength(backend.odometer.toFixed(0), 6)
        font.pixelSize: 20
        color: "#000000"
        x: 161;
        y: 290

        function formatNumberLength(num, length) {
            var r = "" + num;
            while (r.length < length) {
                r = "0" + r;
            }
            return r;
        }
    }
}
