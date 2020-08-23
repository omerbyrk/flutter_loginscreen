import 'package:flutter/material.dart';
import 'package:widget_utils/widget_utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: WidgetUtilsBuilder(
          responsiveParams: ResponsiveParams(allowTextScale: false),
          localizationParams: LocalizationParams(
              defLang: Locale("en", "US"),
              langAssets: ["assets/lang/en.json", "assets/lang/tr.json"]),
          builder: (_) {
            return LoginPage();
          },
        ));
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          _loginPageTopSection(context),
          _loginPageBottomSection(context)
        ],
      ),
    ));
  }

  Widget _loginPageTopSection(BuildContext context) {
    return Container(
      width: getWidth(context, percent: 1),
      padding: EdgeInsets.only(top: convertSize(20), bottom: convertSize(20)),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(convertSize(35)),
            bottomRight: Radius.circular(convertSize(35))),
      ),
      child: Image.asset(
        "assets/image/logo.png",
        width: convertSize(200),
        height: convertSize(200),
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _loginPageBottomSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: convertSize(24), vertical: convertSize(37)),
      child: Column(
        children: [
          _loginPageTitle(),
          SizedBox(
            height: convertSize(24),
          ),
          _loginPageTextField(l("login_page_username_hint"),
              _usernameTextEditingController, Icons.person),
          SizedBox(
            height: convertSize(15),
          ),
          _loginPageTextField(l("login_page_password_hint"),
              _passwordTextEditingController, Icons.vpn_key,
              obscureText: true),
          SizedBox(
            height: convertSize(25),
          ),
          _loginPageButton(context)
        ],
      ),
    );
  }

  Widget _loginPageTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.lock,
          size: getIconSize(SizeType.Ultra),
        ),
        SizedBox(
          height: convertSize(5),
        ),
        Text(
          l("login_page_title"),
          style: TextStyle(fontSize: getFontSize(SizeType.Ultra)),
        )
      ],
    );
  }

  Widget _loginPageTextField(
      String hintText, TextEditingController controller, IconData iconData,
      {bool obscureText = false}) {
    return Material(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(convertSize(12)),
          side: BorderSide(
              color: Colors.grey[200],
              width: convertSize(1.2),
              style: BorderStyle.solid)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: convertSize(8), vertical: convertSize(12)),
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          style: TextStyle(fontSize: getFontSize(SizeType.Middle)),
          decoration: InputDecoration(
              icon: Icon(
                iconData,
                color: Colors.black,
                size: getIconSize(SizeType.Middle),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(0),
              hintText: hintText),
        ),
      ),
    );
  }

  Widget _loginPageButton(BuildContext context) {
    return Material(
        color: Colors.blue,
        elevation: 5.0,
        shadowColor: Colors.blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(convertSize(12))),
        child: InkWell(
          onTap: () {
            if (_passwordTextEditingController.text == "admin" &&
                _usernameTextEditingController.text == "admin") {
              this.createSuccessToast(context, l("login_success_message"));
            } else {
              this.createErrorToast(context, l("login_error_message"));
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: convertSize(8)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                Icons.lock_open,
                color: Colors.white,
                size: getIconSize(SizeType.Middle),
              ),
              SizedBox(
                width: convertSize(5),
              ),
              Text(l("login_page_button"),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: getFontSize(SizeType.Middle)))
            ]),
          ),
        ));
  }
}
