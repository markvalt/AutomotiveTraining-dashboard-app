import QtQuick
import Backend

Window {
    id: window

    title: qsTr("Dashboard")
    visible: true
    color: "#333333"
    width: dashboardImg.width
    height: dashboardImg.height + controlPanel.height

    //Component.onCompleted: window.showMaximized()

    Rectangle {
        width: dashboardImg.width
        height: dashboardImg.height
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#222222" }
            GradientStop { position: 0.5; color: "#444444" }
            GradientStop { position: 1.0; color: "#111111" }
        }
    }

    Image {
        id: dashboardImg
        source: "images/DashboardMask.png"

        SpeedGauge {
            x: 46; y: 68
            backend: CppBackend
        }

        RpmGauge {
            x: 854; y: 68
            backend: CppBackend
        }

        IndicatorPanel {
            x: 495; y: 16
            backend: CppBackend
        }

        ContactList {
            x: 482; y: 75
            backend: CppBackend
        }
    }

//    DebugView {
//        id: debugView

//        width: 200
//        height: controlPanel.height
//        color: "#555555"
//        anchors.left: window.contentItem.left
//        anchors.leftMargin: 10
//        anchors.bottom: window.contentItem.bottom

//        backend: CppBackend
//    }

    ControlPanel {
        id: controlPanel

        width: dashboardImg.width
        height: 100
        y:dashboardImg.height
        color: "#333333"

        backend: CppBackend
    }

//    Backend {
//        id: backendQML
//    }
}
