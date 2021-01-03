import 'package:flutter/material.dart';
import 'package:fordev/ui/pages/login/login_presenter.dart';
import 'package:get/get.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Get.find<LoginPresenter>();
    return Obx(() => RaisedButton(
      onPressed: presenter.isFormValid?.value == true ? presenter.auth : null,
      child: Text('Entrar'.toUpperCase()),
    ));
  }
}
