class Usuario {
  int? id;
  String nombre;
  String apellidos;
  String correo;
  String contrasena; // Cambiado de 'password' a 'contrasena'

  Usuario({
    this.id,
    required this.nombre,
    required this.apellidos,
    required this.correo,
    required this.contrasena, // Cambiado aquí también
  });

  // Método para validar que la contraseña tenga al menos 8 caracteres
  bool validarContrasena() { // Cambiado de 'validarPassword' a 'validarContrasena'
    return contrasena.length >= 8;
  }

  // Convertir un objeto Usuario a un Map (útil para SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'apellidos': apellidos,
      'correo': correo,
      'contrasena': contrasena, // Cambiado aquí también
    };
  }

  // Crear un objeto Usuario a partir de un Map
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'],
      nombre: map['nombre'],
      apellidos: map['apellidos'],
      correo: map['correo'],
      contrasena: map['contrasena'], // Cambiado aquí también
    );
  }
}