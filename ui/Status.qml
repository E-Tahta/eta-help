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

import QtQuick 2.0
import QtQuick.Controls 1.2

Item {
    Image {
        id: svgBusy
        source: "Images/busy.svg"
        width: main.width * 3 / 4
        height: main.width * 3 / 4
        visible: main.busy ? true : false
        anchors.centerIn: parent
        NumberAnimation on rotation {
            id: rotationAnimation
            duration: 1000
            from: 0
            to: 360
            loops:Animation.Infinite

        }

    }

    Column {
        id: col1
        spacing: 20
        visible: main.busy ? false : true
        width: parent.width * 3 / 4
        anchors.centerIn: parent

        Image {
            id: svgStatus
            source: main.imageSource
            width: parent.width
            height: parent.width
        }


        Text {
            id: txtStatus
            color: main.textColor
            text: main.message

            font.pointSize: 12
        }
        Text {
            id: txtSub
            text: main.subMessage
            color: main.textColor
            font.pointSize: 8

        }

        Row{
            id: r3
            spacing: main.spacing
            visible: main.imageSource == "Images/failed.svg" ?
                         true : false

            ToolButton {
                id: btnRetry
                width: main.buttonSize
                height: main.buttonSize
                iconSource: "Images/retry.svg"

                onClicked: {
                    main.busy = true
                    if(main.screenshot) {
                        smtp.sendMail(main.mail, main.subject, main.body,
                                      main.ssPath)
                    } else {
                        smtp.sendMail(main.mail, main.subject, main.body)
                    }
                }
            }

            Text {
                id: txtRetry
                text: "Yeniden dene"
                color: main.textColor
                verticalAlignment: Text.AlignVCenter
                height: btnRetry.height

            }

        }
    }
}
