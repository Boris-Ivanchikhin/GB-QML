#include "LoginForm.h"

#include <QVBoxLayout>
#include <QPropertyAnimation>
#include <QParallelAnimationGroup>
#include <QSequentialAnimationGroup>
#include <QGraphicsOpacityEffect>


bool KeyPressEater::eventFilter(QObject* obj, QEvent* event)
{
    Q_UNUSED(obj)

    if (event->type() == QEvent::KeyPress)
    {
        QKeyEvent* keyEvent = static_cast<QKeyEvent*>(event);
        if (keyEvent->key() == Qt::Key_Return || keyEvent->key() == Qt::Key_Enter)
        {
            // Обработка нажатия клавиши Enter
            if (parent())
            {
                LoginForm *ptr = qobject_cast<LoginForm *>(parent());
                if (ptr)
                {
                    ptr->checkCredentials();
                    return true;
                }
            }
        }
    }

    return QObject::eventFilter(obj, event);
}



LoginForm::LoginForm(QWidget *parent)
    : QWidget(parent)
{
    setFixedSize(640, 480);
    setWindowTitle("Login form");
    setStyleSheet("background-color: #e5ecef;");

    QVBoxLayout *mainLayout = new QVBoxLayout(this);
    mainLayout->setContentsMargins(0, 0, 0, 0);

    //QWidget *secondaryFrame = new QWidget(this);
    secondaryFrame = new QWidget(this);
    secondaryFrame->setObjectName("secondaryFrame");
    //loginTextField->setStyleSheet("color: " + textColor + ";");
    secondaryFrame->setStyleSheet(QString ("#secondaryFrame { color: %1; background-color: white; border-radius: 5px; }").arg(textColor));
    //secondaryFrame->setProperty("textColor", QVariant::fromValue(textColor));

    QVBoxLayout *formLayout = new QVBoxLayout(secondaryFrame);
    //formLayout = new QVBoxLayout(secondaryFrame);
    formLayout->setContentsMargins(32, 32, 32, 32);
    formLayout->setSpacing(32);

    // Создание шрифта с нужным размером
    QFont font;
    font.setPointSize(14);

    KeyPressEater *keyPressEater = new KeyPressEater(this);

    loginTextField = new QLineEdit(secondaryFrame);
    loginTextField->setFont(font);
    loginTextField->setPlaceholderText("Логин");
    loginTextField->installEventFilter(keyPressEater);

    formLayout->addWidget(loginTextField);

    passwordTextField = new QLineEdit(secondaryFrame);
    passwordTextField->setFont(font);
    passwordTextField->setPlaceholderText("Пароль");
    passwordTextField->setEchoMode(QLineEdit::Password);
    passwordTextField->installEventFilter(keyPressEater);

    formLayout->addWidget(passwordTextField);

    submitButton = new QPushButton("Вход", secondaryFrame);
    submitButton->setFont(font);
    submitButton->setFixedSize(200, 40);
    submitButton->setStyleSheet("QPushButton { background-color: #f6f6f6; border: 1px solid #d6d6d6; }"
                                "QPushButton:hover { background-color: #d6d6d6; }"
                                "QPushButton:pressed { background-color: #bbbbbb; }");
    formLayout->addWidget(submitButton);

    mainLayout->addStretch();
    mainLayout->addWidget(secondaryFrame, 0, Qt::AlignCenter);
    mainLayout->addStretch();

    connect(submitButton, &QPushButton::clicked, this, &LoginForm::checkCredentials);
}

bool LoginForm::checkCredentials()
{
    if (login == loginTextField->text() && password == passwordTextField->text())
    {
        qDebug() << "Удачный вход";
        successAnimation();
        return true;
    }
    else
    {
        qDebug() << "Неудачный вход";
        failAnimation();
        return false;
    }
}

void LoginForm::failAnimation()
{
    QColor defColor(textColor), redColor("dark red");

    QParallelAnimationGroup *totalAnimation = new QParallelAnimationGroup(this);

    QSequentialAnimationGroup *colorAnimation = new QSequentialAnimationGroup(totalAnimation);

    {// QLineEdit *loginTextField
        QPropertyAnimation* animation1 = new QPropertyAnimation(this, "color", colorAnimation);
        animation1->setDuration(0);
        animation1->setStartValue(defColor);
        animation1->setEndValue(redColor);
    }
    {// QLineEdit *passwordTextField
        QPropertyAnimation* animation2 = new QPropertyAnimation(this, "color", colorAnimation);
        animation2->setDuration(400);
        animation2->setStartValue(redColor);
        animation2->setEndValue(defColor);
    }

    QSequentialAnimationGroup *posAnimation = new QSequentialAnimationGroup(totalAnimation);

    QPoint position = secondaryFrame->pos();
    int x = position.x(), y = position.y();

    {// secondaryFrame: x-=5;
        QPropertyAnimation *animation3 = new QPropertyAnimation(secondaryFrame, "pos", posAnimation);
        animation3->setDuration(50);
        animation3->setStartValue(QPoint(x, y));
        animation3->setEndValue(QPoint(x - 5, y));
    }

    {//secondaryFrame: x+=5;
        QPropertyAnimation *animation4 = new QPropertyAnimation(secondaryFrame, "pos", posAnimation);
        animation4->setDuration(100);
        animation4->setStartValue(QPoint(x - 5, y));
        animation4->setEndValue(QPoint(x + 5, y));
    }
    {//secondaryFrame: возврат;
        QPropertyAnimation *animation5 = new QPropertyAnimation(secondaryFrame, "pos", posAnimation);
        animation5->setDuration(50);
        animation5->setStartValue(QPoint(x + 5, y));
        animation5->setEndValue(QPoint(x, y));
    }

    totalAnimation->start();
}


void LoginForm::successAnimation()
{
    QSequentialAnimationGroup *successAnimation = new QSequentialAnimationGroup(this);

    // QLineEdit *loginTextField;
    QGraphicsOpacityEffect *opacityEffect1 = new QGraphicsOpacityEffect(loginTextField);
    loginTextField->setGraphicsEffect(opacityEffect1);

    QPropertyAnimation *opacityAnimation1 = new QPropertyAnimation(opacityEffect1, "opacity", successAnimation);
    opacityAnimation1->setDuration(400);
    opacityAnimation1->setStartValue(1.0);
    opacityAnimation1->setEndValue(0.0);
    //successAnimation->addAnimation(opacityAnimation1);

//    // QLineEdit *loginTextField;
//    QPropertyAnimation *opacityAnimation1 = new QPropertyAnimation(loginTextField, "styleSheet");
//    opacityAnimation1->setDuration(400);
//    opacityAnimation1->setStartValue("");
//    opacityAnimation1->setEndValue("background-color: transparent; color: transparent;");
//    successAnimation->addAnimation(opacityAnimation1);

    // QLineEdit *passwordTextField;
    QGraphicsOpacityEffect *opacityEffect2 = new QGraphicsOpacityEffect(passwordTextField);
    passwordTextField->setGraphicsEffect(opacityEffect2);

    QPropertyAnimation *opacityAnimation2 = new QPropertyAnimation(opacityEffect2, "opacity", successAnimation);
    opacityAnimation2->setDuration(400);
    opacityAnimation2->setStartValue(1.0);
    opacityAnimation2->setEndValue(0.0);
    //successAnimation->addAnimation(opacityAnimation2);

    // QPushButton *submitButton;
    QGraphicsOpacityEffect *opacityEffect3 = new QGraphicsOpacityEffect(submitButton);
    submitButton->setGraphicsEffect(opacityEffect3);

    QPropertyAnimation *opacityAnimation3 = new QPropertyAnimation(opacityEffect3, "opacity");
    opacityAnimation3->setDuration(400);
    opacityAnimation3->setStartValue(1.0);
    opacityAnimation3->setEndValue(0.0);
    successAnimation->addAnimation(opacityAnimation3);

    // QWidget *secondaryFrame
    QPropertyAnimation *opacityAnimation4 = new QPropertyAnimation(secondaryFrame, "styleSheet", successAnimation);
    opacityAnimation4->setDuration(600);
    opacityAnimation4->setStartValue("");
    opacityAnimation4->setEndValue("background-color: transparent; color: transparent;");
    //successAnimation->addAnimation(opacityAnimation4);

    successAnimation->start();

    loginTextField->setDisabled(true);
    passwordTextField->setDisabled(true);
    submitButton->setDisabled(true);
}


const QColor& LoginForm::color() const
{
    return m_color;
}

void LoginForm::setColor(const QColor &newColor)
{
    QString style = QString("color: rgb(%1, %2, %3);").
                    arg(newColor.red()).
                    arg(newColor.green()).
                    arg(newColor.blue());

    loginTextField->setStyleSheet(style);
    passwordTextField->setStyleSheet(style);

    m_color = newColor;

    emit onChangedColor(newColor);
}
