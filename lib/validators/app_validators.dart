class AppValidators {
  static bool isTextValid(String text) {
    return text.isNotEmpty;
  }

  static bool isNumberValid(String number) {
    return double.tryParse(number) != null;
  }

  static bool isEmailValid(String email) {
    RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return regex.hasMatch(email);
  }

  static bool isDateValid(String value) {
    try {
      // Intentar parsear la fecha
      DateTime dateTime = DateTime(
        int.parse(value.substring(6, 10)), // Año
        int.parse(value.substring(3, 5)), // Mes
        int.parse(value.substring(0, 2)), // Día
      );

      // Validar que los valores de día, mes y año son correctos
      if (dateTime.day != int.parse(value.substring(0, 2)) ||
          dateTime.month != int.parse(value.substring(3, 5)) ||
          dateTime.year != int.parse(value.substring(6, 10))) {
        return false;
      }

      // La entrada es válida
      return true;
    } catch (e) {
      return false; // Error al parsear la fecha, la entrada no es válida
    }
  }

  static bool isPasswordValid(String password) {
    return password.length >= 8;
  }

  static bool isEcuadorianPhoneNumberValid(String phoneNumber) {
    RegExp regex = RegExp(r'^(\+593\d{9}|09\d{8})$');
    return regex.hasMatch(phoneNumber);
  }
}
