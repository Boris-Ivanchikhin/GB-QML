import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts

Window
{
    id: _root
    width: 640
    minimumWidth: 350
    height: 480
    minimumHeight: 350
    visible: true
    title: qsTr("Lesson 03. Tasks 1, 2.")


    readonly property int defFontSize : 15
    readonly property int defMargin   : 10
    readonly property color bgColor   : "#333333"
    readonly property color panelColor: "#999999"
    readonly property color errorColor: "#CC3333"
    readonly property color textColor : "black"//"white"

    readonly property string lgnCheck : "login"
    readonly property string pswCheck : "password"


    color: bgColor

    function credentials()
    {
        return (_login.text === lgnCheck && _password.text === pswCheck)
    }

    function proceed()
    {
        //console.log(_item.state)
        _item.state = "PROCEED";
        console.log(_item.state)
    }

    Item
    {
        id: _item
        implicitWidth: 300
        implicitHeight: 300
        anchors.centerIn: parent



        BusyIndicator
        {
            id: _indicator
            anchors.centerIn: parent
            width: 50
            height: 50
            running: false
            z: 99
        }

        Rectangle
        {
            id: _loginForm
            anchors.fill: parent
            radius: 15
            color: panelColor//"lightblue"
            opacity: 1

            transform: Rotation
            {
                id: _loginTransform
                origin.x: _loginForm.width / 2
                origin.y: _loginForm.height / 2;
                axis { x: 0; y: 1; z: 0 }
                angle: 0
            }

            Timer
            {
                id: _loginTimer
                interval : 1000

                onTriggered:
                {
                    //console.log(_item.state);
                    if (credentials())
                        _item.state = "SUCCESS";
                    else
                        _item.state = "RETRY";

                    console.log(_item.state)
                }
            }

            ColumnLayout
            {
                anchors.fill: parent
                clip: true
                spacing: defMargin

                Label
                {
                    id: _title
                    Layout.alignment: Qt.AlignCenter
                    horizontalAlignment: TextInput.AlignHCenter
                    text: "Credentials:"
                    font.pointSize: defFontSize
                    font.bold: true
                    color: textColor
                }

                TextField
                {
                    id: _login
                    Layout.alignment: Qt.AlignCenter
                    horizontalAlignment: TextInput.AlignHCenter
                    implicitWidth: 250
                    placeholderText: "login"
                    font.pointSize: defFontSize
                    //focus: true

                    Keys.onEnterPressed:  proceed()
                    Keys.onReturnPressed: proceed()
                    onFocusChanged:
                    {
                        if (activeFocus)
                        { selectAll(); }
                    }
                }

                TextField
                {
                    id: _password
                    Layout.alignment: Qt.AlignCenter
                    horizontalAlignment: TextInput.AlignHCenter
                    implicitWidth: 250
                    placeholderText: "password"
                    font.pointSize: defFontSize
                    echoMode: TextInput.Password

                    Keys.onEnterPressed:  proceed()
                    Keys.onReturnPressed: proceed()
                    onFocusChanged:
                    {
                        if (activeFocus)
                        { selectAll(); }
                    }
                }

                Button
                {
                    id: _loginBtn
                    Layout.bottomMargin: defMargin * 2
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                    text: "Proceed"
                    font.pointSize: defFontSize


                    background: Rectangle
                    {
                        color: "lightblue"
                        implicitWidth: 250
                        implicitHeight: 50
                        opacity: enabled ? 1 : 0.3
                        radius: 15
                    }

                    onClicked:
                    {
                        proceed()
                    }
                }

            } // ColumnLayout

        } // Rectangle : _loginForm

        Rectangle
        {
            id: _successForm
            implicitWidth: 300
            implicitHeight: 300
            radius: 15
            anchors.centerIn: parent
            color: panelColor
            opacity: 0

            transform: Rotation
            {
                id: _successTransform
                origin.x: _successForm.width / 2
                origin.y: _successForm.height / 2;
                axis { x: 0; y: 1; z: 0 }
                angle: 270
            }

            ColumnLayout
            {
                anchors.fill: parent

                Label
                {
                    Layout.alignment: Qt.AlignCenter
                    horizontalAlignment: TextInput.AlignHCenter
                    text: "Success!"
                    font.pointSize: defFontSize
                    font.bold: true
                }

                Button
                {
                    id: _finishBtn
                    Layout.bottomMargin: defMargin * 2
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                    text: "Finish"
                    font.pointSize: defFontSize
                    font.bold: true

                    background: Rectangle
                    {
                        color: "lightblue"
                        implicitWidth: 250
                        implicitHeight: 50
                        opacity: enabled ? 1 : 0.3
                        radius: 15
                    }

                    onClicked:
                    {
                        Qt.quit()
                    }
                }

            } // ColumnLayout

        } // // Rectangle : _successForm

        states:
        [
            State
            {
                name: "PROCEED"
                PropertyChanges { target: _loginTimer;       running: true }
                PropertyChanges { target: _indicator;        running: true }
                PropertyChanges { target: _loginBtn;         enabled: false }
            },

            State
            {
                name: "RETRY"
                PropertyChanges { target: _loginTimer;       running: false }
                PropertyChanges { target: _indicator;        running: false }
                PropertyChanges { target: _loginTransform;   angle:   360  }
                //PropertyChanges { target: _successTransform; angle:   270 }
                //PropertyChanges { target: _loginForm;        opacity: 1 }
                //PropertyChanges { target: _successForm;      opacity: 0 }
                PropertyChanges { target: _loginBtn;         enabled: true }
                PropertyChanges { target: _loginForm;        color: errorColor}
            },

            State
            {
                name: "SUCCESS" //"inputOk"
                PropertyChanges { target: _loginTimer;       running: false }
                PropertyChanges { target: _indicator;        running: false }
                PropertyChanges { target: _loginTransform;   angle:   90  }
                PropertyChanges { target: _successTransform; angle:   360 }
                PropertyChanges { target: _loginForm;        opacity: 0 }
                PropertyChanges { target: _successForm;      opacity: 1 }
                PropertyChanges { target: _loginBtn;         enabled: false }
            }

        ] // states

        transitions:
        [
            Transition
            {
                to:   "PROCEED"

                PropertyAnimation { target: _loginForm; property: "color"; duration: 500 }
            },

            Transition
            {
                from: "PROCEED"
                to:   "RETRY"

                ParallelAnimation
                {
                    PropertyAnimation { target: _loginTransform;   property: "angle"; duration: 1500 }
                    PropertyAnimation { target: _loginForm;   property: "color"; duration: 1500 }
                }
            },

            Transition
            {
                from: "PROCEED"
                to:   "SUCCESS"

                SequentialAnimation
                {
                    PropertyAnimation { target: _loginTransform;   property: "angle"; duration: 1000 }
                    PropertyAnimation { target: _successTransform; property: "angle"; duration: 1000 }
                }
                SequentialAnimation
                {
                    PropertyAnimation { target: _loginForm;   property: "opacity"; duration: 1000 }
                    PropertyAnimation { target: _successForm; property: "opacity"; duration: 1000 }
                }
            }



        ] // transitions

    } // Item: _item

} // window: _root
