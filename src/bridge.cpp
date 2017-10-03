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

#include "bridge.h"
#include "requestmanager.h"
#include <QPixmap>
#include <QDir>
#include <QScreen>
#include <QGuiApplication>
#include <QDBusConnection>
#include <QDBusInterface>

Bridge::Bridge(QObject *parent) :
    QObject(parent)
{
    srv = "etdestek";
    rm = new RequestManager(this);
    connect(rm,SIGNAL(gotResult(bool)),this,SLOT(sentSlot(bool)));
    QDBusConnection dbus = QDBusConnection::sessionBus();
    interface = new QDBusInterface("org.eta.virtualkeyboard",
                                   "/VirtualKeyboard",
                                   "org.eta.virtualkeyboard",
                                   dbus,
                                   this);
}

void Bridge::showKeyboard()
{
    interface->call("showFromBottom");
}

void Bridge::hideKeyboard()
{
    interface->call("hide");
}

QString Bridge::server() const
{
    return srv;
}
void Bridge::sendMail(const QString &from, const QString &subject,
                      const QString &body, const QString &filePath)
{    
    rm->sendMail(from,subject,body,filePath);
}

void Bridge::sendMail(const QString &from, const QString &subject,
                      const QString &body)
{
    const QString emptyPath = "";
    rm->sendMail(from,subject,body,emptyPath);
}

void Bridge::sentSlot(const bool &b)
{
    if (b) {
        emit sent();
    } else {
        emit failed();
    }
}

QString Bridge::getScreenShot() const
{
    QPixmap qPixMap;
    QScreen *screen = QGuiApplication::primaryScreen();
       if (screen)
           qPixMap = screen->grabWindow(0);    
    QString format = "jpg";
    QDir::setCurrent("/tmp");
    if(!QDir("Folder").exists())
      QDir().mkdir("eta-help");
    QDir::setCurrent("/tmp/eta-help");
    QString initialPath = QDir::currentPath() + tr("/screen.") + format;
    qPixMap.save(initialPath, format.toLatin1());

    return initialPath;
}


