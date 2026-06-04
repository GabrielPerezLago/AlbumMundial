
import 'package:album_frontend/uitls/StringApp.dart';

class UserUtils {

  bool checkData(String email, String password) {
    if (email.isNullOrEmpty) {
      return false;
    }

    if (!_validateEmail(email)) {
      return false;
    }

    if (password.isNullOrEmpty)  {
      return false;
    }

    return true;
  }


  bool checkDataWhithName(String nombre, String email, String password) {

    if (nombre.isNullOrEmpty) return false;

    if (email.isNullOrEmpty) {
      return false;
    }

    if (!_validateEmail(email)) {
      return false;
    }

    if (password.isNullOrEmpty)  {
      return false;
    }

    return true;
  }



  bool _validateEmail(String email) {
    if (email.contains('@') && email.contains('.')) {
      return true;
    }
    return false;
  }
}