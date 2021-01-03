import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../ui/pages/pages.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../protocols/protocols.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;

  String _email;
  String _password;
  var _emailError = RxString();
  var _passwordError = RxString();
  var _mainError = RxString();
  var _isFormValid = false.obs;
  var _isLoading = false.obs;

  GetxLoginPresenter(
      {@required this.validation, @required this.authentication});

  void validateEmail(String email) {
    _email = email;
    _emailError.value = validation.validate(field: 'email', value: email);
    _validateForm();
  }

  void validatePassword(password) {
    _password = password;
    _passwordError.value =
        validation.validate(field: 'password', value: password);
    _validateForm();
  }

  void _validateForm() {
    _isFormValid.value = _emailError.value == null &&
        _passwordError.value == null &&
        _email != null &&
        _password != null;
  }

  Future<void> auth() async {

    _isLoading.value = true;
    _validateForm();

    try {
      await authentication
          .auth(AuthenticationParams(email: _email, secret: _password));
    } on DomainError catch (error) {
      _mainError.value = error.description;
    }

    _isLoading.value = false;
    _validateForm();
  }

  @override
 
  RxString get emailError => _emailError;

  @override
  
  RxBool get isFormValid => _isFormValid;

  @override
  
  RxBool get isLoading => _isLoading;

  @override
  
  RxString get mainError => _mainError;

  @override
  
  RxString get passwordError => _passwordError;

}
