import QtQuick 2.0

Item {
    id: root
    required property var backend

    Component {
        id: delegate

        Item {
            id: wrapper

            required property string name
            required property string number
            required property int index

            width: ListView.view.width; height: 65
            Column {
                x: 20; y: 5
                Text {
                    text: 'Name: ' + wrapper.name
                    font.pixelSize: 24
                    color: "#cccccc"
                }
                Text {
                    text: 'Number: ' + wrapper.number
                    font.pixelSize: 16
                    color: "#999999"
                }
            }
            MouseArea {
                anchors.fill: wrapper
                onClicked: wrapper.ListView.view.currentIndex = wrapper.index
            }
        }
    }

    Item {
        id: listView
        width: 340; height: 330
        opacity: 0

        ListView {
            cacheBuffer: 200
            anchors.fill: parent
            model: contactModel
            delegate: delegate
            focus: true
            clip: true
        }

        states: [
            State {
                name: "PowerOn"
                when: backend.power

                PropertyChanges {
                    target: listView
                    opacity: 0

                }
                PropertyChanges {
                    target: listView
                    opacity: 1
                }
            }
        ]

        transitions: [
            Transition {
                from: ""
                to: "PowerOn"
                NumberAnimation { properties: "opacity"; easing.type: Easing.Linear; duration: 500 }
            },
            Transition {
                from: "PowerOn"
                to: ""
                NumberAnimation { properties: "opacity"; easing.type: Easing.Linear; duration: 500 }
            }
        ]
    }

    ListModel {
        id: contactModel

        ListElement {
            name: "Bill Smith"
            number: "555 3264"
        }
        ListElement {
            name: "John Brown"
            number: "555 8426"
        }
        ListElement {
            name: "Sam Wise"
            number: "555 0473"
        }
        ListElement {
            name: "Bill Smith"
            number: "555 3264"
        }
        ListElement {
            name: "John Brown"
            number: "555 8426"
        }
        ListElement {
            name: "Sam Wise"
            number: "555 0473"
        }
        ListElement {
            name: "Bill Smith"
            number: "555 3264"
        }
        ListElement {
            name: "John Brown"
            number: "555 8426"
        }
        ListElement {
            name: "Sam Wise"
            number: "555 0473"
        }
        ListElement {
            name: "Bill Smith"
            number: "555 3264"
        }
        ListElement {
            name: "John Brown"
            number: "555 8426"
        }
        ListElement {
            name: "Sam Wise"
            number: "555 0473"
        }
        ListElement {
            name: "Bill Smith"
            number: "555 3264"
        }
        ListElement {
            name: "John Brown"
            number: "555 8426"
        }
        ListElement {
            name: "Sam Wise"
            number: "555 0473"
        }
    }
}
