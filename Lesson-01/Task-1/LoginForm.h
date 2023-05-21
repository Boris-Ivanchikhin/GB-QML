#ifndef LOGINFORM_H
#define LOGINFORM_H

#include <QWidget>
#include <QColor>

#include <QLineEdit>
#include <QPushButton>

#include <QEvent>
#include <QKeyEvent>
#include <QDebug>


class KeyPressEater : public QObject
{
    Q_OBJECT

public:

    KeyPressEater (QObject *parent = nullptr) : QObject(parent) {};
    ~KeyPressEater() = default;

protected:

    bool eventFilter(QObject* , QEvent* ) override;
};



class LoginForm : public QWidget
{
    Q_OBJECT
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY onChangedColor)

public:
    LoginForm(QWidget *parent = nullptr);
    ~LoginForm(){};

    bool checkCredentials();

    const QColor& color() const;
    void setColor(const QColor &newColor);

private:

    void failAnimation();
    void failAnimation2();


    void successAnimation();

signals:

    void onChangedColor(const QColor);

private:

    QColor m_color{};

    const QString login{"login"};
    const QString password{"password"};
    const QString textColor{"#535353"};

    QLineEdit *loginTextField;
    QLineEdit *passwordTextField;
    QPushButton *submitButton;

    QWidget *secondaryFrame;
    //QVBoxLayout *formLayout;
};

#endif // LOGINFORM_H
