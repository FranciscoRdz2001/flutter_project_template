class ExampleModel {
  final int id;

  const ExampleModel({
    required this.id,
  });

  factory ExampleModel.fromJson(Map<String, dynamic> json) {
    return ExampleModel(
      id: json['id'],
    );
  }
}
