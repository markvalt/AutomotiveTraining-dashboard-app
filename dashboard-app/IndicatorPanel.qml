import QtQuick

Item {
    id: root
    required property var backend
    property alias leftBlinkRate: turnLeft.blinkRate

    Row {
        IndicatorIcon {
            id: turnLeft
            value: backend.turnLeft
            on: "images/Icon_TurnLeft_ON.png"
            off: "images/Icon_TurnLeft_OFF.png"
            blinkRate: 1000
        }

        IndicatorIcon {
            value: backend.positionLights
            on: "images/Icon_PositionLights_ON.png"
            off: "images/Icon_PositionLights_OFF.png"
        }

        IndicatorIcon {
            value: backend.lowBeamLights
            on: "images/Icon_LowBeam_ON.png"
            off: "images/Icon_LowBeam_OFF.png"
        }

        IndicatorIcon {
            value: backend.fuelLevel < 5 && backend.power
            on: "images/Icon_Fuel_ON.png"
            off: "images/Icon_Fuel_OFF.png" }

        IndicatorIcon {
            value: !backend.seatBelt && backend.power
            on: "images/Icon_SeatBelt_ON.png"
            off: "images/Icon_SeatBelt_OFF.png"
        }

        IndicatorIcon {
            value: backend.turnRight
            on: "images/Icon_TurnLeft_ON.png"
            off: "images/Icon_TurnLeft_OFF.png"
            mirror: true
            blinkRate: 1000
        }
    }
}
