# Flutter Packages Aurora OS

This repo is a companion repo to the main flutter repo. 
It contains the source code for Aurora Flutter's packages (i.e., packages developed and check by the Aurora team).

## Package done

Packages made or for review

| Package                                                                             | Version  | OS Version | State   | Comment                                                             |
|-------------------------------------------------------------------------------------|----------|------------|---------|---------------------------------------------------------------------|
| [battery_plus](https://pub.dev/packages/battery_plus)                               | 4.0.1    | 4.0.2      | Review  | -                                                                   |
| [device_info_plus](https://pub.dev/packages/device_info_plus)                       | 9.0.2    | 4.0.2      | Review  | -                                                                   |
| [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications) | 14.1.1   | 4.0.2      | Done    | -                                                                   |
| [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage)           | 8.0.0    | 4.0.2      | Review  | Ключь нужно генерировать сейчас самому, например через пин от юзера |
| [package_info_plus](https://pub.dev/packages/package_info_plus)                     | 4.0.2    | 4.0.2      | Done    | Достать `version` & `build_number` не удалось                       |
| [path_provider](https://pub.dev/packages/path_provider)                             | 2.0.15   | 4.0.2      | Review  | -                                                                   |
| [shared_preferences](https://pub.dev/packages/shared_preferences)                   | 2.1.2    | 4.0.2      | Review  | -                                                                   |
| [sqflite](https://pub.dev/packages/sqflite)                                         | 2.2.6    | 4.0.2      | Review  | -                                                                   |
| [wakelock](https://pub.dev/packages/wakelock)                                       | 0.6.2    | 4.0.2      | Review  | -                                                                   |
| xdga_directories                                                                    | -        | 4.0.2      | Review  | Аналог [xdg_directories](https://pub.dev/packages/xdg_directories)  |

## Package verified

Verified packages on Aurora OS

| Package                                                                 | Version  | OS Version  | State  | Comment                            |
|-------------------------------------------------------------------------|----------|-------------|--------|------------------------------------|
| [flutter_cache_manager](https://pub.dev/packages/flutter_cache_manager) | 3.3.0    | 4.0.2       | Done   | Depends on `path_provider`         |
| [cached_network_image](https://pub.dev/packages/cached_network_image)   | 3.2.3    | 4.0.2       | Done   | Depends on `flutter_cache_manager` |

## Package in progress

Started development and its status

| Package                                                                  | Version  | OS Version | State    | Comment                                                                           |
|--------------------------------------------------------------------------|----------|------------|----------|-----------------------------------------------------------------------------------|
| [flutter_reactive_ble](https://pub.dev/packages/flutter_reactive_ble)    | 5.0.3    | 4.0.2      | Blocked  | Не все методы bluez dbus доступны для приложения, вопрос изучается                |
| [url_launcher](https://pub.dev/packages/url_launcher)                    | 6.1.11   | 5.0.0      | Waiting  | [OpenURI](https://confluence.omprussia.ru/pages/viewpage.action?pageId=163055648) |
| [sensors_plus](https://pub.dev/packages/sensors_plus)                    | 3.0.2    | 4.0.2      | Blocked  | Нет интерфейса для использования Sensors API без Qt                               |


## Package waiting

Packets waiting in line

| Package                                                               | State   | Comment |
|-----------------------------------------------------------------------|---------|---------|
| [camera](https://pub.dev/packages/camera)                             | Waiting | -       |
| [video_player](https://pub.dev/packages/video_player)                 | Waiting | -       |
| [image_picker](https://pub.dev/packages/image_picker)                 | Waiting | -       |
| [geolocator](https://pub.dev/packages/geolocator)                     | Waiting | -       |
| [permission_handler](https://pub.dev/packages/permission_handler)     | Waiting | -       |
| [file_picker](https://pub.dev/packages/file_picker)                   | Waiting | -       |
| [webview_flutter](https://pub.dev/packages/webview_flutter)           | Waiting | -       |
| [local_auth](https://pub.dev/packages/local_auth)                     | Waiting | -       |
| [flutter_inappwebview](https://pub.dev/packages/flutter_inappwebview) | Waiting | -       |
| [qr_code_scanner](https://pub.dev/packages/qr_code_scanner)           | Waiting | -       |
| [connectivity_plus](https://pub.dev/packages/connectivity_plus)       | Waiting | -       |
| [share_plus](https://pub.dev/packages/share_plus)                     | Waiting | -       |
| [app_settings](https://pub.dev/packages/app_settings)                 | Waiting | -       |
| [maps_launcher](https://pub.dev/packages/maps_launcher)               | Waiting | -       |
| [nfc_manager](https://pub.dev/packages/nfc_manager)                   | Waiting | -       |
| [push](https://pub.dev/packages/push)                                 | Waiting | -       |
| [audioplayers](https://pub.dev/packages/audioplayers)                 | Waiting | -       |
| [network_info_plus](https://pub.dev/packages/network_info_plus)       | Waiting | -       |
