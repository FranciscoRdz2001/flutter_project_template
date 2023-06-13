import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../../app/global/environment.dart';
import '../models/api/api_response_model.dart';

// Esta clase con la logica que tiene, se puede usar para cualquier proyecto y se encarga de capturar errores de la api
class ApiProject {
  // Se utiliza por si lo quieres sacar de cuando una petición arroje un 401
  // Ejemplo de uso:
  // ApiNomina.instance.onTokenExpired = () => print('Token expired');
  static VoidCallback? onTokenExpired;

  final Dio _dio;

  const ApiProject(this._dio);

  static final _instance = ApiProject(Dio());
  static ApiProject get instance => _instance;

  Dio get dio => _dio;

  Future<ApiResponseModel<T>> call<T>({
    required Future<Response> Function() callFunction,
    required T Function(Map<String, dynamic> data) mapCallback,
    bool ignoreExpiredToken = false,
    bool ignoreMessages = false,
  }) async {
    try {
      final resp = await callFunction();
      // print.printInfo(
      //     info: 'Debug response from ${resp.realUri} : ${resp.data}');
      final code = resp.statusCode;
      if (onTokenExpired != null && code == 401 && !ignoreExpiredToken) {
        onTokenExpired!();
      }
      if (successCodes.contains(code)) {
        final json = jsonEncode(resp.data);
        final map = jsonDecode(json);
        final newMap = map is List ? {'data': map} : map;
        final T? data = mapCallback(newMap);
        /*
          Ingresar la lógica de snackbar aquí, si se desea mostrar un snackbar
          con el mensaje de la respuesta del servidor.

          Ejemplo:
            if (newMap['message'] != null && !ignoreMessages) {
              GetSnackbar.showSimpleSnackbarInfo(newMap['message'].toString());
            }
          ! Evitar usar GetX solo para mostrar los mensajes de error, ya que no debe existir el contexto en esta clase
         */
        return ApiResponseModel(
          code: code!,
          success: successCodes.contains(code),
          message: resp.statusMessage,
          data: data,
        );
      }
      final isMap = resp.data is Map;
      throw DioError(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          statusMessage: isMap ? resp.data['message'].toString() : '',
          statusCode: resp.statusCode,
          data: resp.data != null && isMap ? jsonEncode(resp.data) : null,
          requestOptions: RequestOptions(path: ''),
        ),
      );
    } on DioError catch (e) {
      // print.printError(info: 'Error $e');
      final message = e.response == null
          ? 'No hay conexión a internet o el servidor no responde.'
          : 'Error: ${e.response!.statusCode}, ${e.response?.statusMessage}';

      /*
          Ingresar la lógica de snackbar aquí, si se desea mostrar un snackbar
          con el mensaje de la respuesta del servidor.

          Ejemplo:
            if (!ignoreMessages) {
              GetSnackbar.showSimpleSnackbarInfo(message);
            }
          ! Evitar usar GetX solo para mostrar los mensajes de error, ya que no debe existir el contexto en esta clase
         */

      return ApiResponseModel(
        message: e.response?.statusMessage,
        success: false,
        code: e.response?.statusCode,
        data: null,
      );
    }
  }

  void initializeDio() {
    _dio.options.baseUrl = Environment.dev;
    _dio.options.connectTimeout = const Duration(seconds: 25);
    _dio.options.validateStatus = (status) {
      return true;
    };
    setDioAuthorization();
  }

  void setDioAuthorization({String? token}) {
    /*
        Ingresar la lógica de la autorización aquí, si se desea enviar el token
        de autorización en cada petición.

        Ejemplo:
        final tempToken = token ?? AppPreferences.token;
        _dio.options.headers = {
          'content-Type': 'application/json',
          'Authorization': 'Bearer $tempToken',
        };

        Este fragmento de código normalmente lo utilizo al iniciar sesión, para que el token se asigne
        al header de las peticiones.
     */
  }

  // Para descargar archivos de internet y guardarlos en la memoria cache del dispositivo
  Future<File?> downloadFile(
      {required String url, required String pathName}) async {
    try {
      final dir = await getTemporaryDirectory();
      final resp = await dio.get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      final bytes = resp.data;
      final file = await File('${dir.path}/$pathName').create(recursive: true);
      final data = await file.writeAsBytes(bytes);
      return data;
    } on Exception {
      return null;
    }
  }
}

// Códigos de respuesta exitosa del servidor
List<int> successCodes = [200, 201];
