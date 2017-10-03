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

Item {
    Column {
        id: column1
        anchors.centerIn: parent
        width: parent.width * 4 / 5
        height: parent.height / 2
        spacing: main.spacing

        Text {
            id: txtMail
            text: qsTr("Kendi E-posta adresinizi giriniz")
        }

        Row{
            id: r1
            spacing: main.spacing
            width: parent.width

            TextField {
                id: tfMail
                width: parent.width - parent.spacing - btnNext.width
                height: btnNext.height
                onFocusChanged: {
                    if (tfMail.focus) {
                        smtp.showKeyboard();
                    }
                }
            }

            ToolButton {
                id: btnNext
                iconSource: "Images/next.svg"
                width: main.buttonSize
                height: main.buttonSize

                onClicked:{
                    if (Func.checkMail(tfMail.text.toString().trim())){
                        stackView.push(help)
                        txtError.opacity = 0
                        main.mail = tfMail.text.toString()
                    }
                    else {
                        txtError.opacity = 1
                    }
                }
            }
        }

        Text {
            id: txtError
            text: qsTr("Lütfen geçerli bir e-posta adresi giriniz")
            color: "red"
            opacity: 0
        }


        Image {
            id: pardus
            source: "Images/pardus.svg"
            width: parent.width
            height: pardus.width * 9/10
            opacity: 0.1
        }

    }
}
