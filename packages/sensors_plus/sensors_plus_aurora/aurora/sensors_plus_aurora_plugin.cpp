/**
 * SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
 * SPDX-License-Identifier: BSD-3-Clause
 */

#include <flutter/method-channel.h>
#include <sensors_plus_aurora/sensors_plus_aurora_plugin.h>
#include <QDebug>

#include <accelerometersensor_i.h>
#include <alssensor_i.h>
#include <compasssensor_i.h>
#include <magnetometersensor_i.h>
#include <orientationsensor_i.h>
#include <proximitysensor_i.h>
#include <rotationsensor_i.h>
#include <sensormanagerinterface.h>
#include <tapsensor_i.h>

namespace KeyChannel {
constexpr auto Orientation = "sensors_plus_aurora_orientationsensor";
constexpr auto Accelerometer = "sensors_plus_aurora_accelerometersensor";
constexpr auto Compass = "sensors_plus_aurora_compasssensor";
constexpr auto Tap = "sensors_plus_aurora_tapsensor";
constexpr auto ALS = "sensors_plus_aurora_alssensor";
constexpr auto Proximity = "sensors_plus_aurora_proximitysensor";
constexpr auto Rotation = "sensors_plus_aurora_rotationsensor";
constexpr auto Magnetometer = "sensors_plus_aurora_magnetometersensor";
} // namespace KeyChannel

namespace KeySensor {
constexpr auto Orientation = "orientationsensor";
constexpr auto Accelerometer = "accelerometersensor";
constexpr auto Compass = "compasssensor";
constexpr auto Tap = "tapsensor";
constexpr auto ALS = "alssensor";
constexpr auto Proximity = "proximitysensor";
constexpr auto Rotation = "rotationsensor";
constexpr auto Magnetometer = "magnetometersensor";
} // namespace KeySensor

void SensorsPlusAuroraPlugin::RegisterWithRegistrar(PluginRegistrar &registrar)
{
    registrar.RegisterEventChannel(
        KeyChannel::Orientation,
        MethodCodecType::Standard,
        [this](const Encodable &) {
            EnableSensorOrientation();
            return EventResponse();
        },
        [this](const Encodable &) {
            DisableSensorOrientation();
            return EventResponse();
        });

    registrar.RegisterEventChannel(
        KeyChannel::Accelerometer,
        MethodCodecType::Standard,
        [this](const Encodable &) {
            EnableSensorAccelerometer();
            return EventResponse();
        },
        [this](const Encodable &) {
            DisableSensorAccelerometer();
            return EventResponse();
        });

    registrar.RegisterEventChannel(
        KeyChannel::Compass,
        MethodCodecType::Standard,
        [this](const Encodable &) {
            EnableSensorCompass();
            return EventResponse();
        },
        [this](const Encodable &) {
            DisableSensorCompass();
            return EventResponse();
        });

    registrar.RegisterEventChannel(
        KeyChannel::Tap,
        MethodCodecType::Standard,
        [this](const Encodable &) {
            EnableSensorTap();
            return EventResponse();
        },
        [this](const Encodable &) {
            DisableSensorTap();
            return EventResponse();
        });

    registrar.RegisterEventChannel(
        KeyChannel::ALS,
        MethodCodecType::Standard,
        [this](const Encodable &) {
            EnableSensorALS();
            return EventResponse();
        },
        [this](const Encodable &) {
            DisableSensorALS();
            return EventResponse();
        });

    registrar.RegisterEventChannel(
        KeyChannel::Proximity,
        MethodCodecType::Standard,
        [this](const Encodable &) {
            EnableSensorProximity();
            return EventResponse();
        },
        [this](const Encodable &) {
            DisableSensorProximity();
            return EventResponse();
        });

    registrar.RegisterEventChannel(
        KeyChannel::Rotation,
        MethodCodecType::Standard,
        [this](const Encodable &) {
            EnableSensorRotation();
            return EventResponse();
        },
        [this](const Encodable &) {
            DisableSensorRotation();
            return EventResponse();
        });

    registrar.RegisterEventChannel(
        KeyChannel::Magnetometer,
        MethodCodecType::Standard,
        [this](const Encodable &) {
            EnableSensorMagnetometer();
            return EventResponse();
        },
        [this](const Encodable &) {
            DisableSensorMagnetometer();
            return EventResponse();
        });
}

template<typename T>
bool SensorsPlusAuroraPlugin::RegisterSensorInterface(QString sensor)
{
    SensorManagerInterface &sm = SensorManagerInterface::instance();
    if (!sm.isValid()) {
        return false;
    }

    QDBusReply<bool> reply(sm.loadPlugin(sensor));
    if (!reply.isValid() || !reply.value()) {
        return false;
    }

    sm.registerSensorInterface<T>(sensor);

    return true;
}

void SensorsPlusAuroraPlugin::EventChannelNull(const std::string &channel)
{
    EventChannel(channel, MethodCodecType::Standard).SendEvent(nullptr);
}

void SensorsPlusAuroraPlugin::EventChannelData(const std::string &channel, const Encodable::List &result)
{
    EventChannel(channel, MethodCodecType::Standard).SendEvent(result);
}

/**
 * Orientation
 */
void SensorsPlusAuroraPlugin::EnableSensorOrientation()
{
    if (m_ifaceOrientation == nullptr) {
        if (!RegisterSensorInterface<OrientationSensorChannelInterface>(KeySensor::Orientation)) {
            EventChannelNull(KeyChannel::Orientation);
            return;
        }

        m_ifaceOrientation = OrientationSensorChannelInterface::interface(KeySensor::Orientation);

        if (!m_ifaceOrientation) {
            EventChannelNull(KeyChannel::Orientation);
            return;
        }

        connect(m_ifaceOrientation,
                SIGNAL(orientationChanged(const Unsigned &)),
                this,
                SLOT(EventSensorOrientation(const Unsigned &)));
    }

    m_ifaceOrientation->start();
    EventSensorOrientation(m_ifaceOrientation->orientation());
}

void SensorsPlusAuroraPlugin::DisableSensorOrientation()
{
    if (m_ifaceOrientation) {
        m_ifaceOrientation->stop();
    }
}

void SensorsPlusAuroraPlugin::EventSensorOrientation(const Unsigned &data)
{
    EventChannelData(KeyChannel::Orientation, Encodable::List {data.x()});
}

/**
 * Accelerometer
 */
void SensorsPlusAuroraPlugin::EnableSensorAccelerometer()
{
    if (m_ifaceAccelerometer == nullptr) {
        if (!RegisterSensorInterface<AccelerometerSensorChannelInterface>(
                KeySensor::Accelerometer)) {
            EventChannelNull(KeyChannel::Accelerometer);
            return;
        }

        m_ifaceAccelerometer = AccelerometerSensorChannelInterface::interface(
            KeySensor::Accelerometer);

        if (!m_ifaceAccelerometer) {
            EventChannelNull(KeyChannel::Accelerometer);
            return;
        }

        connect(m_ifaceAccelerometer,
                SIGNAL(dataAvailable(const XYZ &)),
                this,
                SLOT(EventSensorAccelerometer(const XYZ &)));
    }

    m_ifaceAccelerometer->start();
    EventSensorAccelerometer(m_ifaceAccelerometer->get());
}

void SensorsPlusAuroraPlugin::DisableSensorAccelerometer()
{
    if (m_ifaceAccelerometer) {
        m_ifaceAccelerometer->stop();
    }
}

void SensorsPlusAuroraPlugin::EventSensorAccelerometer(const XYZ &data)
{
    EventChannelData(KeyChannel::Accelerometer, Encodable::List {data.x(), data.y(), data.z()});
}

/**
 * Compass
 */
void SensorsPlusAuroraPlugin::EnableSensorCompass()
{
    if (m_ifaceCompass == nullptr) {
        if (!RegisterSensorInterface<CompassSensorChannelInterface>(KeySensor::Compass)) {
            EventChannelNull(KeyChannel::Compass);
            return;
        }

        m_ifaceCompass = CompassSensorChannelInterface::interface(KeySensor::Compass);

        if (!m_ifaceCompass) {
            EventChannelNull(KeyChannel::Compass);
            return;
        }

        connect(m_ifaceCompass,
                SIGNAL(dataAvailable(const Compass &)),
                this,
                SLOT(EventSensorCompass(const Compass &)));
    }

    m_ifaceCompass->start();
    EventSensorCompass(m_ifaceCompass->get());
}

void SensorsPlusAuroraPlugin::DisableSensorCompass()
{
    if (m_ifaceCompass) {
        m_ifaceCompass->stop();
    }
}

void SensorsPlusAuroraPlugin::EventSensorCompass(const Compass &data)
{
    EventChannelData(KeyChannel::Compass, Encodable::List {data.degrees(), data.level()});
}

/**
 * Tap
 */
void SensorsPlusAuroraPlugin::EnableSensorTap()
{
    if (m_ifaceTap == nullptr) {
        if (!RegisterSensorInterface<TapSensorChannelInterface>(KeySensor::Tap)) {
            EventChannelNull(KeyChannel::Tap);
            return;
        }

        m_ifaceTap = TapSensorChannelInterface::interface(KeySensor::Tap);

        if (!m_ifaceTap) {
            EventChannelNull(KeyChannel::Tap);
            return;
        }

        connect(m_ifaceTap,
                SIGNAL(dataAvailable(const Tap &)),
                this,
                SLOT(EventSensorTap(const Tap &)));
    }

    m_ifaceTap->start();
}

void SensorsPlusAuroraPlugin::DisableSensorTap()
{
    if (m_ifaceTap) {
        m_ifaceTap->stop();
    }
}

void SensorsPlusAuroraPlugin::EventSensorTap(const Tap &data)
{
    EventChannelData(KeyChannel::Tap, Encodable::List {
        static_cast<int>(data.direction()),
        static_cast<int>(data.type())
    });
}

/**
 * ALS
 */
void SensorsPlusAuroraPlugin::EnableSensorALS()
{
    if (m_ifaceALS == nullptr) {
        if (!RegisterSensorInterface<ALSSensorChannelInterface>(KeySensor::ALS)) {
            EventChannelNull(KeyChannel::ALS);
            return;
        }

        m_ifaceALS = ALSSensorChannelInterface::interface(KeySensor::ALS);

        if (!m_ifaceALS) {
            EventChannelNull(KeyChannel::ALS);
            return;
        }

        connect(m_ifaceALS,
                SIGNAL(ALSChanged(const Unsigned &)),
                this,
                SLOT(EventSensorALS(const Unsigned &)));
    }

    m_ifaceALS->start();
    EventSensorALS(m_ifaceALS->lux());
}

void SensorsPlusAuroraPlugin::DisableSensorALS()
{
    if (m_ifaceALS) {
        m_ifaceALS->stop();
    }
}

void SensorsPlusAuroraPlugin::EventSensorALS(const Unsigned &data)
{
    EventChannelData(KeyChannel::ALS, Encodable::List {data.x()});
}

/**
 * Proximity
 */
void SensorsPlusAuroraPlugin::EnableSensorProximity()
{
    if (m_ifaceProximity == nullptr) {
        if (!RegisterSensorInterface<ProximitySensorChannelInterface>(KeySensor::Proximity)) {
            EventChannelNull(KeyChannel::Proximity);
            return;
        }

        m_ifaceProximity = ProximitySensorChannelInterface::interface(KeySensor::Proximity);

        if (!m_ifaceProximity) {
            EventChannelNull(KeyChannel::Proximity);
            return;
        }

        connect(m_ifaceProximity,
                SIGNAL(reflectanceDataAvailable(const Proximity &)),
                this,
                SLOT(EventSensorProximity(const Proximity &)));
    }

    m_ifaceProximity->start();
    EventSensorProximity(m_ifaceProximity->proximityReflectance());
}

void SensorsPlusAuroraPlugin::DisableSensorProximity()
{
    if (m_ifaceProximity) {
        m_ifaceProximity->stop();
    }
}

void SensorsPlusAuroraPlugin::EventSensorProximity(const Proximity &data)
{
    EventChannelData(KeyChannel::Proximity, Encodable::List {data.withinProximity() ? 1 : 0});
}

/**
 * Rotation
 */
void SensorsPlusAuroraPlugin::EnableSensorRotation()
{
    if (m_ifaceRotation == nullptr) {
        if (!RegisterSensorInterface<RotationSensorChannelInterface>(KeySensor::Rotation)) {
            EventChannelNull(KeyChannel::Rotation);
            return;
        }

        m_ifaceRotation = RotationSensorChannelInterface::interface(KeySensor::Rotation);

        if (!m_ifaceRotation) {
            EventChannelNull(KeyChannel::Rotation);
            return;
        }

        connect(m_ifaceRotation,
                SIGNAL(dataAvailable(const XYZ &)),
                this,
                SLOT(EventSensorRotation(const XYZ &)));
    }

    m_ifaceRotation->start();
    EventSensorRotation(m_ifaceRotation->rotation());
}

void SensorsPlusAuroraPlugin::DisableSensorRotation()
{
    if (m_ifaceRotation) {
        m_ifaceRotation->stop();
    }
}

void SensorsPlusAuroraPlugin::EventSensorRotation(const XYZ &data)
{
    EventChannelData(KeyChannel::Rotation, Encodable::List {data.x(), data.y(), data.z()});
}

/**
 * Magnetometer
 */
void SensorsPlusAuroraPlugin::EnableSensorMagnetometer()
{
    if (m_ifaceMagnetometer == nullptr) {
        if (!RegisterSensorInterface<MagnetometerSensorChannelInterface>(KeySensor::Magnetometer)) {
            EventChannelNull(KeyChannel::Magnetometer);
            return;
        }

        m_ifaceMagnetometer = MagnetometerSensorChannelInterface::interface(KeySensor::Magnetometer);

        if (!m_ifaceMagnetometer) {
            EventChannelNull(KeyChannel::Magnetometer);
            return;
        }

        connect(m_ifaceMagnetometer,
                SIGNAL(dataAvailable(const MagneticField &)),
                this,
                SLOT(EventSensorMagnetometer(const MagneticField &)));
    }

    m_ifaceMagnetometer->start();
    EventSensorMagnetometer(m_ifaceMagnetometer->magneticField());
}

void SensorsPlusAuroraPlugin::DisableSensorMagnetometer()
{
    if (m_ifaceMagnetometer) {
        m_ifaceMagnetometer->stop();
    }
}

void SensorsPlusAuroraPlugin::EventSensorMagnetometer(const MagneticField &data)
{
    EventChannelData(KeyChannel::Magnetometer, Encodable::List {data.x(), data.y(), data.z()});
}

#include "moc_sensors_plus_aurora_plugin.cpp"
