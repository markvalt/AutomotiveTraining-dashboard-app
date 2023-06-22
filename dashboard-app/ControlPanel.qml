import QtQuick
import QtQuick.Controls

Rectangle {
    id: root
    required property var backend

    Grid {
        id: grid
        columns: 6
        width: 100
        height: 35
        x: 340; y: 15

        Button {
            text: backend.power ? "Power On" : "Power Off"
            width: parent.width
            height: parent.height
            onClicked: backend.power ? backend.powerOff() : backend.powerOn()
        }

        Button {
            text: backend.engineRunning ? "Engine On" : "Engine Off"
            width: parent.width
            height: parent.height
            onClicked: backend.engineRunning ? backend.engineOff() : backend.engineOn()
        }

        Button {
            text: backend.positionLights ? "Pos. Lights On" : "Pos. Lights Off"
            width: parent.width
            height: parent.height
            onClicked: backend.positionLights ? backend.positionLightsOff() : backend.positionLightsOn()
        }

        Button {
            text: backend.lowBeamLights ? "Beam Lights On" : "Beam Lights Off"
            width: parent.width
            height: parent.height
            onClicked: backend.lowBeamLights ? backend.lowBeamLightsOff() : backend.lowBeamLightsOn()
        }

        Button {
            text: "Turn left"
            width: parent.width
            height: parent.height
            onClicked: backend.turnLeft ? backend.turnLeftOff() : backend.turnLeftOn()
        }

        Button {
            id: turnRightButton
            text: "Turn right"
            width: parent.width
            height: parent.height
            onClicked: backend.turnRight ? backend.turnRightOff() : backend.turnRightOn()
        }

        Button {
            text: "Gear up"
            width: parent.width
            height: parent.height
            onClicked: backend.gearUp()
        }

        Button {
            text: "Gear Down"
            width: parent.width
            height: parent.height
            onClicked: backend.gearDown()
        }

        Button {
            text: "Brake"
            width: parent.width
            height: parent.height
            onClicked: backend.brake()
        }

        Button {
            text: "Throttle"
            width: parent.width
            height: parent.height
            onClicked: backend.throttle()
        }

        Button {
            text: backend.seatBelt ? "Seatbelt On" : "Seatbelt Off"
            width: parent.width
            height: parent.height
            onClicked: backend.seatBelt ? backend.seatBeltOff() : backend.seatBeltOn()
        }

        Button {
            text: "Add fuel"
            width: parent.width
            height: parent.height
            onClicked: backend.addFuel()
        }
    }
}
