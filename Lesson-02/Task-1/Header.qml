import QtQuick
import QtQuick.Controls

// Page 1

Rectangle
{
    id: root
    property alias title: lblTitle.text
    property alias textColor: lblTitle.color
    //color: "blue"
    //color: "transparent"
    height: 60

    Rectangle
    {
        anchors.fill: parent
        opacity: 0.5

        Image
        {
            anchors.fill: parent
            source: "qrc:/img/back1.png"
            //fillMode: Image.PreserveAspectFit
        }
    }

    // Avatar circle
    Rectangle
    {
        id: imgAvatar
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: defMargin
        anchors.leftMargin: defMargin * 2

        height: root.height*0.8
        width: height
        radius: height/2
        //color: win.bubbleColor
        color: "transparent"
        border.color: bgColor
        border.width: 3

        // Image circle
        Image
        {
            id: imgCircle
            source: "qrc:/img/icon.png"
            fillMode: Image.PreserveAspectFit
            anchors.fill: parent
        }

    }

    // Title label
    Label
    {
        id: lblTitle
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: bubbleColor//textColor
        font.pixelSize: root.height*0.4
        font.bold: true
        background: Rectangle
        {
            color: "transparent"
            //border.color: parent.hovered ? "dark red" : " black"
        }
    }

    Button
    {
        id: btnBack
        text: " < Back "
        palette.buttonText: main.textColor//win.btnColor
        visible: (stackView.depth > 1)
        //color: textColor

        anchors.right: root.right
        anchors.verticalCenter: root.verticalCenter
        anchors.margins: defMargin * 2
        font.pixelSize: 15

        background: Rectangle
        {
            opacity: 0.5
            color: bgColor//.panelColor
            radius: 5
            border.color: bgColor
            border.width: 2
        }

        onClicked:
        {
            popPage()
        }

    }
}
