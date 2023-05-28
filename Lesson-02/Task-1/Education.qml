import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout
{
    // Свойство для хранения выбранного текста
    property string currentTextValue: ""

    anchors.horizontalCenter: parent.horizontalCenter
    width: parent.width / 3 * 2
    spacing: defMargin

    // Сигнал, который будет отправляться при изменении выбранного текста
    //signal currentTextChanged(string text)

    Label
    {
        //width: parent / 2
        text: "Образование: "
        color: bubbleColor
        font.bold: true
        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
    }

    ComboBox
    {
        id: combo
        model: ["В процессе", "Начальное", "Высшее", "Отсутвует"]
        spacing: defMargin
        Layout.fillWidth: true

        delegate: ItemDelegate
        {
            width: combo.width
            contentItem: Text
            {
                text: combo.textRole
                        ? (Array.isArray(combo.model) ? modelData[combo.textRole] : model[combo.textRole])
                        : modelData
                color: textColor//"#21be2b"
                font: combo.font
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
            }
            highlighted: combo.highlightedIndex === index
        }

        background: Rectangle
        {
            opacity: 0.8
            color: bubbleColor//"transparent"
            implicitWidth: 120
            implicitHeight: 40
            //border.color: bgColor//combo.pressed ? "#17a81a" : "#21be2b"
            //border.width: combo.visualFocus ? 4 : 2
            radius: 5
        }

        // Обработчик изменения выбранного текста
        onCurrentTextChanged:
        {

            // Обновляем значение свойства
            currentTextValue = combo.currentText
        }
    }
}
