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

#include "requestmanager.h"
#include "filemanager.h"
#include <QNetworkRequest>
#include <QUrl>
#include <QJsonObject>
#include <QNetworkAccessManager>
#include <QJsonDocument>
#include <QNetworkReply>
#include <QJsonValue>
#include <QDebug>


RequestManager::RequestManager(QObject *parent) :
    QObject(parent)
{
    nam = new QNetworkAccessManager(this);
    fm = new FileManager(this);
    request = new QNetworkRequest(QUrl(URL));
    request->setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    connect(nam, SIGNAL(finished(QNetworkReply*)),
            this, SLOT(requestFinished(QNetworkReply*)));
}



void RequestManager::sendMail(const QString& from, const QString& subject,
                              const QString& details, const QString& filePath)
{
    QJsonObject data;
    data.insert("from", from);
    data.insert("subject", subject);
    data.insert("details", details);
    data.insert("filename", fm->getFileName(filePath));
    data.insert("attach",fm->convertFile(filePath));
    data.insert("status","");
    nam->post(*request, QJsonDocument(data).toJson());
}

void RequestManager::requestFinished(QNetworkReply *r)
{
    QByteArray response_data = r->readAll();
    QJsonDocument response_doc = QJsonDocument::fromJson(response_data);
    QJsonObject response = response_doc.object();
    bool b = response.value("status").toBool();
    emit gotResult(b);
}
