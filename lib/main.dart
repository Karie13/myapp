import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    if (!value.contains('@')) {
      return 'Email must contain @';
    }
    if (!value.contains('.')) {
      return 'Email must contain a dot';
    }
    int atIndex = value.indexOf('@');
    int dotIndex = value.lastIndexOf('.');
    if (atIndex < 1 || dotIndex < atIndex + 2 || dotIndex == value.length - 1) {
      return 'Email must be valid';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    bool hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
    bool hasLowercase = RegExp(r'[a-z]').hasMatch(value);
    bool hasSpecialCharacter = RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value);

    if (!hasUppercase) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!hasLowercase) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!hasSpecialCharacter) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login Successful'),
          backgroundColor: Colors.blue,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final pgColor = Colors.blue;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [pgColor.shade300, pgColor.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Container(
                    child: IntrinsicHeight(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: screenHeight * 0.35,
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.all(screenWidth * 0.05),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.person,
                                        size: 80,
                                        color: pgColor.shade700,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.08,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10.0,
                                      offset: Offset(0, -5),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(screenWidth * 0.05),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        SizedBox(height: 40.0),
                                        TextFormField(
                                          controller: _emailController,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                                            hintText: 'Username',
                                            hintStyle: TextStyle(color: Colors.grey[600]),
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: pgColor.shade700),
                                              borderRadius: BorderRadius.circular(32.0),
                                            ),
                                            prefixIcon: Icon(Icons.email, color: pgColor.shade700),
                                          ),
                                          keyboardType: TextInputType.emailAddress,
                                          validator: _validateEmail,
                                        ),
                                        SizedBox(height: 30.0),
                                        TextFormField(
                                          controller: _passwordController,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                                            hintText: 'Password',
                                            hintStyle: TextStyle(color: Colors.grey[600]),
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: pgColor.shade700),
                                              borderRadius: BorderRadius.circular(32.0),
                                            ),
                                            prefixIcon: Icon(Icons.lock, color: pgColor.shade700),
                                          ),
                                          obscureText: true,
                                          validator: _validatePassword,
                                        ),
                                        SizedBox(height: 30.0),
                                        Center(
                                          child: FloatingActionButton(
                                            onPressed: _handleSubmit,
                                            backgroundColor: pgColor.shade500,
                                            child: Icon(
                                              Icons.arrow_forward,
                                              color: Colors.white,
                                              size: screenWidth * 0.08,
                                            ),
                                            shape: CircleBorder(),
                                            elevation: 5,
                                          ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Center(
        child: Text(
          'Login Successful',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      ),
    );
  }
}
