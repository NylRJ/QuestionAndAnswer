import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../components/components.dart';
import '../pages.dart';

class LoiginPage extends StatefulWidget {
  final LoginPresenter presente;

  const LoiginPage({Key key, this.presente}) : super(key: key);

  @override
  _LoiginPageState createState() => _LoiginPageState();
}

class _LoiginPageState extends State<LoiginPage> {
  @override
  void dispose() {
    super.dispose();
    widget.presente.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Builder(
        builder: (context) {
          widget.presente.isLoadingErrorStream.listen((isLoading) {
            if (isLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                child: SimpleDialog(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Aguarde...',
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ],
                ),
              );
            } else {
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              }
            }
          });
          widget.presente.mainErrorStream.listen((error) {
            if (error != null) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red[900],
                  content: Text(
                    error,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          });

          return SingleChildScrollView(
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
                        StreamBuilder<String>(
                            stream: widget.presente.emailErrorStream,
                            builder: (context, snapshot) {
                              return TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Email',
                                    errorText: snapshot.data?.isEmpty == true
                                        ? null
                                        : snapshot.data,
                                    icon: Icon(
                                      Icons.email,
                                      color:
                                          Theme.of(context).primaryColorLight,
                                    )),
                                keyboardType: TextInputType.emailAddress,
                                onChanged: widget.presente.validateEmail,
                              );
                            }),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 32),
                          child: StreamBuilder<String>(
                              stream: widget.presente.passwordErrorStream,
                              builder: (context, snapshot) {
                                return TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Senha',
                                    errorText: snapshot.data?.isEmpty == true
                                        ? null
                                        : snapshot.data,
                                    icon: Icon(
                                      Icons.lock,
                                      color:
                                          Theme.of(context).primaryColorLight,
                                    ),
                                  ),
                                  obscureText: true,
                                  onChanged: widget.presente.validatePassword,
                                );
                              }),
                        ),
                        StreamBuilder<bool>(
                            stream: widget.presente.isFormValidErrorStream,
                            builder: (context, snapshot) {
                              return RaisedButton(
                                onPressed: snapshot.data == true
                                    ? widget.presente.auth
                                    : null,
                                child: Text('Entrar'.toUpperCase()),
                              );
                            }),
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
          );
        },
      ),
    );
  }
}
