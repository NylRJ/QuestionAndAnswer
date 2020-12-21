import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages.dart';

import '../../components/components.dart';
import 'components/components.dart';

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
              showloading(context);
            } else {
              hideLoading(context);
            }
          });
          widget.presente.mainErrorStream.listen((error) {
            if (error != null) {
              showErrorMessage(context,error);
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
                  child: Provider(
                    create: (_) => widget.presente,
                      child: Form(
                      child: Column(
                        children: [
                          EmailInput(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 32),
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


