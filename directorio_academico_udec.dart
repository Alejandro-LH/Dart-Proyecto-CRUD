import 'dart:io';

const String separador = '-';
const int longitudSeparador = 90;

void main() {
  Directorio directorio = Directorio();

  while (true) {
    print('');
    print('Bienvenido al sistema de directorio academico de la Universidad de Colima');
    print('');
    print('1. Crear nuevo registro');
    print('2. Leer y presentar los registros');
    print('3. Actualizar los datos');
    print('4. Eliminar registros');
    print('5. Salir del programa');

    stdout.write('\nIngrese una opcion: ');
    String? opcion = stdin.readLineSync();

    switch (opcion) {
      case '1':
        directorio.crearRegistro();
        break;
      case '2':
        directorio.leerRegistros();
        break;
      case '3':
        directorio.actualizarRegistro();
        break;
      case '4':
        directorio.eliminarRegistro();
        break;
      case '5':
        print('\nPrograma finalizado.');
        return;
      default:
        print('\nOpcion invalida. Intentelo nuevamente.');
    }
  }
}

class Registro {
  int id;
  String nombre;
  String aPaterno;
  String aMaterno;
  String correo;

  Registro(this.id, this.nombre, this.aPaterno, this.aMaterno, this.correo);

  @override
  String toString() {
    return 'ID: $id\n'
        'Nombre: $nombre\n'
        'Apellido Paterno: $aPaterno\n'
        'Apellido Materno: $aMaterno\n'
        'Correo: $correo';
  }
}

class Maestro extends Registro {
  Maestro(int id, String nombre, String aPaterno, String aMaterno, String correo)
      : super(id, nombre, aPaterno, aMaterno, correo);

  @override
  String toString() {
    return '${super.toString()}\nTipo: Maestro';
  }
}

class Alumno extends Registro {
  Alumno(int id, String nombre, String aPaterno, String aMaterno, String correo)
      : super(id, nombre, aPaterno, aMaterno, correo);

  @override
  String toString() {
    return '${super.toString()}\nTipo: Alumno';
  }
}

class Directorio {
  final List<Registro> registros = [];
  int contadorMaestros = 0;
  int contadorAlumnos = 0;

  void crearRegistro() {
    _imprimirSeparador();
    print('\nMenu de creacion\n');

    stdout.write('Ingrese el nombre: ');
    String nombre = _leerTextoObligatorio();

    stdout.write('Ingrese el apellido paterno: ');
    String apellidoPaterno = _leerTextoObligatorio();

    stdout.write('Ingrese el apellido materno: ');
    String apellidoMaterno = _leerTextoObligatorio();

    stdout.write('Ingrese el correo: ');
    String correo = _leerTextoObligatorio();

    String tipo = seleccionarTipo();
    late Registro registro;

    if (tipo == 'Maestro') {
      contadorMaestros++;
      registro = Maestro(
        contadorMaestros,
        nombre,
        apellidoPaterno,
        apellidoMaterno,
        correo,
      );
    } else {
      contadorAlumnos++;
      registro = Alumno(
        contadorAlumnos,
        nombre,
        apellidoPaterno,
        apellidoMaterno,
        correo,
      );
    }

    registros.add(registro);

    print('\nRegistro creado exitosamente.\n');
    _imprimirSeparador();
    print(registro);
  }

  String seleccionarTipo() {
    _imprimirSeparador();

    while (true) {
      print('\nSeleccione el tipo de usuario:\n');
      print('1. Maestro');
      print('2. Alumno\n');
      stdout.write('Ingrese una opcion: ');

      String? opcion = stdin.readLineSync();

      if (opcion == '1') return 'Maestro';
      if (opcion == '2') return 'Alumno';

      print('Opcion invalida. Intentelo nuevamente.');
    }
  }

  void leerRegistros() {
    if (registros.isEmpty) {
      print('\nEl directorio esta vacio.');
      return;
    }

    _imprimirSeparador();
    print('\nMenu de lectura\n');
    print('1. Leer todos los registros');
    print('2. Leer registros de maestros');
    print('3. Leer registros de alumnos\n');
    stdout.write('Ingrese una opcion: ');

    String? opcion = stdin.readLineSync();

    switch (opcion) {
      case '1':
        _imprimirSeparador();
        print('\nTodos los registros\n');
        mostrarRegistros(registros);
        break;
      case '2':
        _imprimirSeparador();
        print('\nRegistros de maestros\n');
        mostrarRegistros(registros.whereType<Maestro>().toList());
        break;
      case '3':
        _imprimirSeparador();
        print('\nRegistros de alumnos\n');
        mostrarRegistros(registros.whereType<Alumno>().toList());
        break;
      default:
        print('Opcion invalida. Intentelo nuevamente.\n');
    }
  }

  void mostrarRegistros(List<Registro> lista) {
    _imprimirSeparador();

    if (lista.isEmpty) {
      print('No se encontraron registros.\n');
      return;
    }

    for (Registro registro in lista) {
      print(registro);
      _imprimirSeparador();
    }
  }

  void actualizarRegistro() {
    _imprimirSeparador();

    if (registros.isEmpty) {
      print('\nEl directorio esta vacio.');
      return;
    }

    print('\nBienvenido al menu de actualizacion\n');
    stdout.write('Ingrese el ID del registro a actualizar: ');
    String id = _leerTextoObligatorio();

    Registro? registro = buscarRegistroPorId(id);

    if (registro == null) {
      print('No se encontro ningun registro con ese ID.\n');
      return;
    }

    stdout.write('Ingrese el nuevo nombre: ');
    registro.nombre = _leerTextoObligatorio();

    stdout.write('Ingrese el nuevo apellido paterno: ');
    registro.aPaterno = _leerTextoObligatorio();

    stdout.write('Ingrese el nuevo apellido materno: ');
    registro.aMaterno = _leerTextoObligatorio();

    stdout.write('Ingrese el nuevo correo electronico: ');
    registro.correo = _leerTextoObligatorio();

    print('Registro actualizado exitosamente.\n');
    print(registro);
  }

  void eliminarRegistro() {
    _imprimirSeparador();

    if (registros.isEmpty) {
      print('\nEl directorio esta vacio.\n');
      return;
    }

    print('\nBienvenido al menu de eliminacion\n');
    stdout.write('Ingrese el ID del registro a eliminar: ');
    String id = _leerTextoObligatorio();

    int longitudAnterior = registros.length;
    registros.removeWhere((registro) => registro.id.toString() == id);

    if (registros.length == longitudAnterior) {
      print('No se encontro ningun registro con ese ID.');
    } else {
      print('Registro eliminado exitosamente.');
    }
  }

  Registro? buscarRegistroPorId(String id) {
    for (final registro in registros) {
      if (registro.id.toString() == id) {
        return registro;
      }
    }
    return null;
  }

  String _leerTextoObligatorio() {
    while (true) {
      String? valor = stdin.readLineSync();
      if (valor != null && valor.trim().isNotEmpty) {
        return valor.trim();
      }
      stdout.write('Entrada invalida. Intente nuevamente: ');
    }
  }

  void _imprimirSeparador() {
    print(separador * longitudSeparador);
  }
}
