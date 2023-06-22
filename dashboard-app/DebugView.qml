import QtQuick
import QtQuick.Controls

Rectangle {
    id: root
    required property var backend

    Column {
        anchors.left: parent.left
        anchors.leftMargin: 10

        Label { text: "power: " + backend.power }
        Label { text: "engine: " + backend.engineRunning }
        //Label { text: "pos.lights: " + backend.positionLights }
        //Label { text: "beamLights: " + backend.lowBeamLights }
        Label { text: "gear: " + backend.gear }
        Label { text: "speed: " + backend.speed.toFixed(1) }
        Label { text: "rpm: " + backend.rpm.toFixed(0) }
        Label { text: "fuelLevel: " + backend.fuelLevel.toFixed(2) }
        Label { text: "odometer: " + backend.odometer.toFixed(3) }
        Label { text: "turnLeft: " + backend.turnLeft }
        Label { text: "turnRight: " + backend.turnRight }
    }
}
