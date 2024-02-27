import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AlertDialogs {
  static dynamic successMessage(
      BuildContext context, String title, String message,
      {Function? confirmBtnTap}) {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.custom,
      customAsset: 'assets/gifs/success.gif',
      title: title,
      barrierDismissible: false,
      text: message,
      confirmBtnText: "Aceptar",
      onConfirmBtnTap: () {
        if (confirmBtnTap == null) {
          Navigator.of(context).pop();
        } else {
          confirmBtnTap();
        }
      },
    );
  }
}
