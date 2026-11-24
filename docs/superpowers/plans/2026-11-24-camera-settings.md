# Camera Settings Implementation Plan

**Goal:** Add Camera after Video and before Help in application settings, following the supplied reference.

**Design:** Display manufacturer, model, firmware version, component ID and connection status from the current MAVLink camera. Show unavailable values when no real camera is connected. Include firmware file selection and a disabled Update Firmware button with an explanation; actual firmware updates are deferred by the user.

**Architecture:** Use the existing settings page generator with two hand-written QML sections, retaining settings search and section navigation. Expose the existing camera component ID accessor to QML. Use QGC controls, palette, font-relative dimensions and translatable text.

**Tech Stack:** Qt Quick, QML, existing C++ camera interface, JSON settings definitions.

## Tasks

- [x] Add camera information and firmware placeholder sections, register the generated page and CMake resources.
- [x] Verify generator output, navigation ordering and QML compilation; review disconnected and simulated camera behavior.
- [x] Run the canonical build/lint and available Unit tests; report environmental limitations.

## Review Focus

- Null active vehicle and camera must leave safe placeholders.
- Basic simulated camera must not report a physical connection.
- Vehicle communication loss must clear connected status.
- Long names and file paths must wrap or elide within the page.
- Selecting a file must never enable or trigger firmware updates.

This is a reversible UI addition; use existing generator checks and QML build validation rather than implementation-mirroring tests.

## Verification

- Desktop Qt 6.11.1 Debug build passed using the existing `build/Desktop_Qt_6_11_1_Debug` tree.
- Settings generator tests: 99 passed. Navigation order verified as Video, Camera, Help.
- Both hand-written QML components passed qmllint with the Qt and build-tree import directories.
- Independent review found a camera-list refresh issue; binding to the camera model count resolved it and the reviewer confirmed the fix.
- `just build` uses the unconfigured parent `build` directory; `just lint` cannot run because `pre-commit` is missing.
- Camera integration tests (`QGCCameraManagerTest`, `VehicleCameraControlTest`) fail on strict-log metadata schema warnings concerning `fileCrc`.
- Final Unit run: 188 of 190 passed. `TestBaseClassesTest` failed on the metadata schema warning; `BluetoothWorkerTest` failed on a Qt Bluetooth invalid-address warning. The earlier NTRIP timeout did not recur.
