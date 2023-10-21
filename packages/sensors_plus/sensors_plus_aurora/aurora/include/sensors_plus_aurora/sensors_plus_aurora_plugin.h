/**
 * SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
 * SPDX-License-Identifier: BSD-3-Clause
 */

#ifndef FLUTTER_PLUGIN_SENSORS_PLUS_AURORA_PLUGIN_H
#define FLUTTER_PLUGIN_SENSORS_PLUS_AURORA_PLUGIN_H

#include <flutter/plugin-interface.h>
#include <sensors_plus_aurora/globals.h>

#include <QtCore>

#include <accelerometersensor_i.h>
#include <alssensor_i.h>
#include <compasssensor_i.h>
#include <magnetometersensor_i.h>
#include <orientationsensor_i.h>
#include <proximitysensor_i.h>
#include <rotationsensor_i.h>
#include <sensormanagerinterface.h>
#include <tapsensor_i.h>

class PLUGIN_EXPORT SensorsPlusAuroraPlugin final : public QObject, public PluginInterface
{
    Q_OBJECT

public:
    void RegisterWithRegistrar(PluginRegistrar &registrar) override;

public slots:
    void EventSensorOrientation(const Unsigned &data);
    void EventSensorAccelerometer(const XYZ &data);
    void EventSensorCompass(const Compass &data);
    void EventSensorTap(const Tap &data);
    void EventSensorALS(const Unsigned &data);
    void EventSensorProximity(const Proximity &data);
    void EventSensorRotation(const XYZ &data);
    void EventSensorMagnetometer(const MagneticField &data);

private:
    template<typename T>
    bool RegisterSensorInterface(QString sensor);
    void EventChannelNull(const std::string &channel);
    void EventChannelData(const std::string &channel, const Encodable::List &result);

    void EnableSensorOrientation();
    void DisableSensorOrientation();

    void EnableSensorAccelerometer();
    void DisableSensorAccelerometer();

    void EnableSensorCompass();
    void DisableSensorCompass();

    void EnableSensorTap();
    void DisableSensorTap();

    void EnableSensorALS();
    void DisableSensorALS();

    void EnableSensorProximity();
    void DisableSensorProximity();

    void EnableSensorRotation();
    void DisableSensorRotation();

    void EnableSensorMagnetometer();
    void DisableSensorMagnetometer();

private:
    OrientationSensorChannelInterface *m_ifaceOrientation = nullptr;
    AccelerometerSensorChannelInterface *m_ifaceAccelerometer = nullptr;
    CompassSensorChannelInterface *m_ifaceCompass = nullptr;
    TapSensorChannelInterface *m_ifaceTap = nullptr;
    ALSSensorChannelInterface *m_ifaceALS = nullptr;
    ProximitySensorChannelInterface *m_ifaceProximity = nullptr;
    RotationSensorChannelInterface *m_ifaceRotation = nullptr;
    MagnetometerSensorChannelInterface *m_ifaceMagnetometer = nullptr;
};

#endif /* FLUTTER_PLUGIN_SENSORS_PLUS_AURORA_PLUGIN_H */
