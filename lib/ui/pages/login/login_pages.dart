  import 'package:flutter/material.dart';
  
  import 'login_presenter.dart';

  import '../../components/components.dart';
  import 'components/components.dart';

  class LoginPage extends StatelessWidget {
    final LoginPresenter presente;

    const LoginPage(this.presente);
  

    @override
    Widget build(BuildContext context) {
        void _hideKeyBord() {
        final correntFocus = FocusScope.of(context);
        if (!correntFocus.hasPrimaryFocus) {
          correntFocus.unfocus();
        }
      }

      
      return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Builder(
          builder: (context) {
            presente.isLoading.listen((isLoading) {
              if (isLoading) {
                showloading(context);
              } else {
                hideLoading(context);
              }
            });
            presente.mainError.listen((error) {
              if (error != null) {
                showErrorMessage(context, error);
              }
            });

            return GestureDetector(
              onTap: _hideKeyBord,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LoginHeader(),
                    HeadLine1(
                      text: 'Login',
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        child: Column(
                          children: [
                            EmailInput(),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8, bottom: 32),
                              child: PasswordInput(),
                            ),
                            LoginButton(),
                            FlatButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.person),
                              label: Text('Criar Conta'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
