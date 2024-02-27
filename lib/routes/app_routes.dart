import 'package:flutter/material.dart';
import 'package:tus_firmas_app/pages/login_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    // Ruta de Login
    '/': (_) => const LoginPage(),
  };
}
