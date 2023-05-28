import QtQuick
import QtQuick.Window
import QtQuick.Controls

ApplicationWindow
{
    width: 640
    height: 480
    visible: true
    title: qsTr("Lesson 02. Tasks 2,3.")

    Rectangle
    {
        id: rect
        width: 300
        height: width
        anchors.centerIn: parent
        color: "blue"

        MouseArea
        {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton

            onDoubleClicked: function(mouse)
            {
                if (mouse.button === Qt.LeftButton)
                    parent.radius = (parent.radius === 0 ? parent.height / 2 : 0);
            }

            onClicked: function(mouse)
            {
                if (mouse.button === Qt.RightButton)
                    rotationAnimation.start();
                else if (mouse.button === Qt.LeftButton)
                    parent.color = Qt.rgba(Math.random(),Math.random(),Math.random(),1);
            }
        }

        RotationAnimation on rotation
        {
            id: rotationAnimation
            from:0
            to: 360
            duration: 1500;
            running: false
        }
    }
}
