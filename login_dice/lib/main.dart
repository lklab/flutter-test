import 'package:flutter/material.dart';
import 'dice.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dice game',
      home: LogIn(),
    );
  }
}

class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in'),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: (){}
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: (){}
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50.0),
              ),
              Center(
                child: Image(
                  image: AssetImage('image/chef.gif'),
                  width: 170.0,
                  height: 190.0,
                ),
              ),
              Form(
                child: Theme(
                  data: ThemeData(
                    primaryColor: Colors.teal,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Colors.teal,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Enter "dice"',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: controller,
                          // autofocus: true,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Enter password',
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          controller: controller2,
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        ButtonTheme(
                          minWidth: 100.0,
                          height: 50.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orangeAccent,
                            ),
                            onPressed: () {
                              bool isDice = controller.text == 'dice';
                              bool isPw = controller2.text == '1234';
        
                              if(isDice && isPw) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (BuildContext context) => Dice()),
                                );
                              }
                              else if (!isDice && !isPw) {
                                showSnackBar(context, '로그인 정보를 다시 확인하세요');
                              }
                              else if (!isDice) {
                                showSnackBar(context, 'dice의 철자를 확인하세요');
                              }
                              else {
                                showSnackBar(context, '비밀번호가 일치하지 않습니다.');
                              }
                            },
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 35.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.blue,
    ),
  );
}
