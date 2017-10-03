/*****************************************************************************
 *   Copyright (C) 2016 by Yunusemre Senturk                                 *
 *   <yunusemre.senturk@pardus.org.tr>                                       *
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

#include "filemanager.h"
#include <QTextStream>
#include <QFile>
#include <QFileInfo>
#include <QByteArray>

FileManager::FileManager(QObject *parent) :
    QObject(parent)
{

}


QJsonValue FileManager::convertFile(const QString& filePath) const
{
    QByteArray bytes;
    QFile file(filePath);
    if(file.exists()) {
        if (!file.open(QIODevice::ReadOnly)) {
            qDebug("Couldn't open the file");
        } else {
            bytes = file.readAll();
        }

    } else {
        qDebug("Couldn't find the file");
    }
    return QJsonValue(QString::fromLatin1(bytes.toBase64()));
}

QString FileManager::getFileName(const QString &filePath) const
{
    QString fn = "unknown";
    QFile file(filePath);
    if(file.exists()) {
        fn = QFileInfo(file.fileName()).fileName();
    } else {
        qDebug("Couldn't find the file");
    }
    return fn;
}
