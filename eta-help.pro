TEMPLATE = app

QT += qml quick widgets network svg dbus

SOURCES += src/main.cpp \
    src/bridge.cpp \
    src/requestmanager.cpp \
    src/filemanager.cpp

RESOURCES += qml.qrc images.qrc

HEADERS += \
    src/bridge.h \
    src/requestmanager.h \
    src/filemanager.h

TARGET = eta-help


target.path = /usr/bin/

icon.files = help.svg
icon.commands = mkdir -p /usr/share/eta/eta-help/icon
icon.path = /usr/share/eta/eta-help/icon/

etaman.files = user_guide.pdf
etaman.commands = mkdir -p /usr/share/eta/eta-help
etaman.path = /usr/share/eta/eta-help/

desktop_file.files = eta-help.desktop
desktop_file.path = /usr/share/applications/

INSTALLS += target icon etaman desktop_file

