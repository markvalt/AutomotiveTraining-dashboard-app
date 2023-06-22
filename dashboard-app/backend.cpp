#include "backend.h"
#include <QDebug>

Backend::Backend(QObject *parent)
    : QObject{parent}
{
    connect(this, &Backend::rpmChanged, this, &Backend::onRpmChanged);

    m_vehicleSimulation.setInterval(VEHICLE_SIM_INTERVAL);
    connect(&m_vehicleSimulation, &QTimer::timeout, this, &Backend::simulateVehicle);
    m_vehicleSimulation.start();
}

void Backend::powerOn()
{
    m_power = true;
    emit powerChanged();
}

void Backend::powerOff()
{
    m_power = false;
    emit powerChanged();

    m_engineRunning = false;
    emit engineRunningChanged();

    m_positionLights = false;
    emit positionLightsChanged();

    m_lowBeamLights = false;
    emit lowBeamLightsChanged();

    m_turnLeft = false;
    emit turnLeftChanged();

    m_turnRight = false;
    emit turnRightChanged();

    m_rpm = 0;
    emit rpmChanged();

    m_speed = 0;
    emit speedChanged();
}

void Backend::engineOn()
{
    if (m_power && m_fuelLevel > 0 && m_gear == GEARS::Neutral) {
        m_engineRunning = true;
        emit engineRunningChanged();

        m_rpm = RPM_IDLE;
        emit rpmChanged();
    }
}

void Backend::engineOff()
{
    if (m_engineRunning) {
        m_engineRunning = false;
        emit engineRunningChanged();

        m_rpm = 0;
        emit rpmChanged();

        m_speed = 0;
        emit speedChanged();
    }
}

void Backend::positionLightsOn()
{
    if (m_power) {
        m_positionLights = true;
        emit positionLightsChanged();
    }
}

void Backend::positionLightsOff()
{
    if (m_positionLights) {
        m_positionLights = false;
        emit positionLightsChanged();
    }
}

void Backend::lowBeamLightsOn()
{
    if (m_power) {
        m_lowBeamLights = true;
        emit lowBeamLightsChanged();
    }
}

void Backend::lowBeamLightsOff()
{
    if (m_lowBeamLights) {
        m_lowBeamLights = false;
        emit lowBeamLightsChanged();
    }
}

void Backend::turnLeftOn()
{
    if (m_power) {
        m_turnLeft = true;
        m_turnRight = false;
        emit turnLeftChanged();
        emit turnRightChanged();
    }
}

void Backend::turnLeftOff()
{
    if (m_turnLeft) {
        m_turnLeft = false;
        emit turnLeftChanged();
    }
}

void Backend::turnRightOn()
{
    if (m_power) {
        m_turnRight = true;
        m_turnLeft = false;
        emit turnRightChanged();
        emit turnLeftChanged();
    }
}

void Backend::turnRightOff()
{
    if (m_power) {
        m_turnRight = false;
        emit turnRightChanged();
    }
}

void Backend::seatBeltOn()
{
    m_seatBelt = true;
    emit seatBeltChanged();
}

void Backend::seatBeltOff()
{
    m_seatBelt = false;
    emit seatBeltChanged();
}

void Backend::gearUp()
{
    if (m_gear < GEARS::Last-1) {
        m_gear++;
        emit gearChanged();
    }
}

void Backend::gearDown()
{
    if (m_gear > 0) {
        m_gear--;
        emit gearChanged();
    }
}

void Backend::throttle()
{
    if (m_engineRunning) {
        m_rpm += RPM_CHANGE;
        if (m_rpm > RPM_MAX) {
            m_rpm = RPM_MAX;
        }
        emit rpmChanged();
    }
}

void Backend::brake()
{
    if (m_rpm > 0) {
        m_rpm -= RPM_CHANGE;
        if (m_rpm < 0) {
            m_rpm = 0;
        }
        emit rpmChanged();
    }
}

void Backend::addFuel()
{
    if (m_fuelLevel < FUEL_MAX) {
        m_fuelLevel += 5;
        if (m_fuelLevel > FUEL_MAX) {
            m_fuelLevel = FUEL_MAX;
        }
        emit fuelLevelChanged();
    }
}

void Backend::onRpmChanged()
{
    m_fuelConsumptionPerSecond = m_rpm * 0.00001;
}

void Backend::simulateVehicle()
{
    if (!m_engineRunning)
        return;

    m_fuelLevel -= m_fuelConsumptionPerSecond;

    if (m_fuelLevel <= 0) {
        m_fuelLevel = 0;

        m_engineRunning = false;
        emit engineRunningChanged();

        m_rpm = 0;
        emit rpmChanged();
    }
    emit fuelLevelChanged();

    switch (m_gear) {

    case GEARS::Neutral:
        m_speed = 0;
        break;

    case GEARS::Reverse:
        m_speed = 0.4 * SPEED_MAX * m_rpm / RPM_MAX;
        break;

    case GEARS::Drive1:
        m_speed = 0.6 * SPEED_MAX * m_rpm / RPM_MAX;
        break;

    case GEARS::Drive2:
        m_speed = 0.7 * SPEED_MAX * m_rpm / RPM_MAX;
        break;

    case GEARS::Drive3:
        m_speed = 0.8 * SPEED_MAX * m_rpm / RPM_MAX;
        break;

    case GEARS::Drive4:
        m_speed = 0.9 * SPEED_MAX * m_rpm / RPM_MAX;
        break;

    case GEARS::Drive5:
        m_speed = 1.0 * SPEED_MAX * m_rpm / RPM_MAX;
        break;
    }
    emit speedChanged();

    m_odometer += VEHICLE_ODOMETER_MULTIPLIER * m_speed / 3600;
    emit odometerChanged();
}
