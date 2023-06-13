import 'package:dio/dio.dart';
import 'package:flutter_new_project_template/domain/services/api_project.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../models/api/api_response_model.dart';

/* 
  Esta clase es la base de todos los servicios, se encarga de tener la instancia de la api y el dio
  para poder hacer las peticiones a la api.
  Para usarla, se debe crear otro servicio y extender de este, esta clase tiene la capacidad de devolver un String
  con los filtros que se le pasen, para que se puedan usar en las peticiones a la api.
  Igual, tiene la capacidad de transformar un archivo a un MultipartFile, para que se pueda enviar en las peticiones
*/
abstract class BaseService {
  static final _api = ApiProject.instance;

  ApiProject get api => _api;
  Dio get dio => _api.dio;

  const BaseService();

  String getFilterString(List<String>? filtersList) {
    if (filtersList == null) return '';
    return filtersList.toString().replaceAll(RegExp(r'[\[\] ]+'), '');
  }

  Future<MultipartFile> transformData(String path) async {
    final type = lookupMimeType(path);
    return await MultipartFile.fromFile(
      path,
      filename: type?.replaceAll('/', '.'),
      contentType: type != null ? MediaType.parse(type) : null,
    );
  }

  Future<ApiResponseModel<T>> getMethod<T>(
    String endpoint, {
    required T Function(Map<String, dynamic>) mapFunction,
    Map<String, dynamic>? customHeaders,
  }) async {
    final res = await _api.call<T>(
      callFunction: () async => await _api.dio.get(
        endpoint,
        options: customHeaders == null ? null : Options(headers: customHeaders),
      ),
      mapCallback: mapFunction,
    );
    return res;
  }

  Future<ApiResponseModel<T>> postMethod<T>(
    String endpoint, {
    required T Function(Map<String, dynamic>) mapFunction,
    Map<String, dynamic>? body,
  }) async {
    final res = await _api.call<T>(
      callFunction: () async => await _api.dio.post(endpoint, data: body),
      mapCallback: mapFunction,
    );
    return res;
  }

  Future<ApiResponseModel<T>> putMethod<T>(
    String endpoint, {
    required T Function(Map<String, dynamic>) mapFunction,
    Map<String, dynamic>? body,
  }) async {
    final res = await _api.call<T>(
      callFunction: () async => await _api.dio.put(endpoint, data: body),
      mapCallback: mapFunction,
    );
    return res;
  }
}
