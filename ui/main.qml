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
import QtQuick.Window 2.0
import eta.smtp 1.0

ApplicationWindow {
    id: main
    visible: true
    width: 300
    height: 450
    title: "Eta Yardım"
    color: "#383838"
    x: 0
    y: Screen.height - main.height
    flags: Qt.FramelessWindowHint

    property int buttonSize: 30
    property int spacing: 10
    property string mail
    property string subject
    property string body
    property bool busy: true
    property bool screenshot: false
    property string imageSource
    property string message
    property string subMessage
    property string ssPath
    property string textColor: "#eeeeee"

    ToolButton {
        id: btnClose
        iconSource: "Images/close.svg"
        width: main.width/10
        height: btnClose.width
        x: parent.width - btnClose.width
        onClicked: {
            Qt.quit();
        }
    }

    EtaSmtp {
        id: smtp
        onSent: {
            main.busy = false
            main.imageSource = "Images/success.svg"
            main.message = "Geri bildiriminiz iletilmiştir."
            main.subMessage = "Teşekkürler..."
        }

        onFailed: {
            main.busy = false
            main.imageSource = "Images/failed.svg"
            main.message = "Geri bildiriminiz iletilememiştir."
            main.subMessage = "Bağlantınızı kontrol edin\nveya daha sonra tekrar deneyin."
        }
    }

    Mail {
        id: mail
        visible: false
    }

    Help {
        id: help
        visible: false
    }

    Status {
        id: status
        visible: false
    }

    StackView {
        id: stackView
        anchors.fill: parent
    }
    Component.onCompleted: {
        if (!true){
            main.busy = false
            main.imageSource = "Images/failed.svg"
            main.message = "Posta sunucusu ayar dosyanız\nbulunamıyor!"
            main.subMessage = "Lütfen sistem yöneticiniz ile görüşün"
            stackView.push(status)
        } else {
            stackView.push(mail)
        }
    }
}
