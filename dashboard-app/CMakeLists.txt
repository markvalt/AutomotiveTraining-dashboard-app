cmake_minimum_required(VERSION 3.16)

project(dashboard VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)

qt_add_executable(appdashboard
    main.cpp
    backend.h backend.cpp
)

qt_add_qml_module(appdashboard
    URI Backend
    VERSION 1.0
    QML_FILES       
        main.qml
        ControlPanel.qml
        Backend.qml
        DebugView.qml
        SpeedGauge.qml
        IndicatorPanel.qml
        IndicatorIcon.qml
        RpmGauge.qml
        ContactList.qml
    RESOURCES
        images/DashboardFrameSport-mask.png
        images/DashboardMask.png
        images/Gauge_Speed.png
        images/Gauge_RPM.png
        images/gaugeCenterBig.png
        images/Icon_Fuel_OFF.png
        images/Icon_Fuel_ON.png
        images/Icon_LowBeam_OFF.png
        images/Icon_LowBeam_ON.png
        images/Icon_PositionLights_OFF.png
        images/Icon_PositionLights_ON.png
        images/Icon_SeatBelt_OFF.png
        images/Icon_SeatBelt_ON.png
        images/Icon_TurnLeft_OFF.png
        images/Icon_TurnLeft_ON.png
        images/SpeedometerNeedle.png
)

set_target_properties(appdashboard PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_compile_definitions(appdashboard
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(appdashboard
    PRIVATE Qt6::Quick)
