import QtQuick
import QtQuick.Controls

Image {
    id: root
    required property var backend

    source: "images/Gauge_Speed.png"

    Image {
        id: needleImg
        source: "images/SpeedometerNeedle.png"
        x: 28
        y: 166

        transform: Rotation {
            origin.x: needleImg.width * 0.78;
            origin.y: needleImg.height * 0.5;
            axis { x: 0; y: 0; z: 1 }
            angle: -90 + backend.speed / 240 * 270

            Behavior on angle { PropertyAnimation { easing.type: Easing.OutCubic; duration: 3000 } }
        }
    }

    Image {
        id: fuelNeedleImg
        source: "images/SpeedometerNeedle.png"
        x: 28
        y: 166

        transform: Rotation {
            origin.x: fuelNeedleImg.width * 0.78;
            origin.y: fuelNeedleImg.height * 0.5;
            axis { x: 0; y: 0; z: 1 }
            angle: 233 - (backend.fuelLevel / 50) * 35

            Behavior on angle { PropertyAnimation { easing.type: Easing.OutCubic; duration: 1000 } }
        }
    }

    Image {
        source: "images/gaugeCenterBig.png"
        anchors.centerIn: parent
    }

    Label {
        property int speed: backend.speed.toFixed(0)
        text: speed
        font.pixelSize: 33
        color: "#eeeeee"
        anchors.horizontalCenter: parent.horizontalCenter
        y: 158

        Behavior on speed { PropertyAnimation { easing.type: Easing.OutCubic; duration: 3000 } }
    }

    Label {
        text: "km/h"
        font.pixelSize: 14
        color: "#888888"
        anchors.horizontalCenter: parent.horizontalCenter
        y: 198
    }
}
