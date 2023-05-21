import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls


Window {
    width: 400
    height: 400
    visible: true
    title: qsTr("Lesson 01. Task 3 (Heron).")

    // Readonly properties used as constants
    readonly property int defMargin: 10
    readonly property color brdColor: "#363636"

    // Aliases
    property alias _result: result.text
    property alias _title:  resultTitle.text

    property int textPixels:
    {
        if (width > 700)
            return 18;
        else if (width > 500 && width <= 700)
            return 14;
        else if (width > 300 && width <= 500)
            return 12;

        return 8;
    }

    Rectangle
    {
        anchors.fill: parent
        Image
        {
            anchors.fill: parent
            source: "qrc:/images/back-01.jpg" // или "URL_изображения"
            //fillMode: Image.PreserveAspectFit
        }
    }

    function calc()
    {
        var _x1 = parseFloat(x1.text)
        var _y1 = parseFloat(y1.text)
        var _x2 = parseFloat(x2.text)
        var _y2 = parseFloat(y2.text)
        var _x3 = parseFloat(x3.text)
        var _y3 = parseFloat(y3.text)

        var s = Math.abs((_x2-_x1)*(_y3-_y1) - (_x3-_x1)*(_y2-_y1)) / 2;

        //var p = (A + B + C) / 2
        //print ("p = " + p)
        //var s = Math.sqrt (p * (p - A) * (p - B) * (p - C))
        //print ("s = " + s)

        if (isNaN(s) || s === Infinity)
        {
            _title  = "Calculation"
            _result = "error!"
            return
        }

        _title  = "Result -> "
        _result = s
    }

    ColumnLayout
    {
        visible: true
        anchors.fill: parent
        anchors.margins: defMargin
        spacing: defMargin
        scale: 0.9
        transformOrigin: Item.Center
        clip: false

        Rectangle
        {
            id: labelRectangle
            width: 200
            height: 200
            color: "transparent"
            Layout.fillWidth: true
            Layout.fillHeight: true

            Text
            {
                anchors.fill: parent
                anchors.centerIn: labelRectangle
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter

                text: "Площадь треугольника по трём сторонам (формула Герона)"
                font.pixelSize: Math.round (textPixels * 1.5)

                wrapMode: Text.WordWrap
            }
        }

        Rectangle
        {
            id: rectangle1
            width: 200
            height: 300
            //color: bgColor
            color: "transparent" // Цвет прозрачный
            Layout.fillHeight: true
            Layout.fillWidth: true

            GridLayout
            {
                id: grid
                anchors.fill: parent
                columns: 4

//                Rectangle
//                {
//                    Layout.fillHeight: true
//                    Layout.fillWidth: true
//                    Layout.columnSpan: 4
//                    Layout.row: 0
//                    color: "transparent"
//                }

                // Layout.row: 0
                Rectangle
                {

                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    //Layout.columnSpan: 1
                    //Layout.row: 0
                    //Layout.column: 0
                    color: "transparent"

                    Text
                    {
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignRight //.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: textPixels
                        text: qsTr("X(1) : ")
                    }
                }

                Rectangle
                {

                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    //Layout.columnSpan: 1
                    //Layout.row: 0
                    //Layout.column: 1

                    TextField
                    {
                        id: x1
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: textPixels
                        //text: qsTr("")

                        validator: DoubleValidator //IntValidator
                        {
                            notation: DoubleValidator.StandardNotation
                            bottom: -1000.0
                            top: 1000.0
                        }
                        inputMethodHints: Qt.ImhFormattedNumbersOnly //ImhDigitsOnly

                        Keys.onEnterPressed:  calc()
                        Keys.onReturnPressed: calc()
                        onFocusChanged:
                        {
                            if (activeFocus)
                            { selectAll(); }
                        }

                    }
                }


                Rectangle
                {

                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    //Layout.columnSpan: 1
                    //Layout.row: 0
                    //Layout.column: 2
                    color: "transparent"

                    Text
                    {
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignRight //.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: textPixels
                        text: qsTr("Y(1) : ")
                    }
                }

                Rectangle
                {

                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    //Layout.columnSpan: 1
                    //Layout.row: 0
                    //Layout.column: 3

                    TextField
                    {
                        id: y1
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: textPixels
                        //text: qsTr("")
                        //selectAllOnFocus: true

                        validator: DoubleValidator //IntValidator
                        {
                            notation: DoubleValidator.StandardNotation
                            bottom: -1000.0
                            top: 1000.0
                        }
                        inputMethodHints: Qt.ImhFormattedNumbersOnly //ImhDigitsOnly

                        Keys.onEnterPressed:  calc()
                        Keys.onReturnPressed: calc()
                        onFocusChanged:
                        {
                            if (activeFocus)
                            { selectAll(); }
                        }

                    }
                }

                // Layout.row: 1

                Rectangle
                {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    //Layout.columnSpan: 1
                    //Layout.row: 1
                    //Layout.column: 0

                    color: "transparent"

                    Text
                    {
                        text: qsTr("X(2) : ")
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignRight //HCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: textPixels
                    }
                }

                Rectangle
                {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    //Layout.columnSpan: 1
                    //Layout.row: 1
                    //Layout.column: 1

                    TextField
                    {
                        id: x2
                        //text: qsTr("")
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: textPixels
                        inputMethodHints: Qt.ImhFormattedNumbersOnly //ImhDigitsOnly
                        validator: DoubleValidator //IntValidator
                        {
                            notation: DoubleValidator.StandardNotation
                            bottom: -1000.0
                            top: 1000.0
                        }

                        Keys.onEnterPressed:  calc()
                        Keys.onReturnPressed: calc()
                        onFocusChanged:
                        {
                            if (activeFocus)
                            { selectAll(); }
                        }
                    }
                }

                Rectangle
                {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    //Layout.columnSpan: 1
                    //Layout.row: 1
                    //Layout.column: 2

                    color: "transparent"

                    Text
                    {
                        text: qsTr("Y(2) : ")
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignRight //HCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: textPixels
                    }
                }

                Rectangle
                {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    //Layout.columnSpan: 1
                    //Layout.row: 1
                    //Layout.column: 3

                    TextField
                    {
                        id: y2
                        //text: qsTr("")
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: textPixels
                        inputMethodHints: Qt.ImhFormattedNumbersOnly //ImhDigitsOnly
                        validator: DoubleValidator //IntValidator
                        {
                            notation: DoubleValidator.StandardNotation
                            bottom: -1000.0
                            top: 1000.0
                        }

                        Keys.onEnterPressed:  calc()
                        Keys.onReturnPressed: calc()
                        onFocusChanged:
                        {
                            if (activeFocus)
                            { selectAll(); }
                        }
                    }
                }

                // Layout.row: 2

                Rectangle
                {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    //Layout.columnSpan: 1
                    //Layout.row: 2
                    //Layout.column: 0
                    color: "transparent"

                    Text
                    {
                        text: qsTr("X(3) : ")
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignRight //HCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: textPixels
                    }
                }

                Rectangle
                {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    //Layout.columnSpan: 1
                    //Layout.row: 2
                    //Layout.column: 1

                    TextField
                    {
                        id: x3
                        text: qsTr("")
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: textPixels
                        inputMethodHints: Qt.ImhFormattedNumbersOnly //ImhDigitsOnly
                        validator: DoubleValidator //IntValidator
                        {
                            notation: DoubleValidator.StandardNotation
                            bottom: -1000.0
                            top: 1000.0
                        }

                        Keys.onEnterPressed:  calc()
                        Keys.onReturnPressed: calc()
                        onFocusChanged:
                        {
                            if (activeFocus)
                            { selectAll(); }
                        }
                    }
                }

                Rectangle
                {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    //Layout.columnSpan: 1
                    //Layout.row: 2
                    //Layout.column: 2
                    color: "transparent"

                    Text
                    {
                        text: qsTr("Y(3) : ")
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignRight //HCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: textPixels
                    }
                }

                Rectangle
                {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    //Layout.columnSpan: 1
                    //Layout.row: 2
                    //Layout.column: 3

                    TextField
                    {
                        id: y3
                        text: qsTr("")
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: textPixels
                        inputMethodHints: Qt.ImhFormattedNumbersOnly //ImhDigitsOnly
                        validator: DoubleValidator //IntValidator
                        {
                            notation: DoubleValidator.StandardNotation
                            bottom: -1000.0
                            top: 1000.0
                        }

                        Keys.onEnterPressed:  calc()
                        Keys.onReturnPressed: calc()
                        onFocusChanged:
                        {
                            if (activeFocus)
                            { selectAll(); }
                        }
                    }
                }

                // Layout.row: 3

                Rectangle
                {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.columnSpan: 4
                    //Layout.row: 3
                    color: "transparent"
                }



                // Layout.row: 4

                // * Сalculate

                Rectangle
                {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.columnSpan: 4
                    //Layout.row: 4
                    color: "transparent"
                    opacity: 0.5
                    border.color: brdColor
                    radius: 10
                    border.width: 2

                    Button
                    {
                        anchors.fill: parent
                        text: "Сalculate"
                        font.pointSize: textPixels
                        font.weight: Font.Bold

                        onClicked: calc()
                    }
                }

                // Layout.row: 5

                // * Result

                Rectangle
                {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.columnSpan: 2
                    //Layout.row: 5
                    //Layout.column: 0
                    color: "transparent"

                    Text
                    {
                        id: resultTitle
                        //text: qsTr("Result ->")
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignRight //HCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: textPixels
                        font.weight: Font.Bold
                    }
                }

                Rectangle
                {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: "transparent"
                    //clip: false
                    Layout.columnSpan: 2
                    //Layout.row: 5
                    //Layout.column: 2

                    Text
                    {
                        id: result
                        //text: qsTr("")
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignLeft //HCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: textPixels
                        font.weight: Font.Bold
                        //readOnly: true
                    }
                }


            }

        }

    }
}
