import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window
{
    id: _root
    visible: true
    width: 640
    height: 480
    title: qsTr("Lesson 03. Task 3.")

    readonly property color bgColor   : "#333333"
    readonly property color panelColor: "#999999"
    readonly property int defSpacing : 2

    ListModel
    {
        id: _books
        ListElement
        {
            path: "qrc:/book-256.png"
            name: "Book #1"
            genre: "Genre #1"
            author: "Author #1"
        }
        ListElement
        {
            path: "qrc:/book-256.png"
            name: "Book #2"
            genre: "Genre #2"
            author: "Author #2"
        }
        ListElement
        {
            path: "qrc:/book-256.png"
            name: "Book #3"
            genre: "Genre #3"
            author: "Author #3"
        }
    } // ListModel

    ListView
    {
        id: _list
        anchors.fill: parent
        model: _books
        spacing: defSpacing

        // header
        header: Rectangle
        {
            width: parent.width
            height: 30
            color: bgColor// "darkblue"
            Text
            {
                anchors.centerIn: parent
                text: "Library"
                color: "white"
                font.pointSize: 12
                font.bold: true
            }
        }

        // footer
        footer: Rectangle
        {
            width: parent.width
            height: 25
            color: bgColor//"darkgreen"
            Text
            {
                anchors.centerIn: parent
                text: "Copyright"
                color: panelColor //"White"
                font.pointSize: 10
                font.bold: true
            }
        }

        section.delegate: Rectangle
        {
            width: parent.width
            height: 25
            color: "lightblue"
            Text
            {
                anchors.centerIn: parent
                text: section
                color: bgColor//"darkblue"
                font.weight: Font.Bold
            }
        }

        section.property: "genre"
        delegate: Rectangle
        {
            width: parent.width
            height: 100
            radius: 3
            border.width: 1
            border.color: bgColor //"darkgrey"
            color: panelColor //"lightgrey"

            Column
            {
                spacing: defSpacing * 2
                anchors.fill: parent

                Row
                {
                    topPadding: 5
                    anchors.horizontalCenter: parent.horizontalCenter

                    Label
                    {
                        width: 30
                        height: 30

                        background: Image
                        {
                            source: path
                            anchors.fill: parent
                            fillMode: Image.PreserveAspectFit
                        }
                    }
                }

                Row
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text { text: "Название: "; font.weight: Font.Bold }
                    Text { text: name}
                }
                Row
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text { text: "Жанр: "; font.weight: Font.Bold }
                    Text { text: genre}
                }
                Row
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text { text: "Автор: "; font.weight: Font.Bold }
                    Text { text: author}
                }

            } // Column

        } // delegate: Rectangle

    } // ListView
}
