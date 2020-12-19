import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoiginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
            ),
            Container(
              child: Image(
                image: AssetImage('lib/ui/assets/logo.png'),
              ),
            ),
            Text('Login'.toUpperCase()),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Email', icon: Icon(Icons.email)),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      icon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                  ),
                  RaisedButton(
                    onPressed: () {},
                    child: Text('Entrar'.toUpperCase()),
                  ),
                  FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.person),
                    label: Text('Criar Conta'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
