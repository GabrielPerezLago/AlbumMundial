class SESSIONDATA {
  static final SESSIONDATA instance = SESSIONDATA._internal();
  SESSIONDATA._internal();


  int? id;
  String? nombre;
  String? email;

  SESSIONDATA({
    this.id,
    this.nombre,
    this.email
  });

  factory SESSIONDATA.fromJson(Map<String, dynamic> json) {
    return SESSIONDATA(
      id: json['id'],
      nombre: json['nombre1'],
      email: json['email']
    );
  }

  void saveData(Map<String, dynamic> data) {
    this.id = data['id'];
    this.nombre = data['nombre'];
    this.email = data['email'];
  }



}