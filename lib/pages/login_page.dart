import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tus_firmas_app/widgets/forms/button.dart';
import 'package:tus_firmas_app/widgets/forms/texfield.dart';
// Ajusta la importación según la ubicación de tu archivo AppButton

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                      40.0), // Ajusta el valor según sea necesario
                  child: const Image(
                    image: AssetImage('assets/gifs/success.gif'),
                    height: 200,
                  ),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  fieldType: FieldType.email,
                  labelText: 'Correo',
                  formKey: _formKey,
                  controller: _emailController,
                  focusNode: _emailFocus,
                  nextFocusNode: _passwordFocus,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  fieldType: FieldType.date,
                  labelText: 'Contraseña',
                  formKey: _formKey,
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                ),
                const SizedBox(height: 16),
                AppButton(
                  text: 'Iniciar Sesión',
                  loading: _isLoading,
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      setState(() {
                        _isLoading = true;
                      });
                      Future.delayed(const Duration(seconds: 2), () {
                        if (_emailController.text ==
                                'panchoulloateran@gmail.com' &&
                            _passwordController.text == 'ForkyCode0313') {
                          QuickAlert.show(
                            context: context,
                            title: '¡Lo lograste',
                            text: 'Bienvenido',
                            type: QuickAlertType.success,
                            
                          );
                        } else {
                          QuickAlert.show(
                            context: context,
                            title: '¡Error!',
                            text: 'Usuario o contraseña incorrectos',
                            type: QuickAlertType.error,
                          );
                        }
                        setState(() {
                          _isLoading = false;
                        });
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
