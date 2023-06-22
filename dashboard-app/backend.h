#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QQmlEngine>
#include <QTimer>

static const int VEHICLE_SIM_INTERVAL = 100;
static const int VEHICLE_ODOMETER_MULTIPLIER = 10;

static const int RPM_IDLE = 700;
static const int RPM_MAX = 8000;
static const int RPM_CHANGE = 500;

static const int SPEED_MAX = 240;

static const int FUEL_INIT = 10;
static const int FUEL_MAX = 50;

class Backend : public QObject
{
    enum GEARS { Reverse, Neutral, Drive1, Drive2, Drive3, Drive4, Drive5, Last};

    Q_OBJECT

    Q_PROPERTY(bool power MEMBER m_power NOTIFY powerChanged)
    Q_PROPERTY(bool engineRunning MEMBER m_engineRunning NOTIFY engineRunningChanged)
    Q_PROPERTY(bool positionLights MEMBER m_positionLights NOTIFY positionLightsChanged)
    Q_PROPERTY(bool lowBeamLights MEMBER m_lowBeamLights NOTIFY lowBeamLightsChanged)
    Q_PROPERTY(bool turnLeft MEMBER m_turnLeft NOTIFY turnLeftChanged)
    Q_PROPERTY(bool turnRight MEMBER m_turnRight NOTIFY turnRightChanged)
    Q_PROPERTY(bool seatBelt MEMBER m_seatBelt NOTIFY seatBeltChanged)
    Q_PROPERTY(int gear MEMBER m_gear NOTIFY gearChanged)
    Q_PROPERTY(qreal speed MEMBER m_speed NOTIFY speedChanged)
    Q_PROPERTY(qreal rpm MEMBER m_rpm NOTIFY rpmChanged)
    Q_PROPERTY(qreal odometer MEMBER m_odometer NOTIFY odometerChanged)
    Q_PROPERTY(qreal fuelLevel MEMBER m_fuelLevel NOTIFY fuelLevelChanged)

    QML_NAMED_ELEMENT(CppBackend)
    QML_SINGLETON

public:
    explicit Backend(QObject *parent = nullptr);

    Q_INVOKABLE void powerOn();
    Q_INVOKABLE void powerOff();
    Q_INVOKABLE void engineOn();
    Q_INVOKABLE void engineOff();
    Q_INVOKABLE void positionLightsOn();
    Q_INVOKABLE void positionLightsOff();
    Q_INVOKABLE void lowBeamLightsOn();
    Q_INVOKABLE void lowBeamLightsOff();
    Q_INVOKABLE void turnLeftOn();
    Q_INVOKABLE void turnLeftOff();
    Q_INVOKABLE void turnRightOn();
    Q_INVOKABLE void turnRightOff();
    Q_INVOKABLE void seatBeltOn();
    Q_INVOKABLE void seatBeltOff();
    Q_INVOKABLE void gearUp();
    Q_INVOKABLE void gearDown();
    Q_INVOKABLE void throttle();
    Q_INVOKABLE void brake();
    Q_INVOKABLE void addFuel();

signals:
    void powerChanged();
    void engineRunningChanged();
    void positionLightsChanged();
    void lowBeamLightsChanged();
    void turnLeftChanged();
    void turnRightChanged();
    void seatBeltChanged();
    void gearChanged();
    void speedChanged();
    void rpmChanged();
    void odometerChanged();
    void fuelLevelChanged();

private slots:
    void onRpmChanged();
    void simulateVehicle();

private:
    bool m_power = false;
    bool m_engineRunning = false;
    bool m_positionLights = false;
    bool m_lowBeamLights = false;
    bool m_turnLeft = false;
    bool m_turnRight = false;
    bool m_seatBelt = false;
    int m_gear = GEARS::Neutral;
    qreal m_speed = 0;
    qreal m_rpm = 0;
    qreal m_odometer = 0;
    qreal m_fuelLevel = FUEL_INIT;

    qreal m_fuelConsumptionPerSecond = 0;
    QTimer m_vehicleSimulation;
};

#endif // BACKEND_H
