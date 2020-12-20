abstract class LoginPresenter {
  Stream<String> get emailErrorStream;
  Stream<String> get passwordErrorStream;
  Stream<bool>   get isFormValidErrorStream;
  Stream<bool>   get isLoadingErrorStream;

  void validateEmail(String email);
  void validatePassword(String password) {}

  void auth() {}
}
