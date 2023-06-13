import 'package:flutter_new_project_template/domain/models/example/example_model.dart';
import 'package:flutter_new_project_template/domain/services/base_service.dart';

class ExampleService extends BaseService {
  const ExampleService();

  Future<ExampleModel?> getExample() async {
    // Despues de usar el GetMethod, PostMethod o cualquier otro, se debe especificar el tipo de datos de la respuesta
    // en este caso, es ExampleModel

    // El mapFunction es una funcion que se le pasa al metodo, para que sepa como transformar la respuesta de la api
    final response = await getMethod<ExampleModel>(
      'test-endpoint',
      mapFunction: (data) {
        return ExampleModel.fromJson(data);
      },
    );
    return response.data;
  }
}
