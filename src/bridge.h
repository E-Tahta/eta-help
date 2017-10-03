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

#ifndef BRIDGE_H
#define BRIDGE_H

#include <QObject>
#include <QString>

class QDBusInterface;


class RequestManager;
class Bridge : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString server READ server
               NOTIFY sent
               NOTIFY failed)
public:
    explicit Bridge(QObject *parent = 0);
    QString server() const;
    Q_INVOKABLE void sendMail(const QString &from, const QString &subject,
                              const QString &body, const QString &filePath);
    Q_INVOKABLE void sendMail(const QString &from, const QString &subject,
                              const QString &body);
    Q_INVOKABLE QString getScreenShot() const;
    Q_INVOKABLE void showKeyboard();
    Q_INVOKABLE void hideKeyboard();    
private:    
    QString srv;
    QDBusInterface *interface;    
    RequestManager *rm;
signals:
    void sent();
    void failed();
public slots:
    void sentSlot(const bool &);
};

#endif // BRIDGE_H
