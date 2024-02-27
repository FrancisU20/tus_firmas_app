import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tus_firmas_app/routes/app_routes.dart';
import 'package:tus_firmas_app/themes/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.getAppTheme(),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('es'),
      ],
      onGenerateRoute: (settings) {
        final String? name = settings.name;
        final WidgetBuilder? builder = AppRoutes.routes[name!];
        return MaterialPageRoute(builder: builder!, settings: settings);
      },
    );
  }
}
