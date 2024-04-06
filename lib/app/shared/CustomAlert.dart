
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CustomAlert {
  static show(
      {context,
      AlertType type = AlertType.success,
      desc = "",
      int duration = 400,
      onPressed}) async {
    // change title based on alert type
    String title = "";
    switch (type) {
      case AlertType.success:
        title = "Succès";
        break;
      case AlertType.error:
        title = "Erreur";
        break;
      case AlertType.warning:
        title = "Attention";
        break;
      case AlertType.info:
        title = "Information";
        break;
      case AlertType.none:
        break;
    }

    await Alert(
      context: context,
      type: type,
      title: title,
      style: AlertStyle(
        isCloseButton: false,
        isOverlayTapDismiss: false,
        descStyle: const TextStyle(fontWeight: FontWeight.bold),
        descTextAlign: TextAlign.center,
        animationDuration: Duration(milliseconds: duration),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side:const  BorderSide(
            color: Colors.grey,
          ),
        ),
        titleStyle: const TextStyle(
          color: Colors.black,
        ),
        alertAlignment: Alignment.center,
      ),
      desc: desc,
      buttons: [
        DialogButton(
          onPressed: onPressed,
          width: 120,
          child:const Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }
}
