/*****************************************************************************
 *   Copyright (C) 2016 by Hikmet Bas                                        *
 *   <hikmet.bas@pardus.org.tr>                                              *
 *                                                                           *
 *   This program is free software; you can redistribute it and/or modify    *
 *   it under the terms of the GNU General Public License as published by    *
 *   the Free Software Foundation; either version 2 of the License, or       *
 *   (at your option) any later version.                                     *
 *                                                                           *
 *   This program is distributed in the hope that it will be useful,         *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of          *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           *
 *   GNU General Public License for more details.                            *
 *                                                                           *
 *   You should have received a copy of the GNU General Public License       *
 *   along with this program; if not, write to the                           *
 *   Free Software Foundation, Inc.,                                         *
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .          *
 *****************************************************************************/

import QtQuick 2.3
import QtQuick.Controls 1.2
import "../js/functions.js" as Func

Item{

    Column {
        id: column1
        anchors.centerIn: parent
        width: parent.width * 4 / 5
        spacing: main.spacing

        Row {
            id: r1
            spacing: main.spacing

            ToolButton {
                id: btnBack
                iconSource: "Images/previous.svg"

                width: main.buttonSize
                height: main.buttonSize
                onClicked: stackView.pop()
            }

            Text {
                id: txtMail
                text: main.mail
                color: main.textColor
                verticalAlignment: Text.AlignVCenter
                height: btnBack.height
            }
        }

        Row {
            id: r2
            spacing: main.spacing

            ToolButton {
                id: btnScreenShot
                iconSource:  btnScreenShot.checked ? "Images/success.svg" :
                                                     "Images/screenshot.svg"
                width: main.buttonSize
                height: main.buttonSize
                checkable: true
                onCheckedChanged: {
                    if (btnScreenShot.checked) {
                        ssAnimation.start()
                    } else {
                        main.ssPath = "";
                        main.screenshot = false
                    }
                }
            }

            Text {
                id: txtScreenShot
                height:  btnScreenShot.height
                text: btnScreenShot.checked ? "Ekran görüntüsünü eklendi" :
                                              "Ekran görüntüsünü ekle"
                color: main.textColor
                verticalAlignment: Text.AlignVCenter
            }
        }

        Text {
            id: txtSubject
            text: "Konu"
            color: main.textColor
        }

        TextField {
            id: tfSubject
            width: parent.width
            height: 20
            onFocusChanged: {
                if (tfSubject.focus) {
                    smtp.showKeyboard();
                }
            }
        }

        Text {
            id: txtMessage
            text: "Açıklama"
            color: main.textColor
        }

        TextArea {
            id: tiMessage
            width: parent.width
            height: 200
            onFocusChanged: {
                if (tiMessage.focus) {
                    smtp.showKeyboard();
                }
            }
        }

        Row{
            id: r3
            spacing: main.spacing

            ToolButton {
                id: btnSend
                width: main.buttonSize
                height: main.buttonSize
                iconSource: "Images/next.svg"
                onClicked: {
                    if (!(Func.checkText(tfSubject.text.trim().toString())) &&
                            !(Func.checkText(tiMessage.text.trim().toString())))
                    {
                        txtError.opacity = 0
                        stackView.push(status)
                        main.subject = tfSubject.text.toString()
                        main.body = tiMessage.text.toString()
                        if(main.screenshot) {
                            smtp.sendMail(main.mail, main.subject, main.body,
                                          main.ssPath)
                        } else {
                            smtp.sendMail(main.mail, main.subject, main.body)
                        }
                    } else {
                        txtError.opacity = 1
                    }
                }
            }

            Text {
                id: txtSend
                text: "Gönder"
                color: main.textColor
                verticalAlignment: Text.AlignVCenter
                height: btnSend.height
            }

        }
        Text {
            id: txtError
            text: "Konu ve açıklama boş bırakılamaz"
            verticalAlignment: Text.AlignVCenter
            height: btnSend.height
            opacity: 0
            color: "#FF5722"
        }
    }

    NumberAnimation {
        id: ssAnimation
        target: main
        property: "opacity"
        from: 1
        to: 0
        duration: 0

        onStopped: {
            main.ssPath = smtp.getScreenShot();
            main.screenshot = true
            ssFadeIn.start()
        }

    }

    NumberAnimation {
        id: ssFadeIn
        target: main
        property: "opacity"
        from: 0
        to: 1
        duration: 300
    }
}
