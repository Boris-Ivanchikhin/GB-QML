import QtQuick
import QtQuick.Controls

Window
{
    id: primaryFrame
    width: 640
    height: 480
    visible: true
    title: qsTr("Login form")
    color: "#e5ecef"
    property string login: "login"
    property string password: "password"

    // Javascript-функция для проверки данных
    function checkCredentials()
    {
        if (login === loginTextField.text && password === passwordTextField.text)
        {
            console.log("Удачный вход")
            successAnimation.start()
        }
        else
        {
            console.log("Неудачный вход")
            failAnimation.start()
        }

    }


    Rectangle
    {
        id: secondaryFrame
        color: "white"
        anchors.centerIn: parent // Размещение компонента внутри родительского
        radius: 5 // Закругление углов с выбранным радиусом
        width: 300
        height: 250
        property string textColor: "#535353"

        Column
        {
            anchors.fill: parent
            padding: 32
            spacing: 32

            TextField
            {
                id: loginTextField
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr("Логин")
                color: secondaryFrame.textColor
                // onEnterPressed и onReturnPressed – две кнопки Enter на стандартной клавиатуре
                Keys.onEnterPressed: checkCredentials()
                Keys.onReturnPressed: checkCredentials()
            }

            TextField
            {
                id: passwordTextField
                echoMode: TextInput.Password
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr("Пароль")
                color: secondaryFrame.textColor
                Keys.onEnterPressed: checkCredentials()
                Keys.onReturnPressed: checkCredentials()
            }

            Button
            {
                id: submitButton
                width: 200
                height: 40
                background: Rectangle
                {
                    color: parent.down ? "#bbbbbb" : (parent.hovered ? "#d6d6d6" : "#f6f6f6")
                }
                text: qsTr("Вход")
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: checkCredentials()
            }
        }
    }

    // анимации внутри ParallelAnimation будут выполнены параллельно
    ParallelAnimation
    {
        id: failAnimation

        SequentialAnimation
        {
            // Группа анимаций внутри SequentialAnimation будет выполнена последовательно
            PropertyAnimation
            {
                // Текст внутри полей логина и пароля моментально изменит цвет на темно-красный
                targets: [loginTextField, passwordTextField]
                property: "color"
                to: "dark red"
                duration: 0
            }

            PropertyAnimation
            {
                // После этого за 400 миллисекунд вернется к обычному цвету
                targets: [loginTextField, passwordTextField]
                property: "color"
                to: secondaryFrame.textColor
                duration: 400
            }
        }

        SequentialAnimation
        {
            // Подложка secondaryFrame сместится на -5 пикселей относительно
            // центра, затем передвинется на позицию +5, а потом вернётся в исходное положение.
            // Произойдет “потрясывание” формы.
            NumberAnimation { target: secondaryFrame; property: "anchors.horizontalCenterOffset"; to: -5; duration: 50 }
            NumberAnimation { target: secondaryFrame; property: "anchors.horizontalCenterOffset"; to: 5; duration: 100 }
            NumberAnimation { target: secondaryFrame; property: "anchors.horizontalCenterOffset"; to: 0; duration: 50 }
        }
    }

    SequentialAnimation
    {
        id: successAnimation

        PropertyAnimation
        {
            targets: [loginTextField, passwordTextField, submitButton]
            property: "opacity"
            to: 0
            duration: 400
        }

        PropertyAnimation
        {
            target: secondaryFrame
            property: "opacity"
            to: 0
            duration: 600
        }
    }
}

