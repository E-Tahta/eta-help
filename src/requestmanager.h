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

#ifndef REQUESTMANAGER_H
#define REQUESTMANAGER_H

#include <QObject>

class QNetworkReply;
class QNetworkAccessManager;
class QNetworkRequest;
class FileManager;

#define URL "http://etahelp.etap.org.tr/etahelp.php"

class RequestManager : public QObject
{
    Q_OBJECT
public:
    explicit RequestManager(QObject *parent = 0);

private:
    QNetworkAccessManager *nam;
    QNetworkRequest *request;
    FileManager *fm;

signals:
    void gotResult(bool b);

public slots:
    void requestFinished(QNetworkReply *r);
    void sendMail(const QString &from, const QString &subject,
                  const QString& details, const QString &filePath);

};

#endif // REQUESTMANAGER_H
