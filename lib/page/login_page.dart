import 'package:demoapi/page/register_page.dart';
import 'package:demoapi/page/reportsumit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FarmerLoginPage extends StatefulWidget {
  const FarmerLoginPage({Key? key}) : super(key: key);

  @override
  _FarmerLoginPageState createState() => _FarmerLoginPageState();
}

class _FarmerLoginPageState extends State<FarmerLoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _mobileCtrl = TextEditingController();
  final _pinCtrl = TextEditingController();
  final _mobileFNode = FocusNode();
  final _pinFNode = FocusNode();

  bool _showPin = false;
  bool _showProgress = false;
  bool _isResetPin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 16.0 + MediaQuery.of(context).padding.top,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/login.jpg',
              height: 40.0,
            ),
            SizedBox(height: 16.0),
            Image.asset('images/login.jpg'),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.only(
                bottom: kBottomNavigationBarHeight +
                    MediaQuery.of(context).padding.bottom,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32.0,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        TextButton(
                          onPressed: () {
                            _mobileCtrl.clear();
                            _pinCtrl.clear();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterUserPage(),
                              ),
                            ).then((value) {
                              _isResetPin = false;
                              _mobileCtrl.clear();
                              _pinCtrl.clear();
                              setState(() {});
                            });
                          },
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            focusNode: _mobileFNode,
                            controller: _mobileCtrl,
                            maxLength: 10,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16.0),
                              labelText: 'Enter Mobile Number',
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (value) {
                              if (value!.isEmpty || value.length < 10) {
                                return 'Enter Valid Mobile number';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            focusNode: _pinFNode,
                            controller: _pinCtrl,
                            obscureText: !_showPin,
                            maxLength: 4,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16.0),
                              labelText: 'Enter Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showPin
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showPin = !_showPin;
                                  });
                                },
                              ),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (value) {
                              if (value!.isEmpty || value.length < 4) {
                                return 'Enter Four digit password';
                              }
                              return null;
                            },
                            onChanged: (value) {},
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Successfully Login")),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          ).then((value) {
                            _isResetPin = false;
                            _mobileCtrl.clear();
                            _pinCtrl.clear();
                            setState(() {});
                          });
                        },
                        child: Text('Login'))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
