import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tus_firmas_app/themes/app_theme.dart';
import 'package:tus_firmas_app/validators/app_validators.dart';

enum FieldType {
  text,
  number,
  email,
  date,
  password,
  phone,
}

class AppTextField extends StatefulWidget {
  final FieldType fieldType;
  final String labelText;
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;

  const AppTextField({
    Key? key,
    required this.fieldType,
    required this.labelText,
    required this.formKey,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
  }) : super(key: key);

  @override
  AppTextFieldState createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {
  late TextInputType _keyboardType;
  bool _obscureText = false;
  late MaskTextInputFormatter _dateMaskFormatter;
  String? _validationResult;

  @override
  void initState() {
    super.initState();
    _setKeyboardType();
    _obscureText = widget.fieldType == FieldType.password;
    _dateMaskFormatter = MaskTextInputFormatter(
      mask: '00/00/0000',
      filter: {"0": RegExp(r'[0-9]')},
    );
  }

  void _setKeyboardType() {
    switch (widget.fieldType) {
      case FieldType.text:
        _keyboardType = TextInputType.text;
        break;
      case FieldType.number:
        _keyboardType = TextInputType.number;
        break;
      case FieldType.email:
        _keyboardType = TextInputType.emailAddress;
        break;
      case FieldType.date:
        _keyboardType = TextInputType.datetime;
        break;
      case FieldType.password:
        _keyboardType = TextInputType.visiblePassword;
        break;
      case FieldType.phone:
        _keyboardType = TextInputType.phone;
        break;
    }
  }

  String? _getValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo no puede estar vacío';
    }

    switch (widget.fieldType) {
      case FieldType.text:
        return AppValidators.isTextValid(value)
            ? null
            : 'Ingrese un texto válido';
      case FieldType.number:
        return AppValidators.isNumberValid(value)
            ? null
            : 'Ingrese un número válido';
      case FieldType.email:
        return AppValidators.isEmailValid(value)
            ? null
            : 'Ingrese un correo electrónico válido';
      case FieldType.date:
        return AppValidators.isDateValid(value)
            ? null
            : 'Ingrese una fecha válida';
      case FieldType.password:
        return AppValidators.isPasswordValid(value)
            ? null
            : 'Ingrese una contraseña válida';
      case FieldType.phone:
        return AppValidators.isEcuadorianPhoneNumberValid(value)
            ? null
            : 'Ingrese un número de teléfono válido';
    }
  }

  void _onChanged(String text) {
    setState(() {
      _validationResult = _getValidator(text);
    });
    widget.formKey.currentState?.validate();
  }

  String? _getHelperText(String? validationResult) {
    if (validationResult != null) {
      return validationResult;
    }
    return null;
  }

  // Determinar input formater funcion
  List<TextInputFormatter> _getInputFormatter() {
    switch (widget.fieldType) {
      case FieldType.text:
        return [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
        ];
      case FieldType.number:
        return [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ];
      case FieldType.email:
        return [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@.]')),
        ];
      case FieldType.date:
        return [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
          _dateMaskFormatter,
        ];
      case FieldType.password:
        return [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
        ];
      case FieldType.phone:
        return [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
          LengthLimitingTextInputFormatter(10)
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      inputFormatters: _getInputFormatter(),
      keyboardType: _keyboardType,
      obscureText: _obscureText,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          floatingLabelAlignment: FloatingLabelAlignment.center,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          floatingLabelStyle: AppTheme.fontFamily.copyWith(
            fontSize: 18,
            letterSpacing: 1.25,
          ),
          labelText: widget.labelText,
          labelStyle: AppTheme.fontFamily.copyWith(
            fontSize: 14,
            letterSpacing: 1.25,
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.primaryColor,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.primaryColor,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.dangerColor,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.dangerColor,
            ),
          ),
          errorText: _getHelperText(_validationResult),
          errorStyle: AppTheme.fontFamily.copyWith(
            color: AppTheme.dangerColor,
            fontSize: 8,
            letterSpacing: 1.25,
          ),
          suffixIcon: widget.fieldType == FieldType.password
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: Icon(
                    _obscureText
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeSlash,
                    color: AppTheme.primaryColor,
                  ),
                )
              : widget.fieldType == FieldType.date
                  ? IconButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(DateTime.now().year + 1),
                          locale: const Locale("es", "ES"),
                        ).then((date) {
                          if (date != null) {
                            String formattedDate =
                                '${date.day}/${date.month}/${date.year}';

                            DateFormat dateFormat = DateFormat('dd/MM/yyyy');
                            formattedDate = dateFormat.format(date);

                            widget.controller.text = _dateMaskFormatter
                                .formatEditUpdate(const TextEditingValue(),
                                    TextEditingValue(text: formattedDate))
                                .text;
                            setState(() {
                              _validationResult =
                                  _getValidator(widget.controller.text);
                            });
                            widget.formKey.currentState?.validate();
                          }
                        });
                      },
                      icon: const Icon(
                        FontAwesomeIcons.calendar,
                        color: AppTheme.primaryColor,
                      ),
                    )
                  : null),
      validator: _getValidator,
      style: AppTheme.fontFamily.copyWith(
        fontSize: 14,
        letterSpacing: 1.25,
      ),
      onChanged: (text) {
        _onChanged(text);
      },
      focusNode: widget.focusNode,
      onEditingComplete: () {
        if (widget.nextFocusNode != null) {
          widget.nextFocusNode?.requestFocus();
        } else {
          widget.focusNode.unfocus();
        }
      },
    );
  }
}
