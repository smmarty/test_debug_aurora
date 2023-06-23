/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
#include <QStandardPaths>

#include "xdga_directories.h"

char *getCacheLocation()
{
    return QStandardPaths::writableLocation(QStandardPaths::CacheLocation).toUtf8().data();
}

char *getAppDataLocation()
{
    return QStandardPaths::writableLocation(QStandardPaths::AppDataLocation).toUtf8().data();
}

char *getDocumentsLocation()
{
    return QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation).toUtf8().data();
}

char *getDownloadLocation()
{
    return QStandardPaths::writableLocation(QStandardPaths::DownloadLocation).toUtf8().data();
}

char *getMusicLocation()
{
    return QStandardPaths::writableLocation(QStandardPaths::MusicLocation).toUtf8().data();
}

char *getPicturesLocation()
{
    return QStandardPaths::writableLocation(QStandardPaths::PicturesLocation).toUtf8().data();
}

char *getGenericDataLocation()
{
    return QStandardPaths::writableLocation(QStandardPaths::GenericDataLocation).toUtf8().data();
}

char *getMoviesLocation()
{
    return QStandardPaths::writableLocation(QStandardPaths::MoviesLocation).toUtf8().data();
}
