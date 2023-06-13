
# Project_Name

Project description




## Project structure


```bash
lib
├── app
│   ├── global # Variables globales de la aplicación
│   │   └── environment.dart # Variables de entorno (En caso de ser importantes usar --dart-define)
│   ├── helpers # Helpers de la aplicación
│   │   ├── app_life_cycle_helper.dart
│   │   ├── permissions_helper.dart
│   │   ├── helpers.dart
│   ├── constants # Constantes que se usan en la aplicación (Colores, textos, etc)
│   │   ├── constants.dart
│   ├── theme # Tema de la aplicación
│   │   ├── app_styles.dart
│   │   ├── my_theme.dart
│   │   └── theme.dart
│   └── utils # Utilidades de la aplicación
│       ├── regular_expressions_util.dart
│       └── utils.dart
|
├── providers # Providers globales que se usan en la aplicación por ejemplo, el de la sesión
│   ├── auth
│   │   └── auth_controller.dart
│   └── biometrics
│       └── biometrics_controlller.dart
|   
├── models # Modelos de la aplicación
│   ├── api_models
│   │   └── api_response_model.dart
│   └── auth
│       ├── auth_model.dart
│       └── register_model.dart
├── types # Tipos globales de la aplicación (enums)
│   ├── account_types.dart
│   └── user_types.dart
├── widgets # Custom Widgets globales de la aplicación (Cada tipo de widget tiene su propio folder)
│   ├── buttons 
│   │   ├── primary_button.dart
│   │   └── tertiary_button.dart
│   ├── inputs
│   │   ├── primary_input.dart
│   │   └── tertiary_input.dart
├── modules # Módulos (features) de la aplicación
│   ├── notifications # Módulo de notificaciones
│   │   └── widgets # Widgets del módulo de notificaciones
│   │       ├── notification_card.dart
│   │       └── widgets.dart
│   │   └── screens # Screens del módulo de notificaciones
│   │       ├── readed_notifications_screen.dart
│   │       ├── new_notifications_screen.dart
│   │       └── all_notifications_screen.dart
│   ├── profile # Módulo de perfil
│   │   ├── providers # Providers del módulo de perfil
│   │   │   └── profile_provider.dart
│   │   ├── types # Tipos del módulo de perfil
│   │   │   └── profile_type.dart
│   │   └── screens # Screens del módulo de perfil
│   │       └── profile_screen.dart
│   │       └── edit_profile_screen.dart
├── services # Servicios de la aplicación
│   ├── profile # Servicios del módulo de perfil
│   │   └── profile_service.dart
│   ├── user # Servicios del módulo de usuario
│   │   └── user_service.dart
|   ├── base_service.dart # Servicio base (incluye el manejo de errores)
|   └── project_api.dart # Servicio de la API

```
    