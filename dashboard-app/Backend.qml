import QtQuick

Item {
    id: backend
    property bool power: false
    property bool engineRunning: false
    property bool positionLights: false
    property bool lowBeamLights: false
    property bool turnLeft: false
    property bool turnRight: false
    property int gear: 0
    property int speed: 0
    property real odometer: 0
    property real fuelLevel: 50
    property bool oilWarning: false
    property bool seatBelt: false

    function powerOn() {
        power = true
    }

    function powerOff () {
        power = false
    }

    onPowerChanged: {
        if (!power) {
            engineRunning = false
            positionLights = false
            lowBeamLights = false
            turnLeft = false
            turnRight = false
        }
    }

    function engineOn() {
        if (power) {
            engineRunning = true
        }
    }

    function engineOff() {
        if (power) {
            engineRunning = false;
        }
    }

    onEngineRunningChanged: {
        if (!engineRunning) {
            simulateBraking.start()
        }
    }

    function positionLightsOn() {
        if (power) {
            positionLights = true
        }
    }

    function positionLightsOff() {
        if (power) {
            positionLights = false
        }
    }

    function lowBeamLightsOn() {
        if (power) {
            lowBeamLights = true
        }
    }

    function lowBeamLightsOff() {
        if (power) {
            lowBeamLights = false
        }
    }

    function turnLeftOn() {
        if (power) {
            turnLeft = true
            turnRight = false
        }
    }

    function turnLeftOff() {
        if (power) {
            turnLeft = false
        }
    }

    function turnRightOn() {
        if (power) {
            turnRight = true
            turnLeft = false
        }
    }

    function turnRightOff() {
        if (power) {
            turnRight = false
        }
    }

    function gearUp() {
        if (gear < 5) {
            gear++
        }
    }

    function gearDown() {
        if (gear > 0) {
            gear--
        }
    }

    function throttle() {
        if (engineRunning) {
            simulateThrottle.start()
        }
    }

    function brake() {
        if (speed > 0) {
            simulateThrottle.stop()
            simulateBraking.start()
        }
    }

    function seatBeltOn() {
        seatBelt = true
    }

    function seatBeltOff() {
        seatBelt = false
    }

    SequentialAnimation {
        id: simulateThrottle

        PropertyAnimation {
            target: backend
            property: "speed"
            duration: 1000
            to: 240
        }
    }

    SequentialAnimation {
        id: simulateBraking

        PropertyAnimation {
            target: backend
            property: "speed"
            duration: 500
            to: 0
        }
    }
}
