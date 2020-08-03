part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  final RegistrationData registrationData;
  SignUpPage(this.registrationData);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
  bool _passwordVisible;
  bool _retypepasswordVisible;
  @override
  void initState() {
    super.initState();
    nameController.text = widget.registrationData.name;
    emailController.text = widget.registrationData.email;
    _passwordVisible = false;
    _retypepasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSplashPage());
        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 56,
                    margin: EdgeInsets.only(bottom: 20, top: 20),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              context.bloc<PageBloc>().add(GoToSplashPage());
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Create New\n Account ",
                            style:
                                blackTextFont.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 90,
                    height: 104,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: (widget.registrationData.profileImage == null)
                                      ? AssetImage("assets/user_pic.png")
                                      : FileImage(widget.registrationData.profileImage),
                                  fit: BoxFit.cover)),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () async {
                              if (widget.registrationData.profileImage == null) {
                                widget.registrationData.profileImage = await getImage();
                              } else {
                                widget.registrationData.profileImage = null;
                              }
                              setState(() {});
                            },
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          (widget.registrationData.profileImage == null)
                                              ? "assets/btn_add_photo.png"
                                              : "assets/btn_remove_photo.png"),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Full Name",
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Email Address",
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    obscureText: !_passwordVisible,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Pasword",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    obscureText: !_retypepasswordVisible,
                    controller: retypePasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Confirm Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _retypepasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          setState(() {
                            _retypepasswordVisible = !_retypepasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FloatingActionButton(
                    child: Icon(Icons.arrow_forward, color: Colors.white),
                    backgroundColor: mainColor,
                    elevation: 0,
                    onPressed: () {
                      if (!(nameController.text.trim() != "" &&
                          emailController.text.trim() != "" &&
                          passwordController.text.trim() != "" &&
                          retypePasswordController.text.trim() != "")) {
                        Flushbar(
                          duration: Duration(seconds: 2),
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: Color(0xFFFF5C83),
                          message: "Please fill all text Fields",
                        )..show(context);
                      } else if (passwordController.text.trim() != retypePasswordController.text.trim()) {
                        Flushbar(
                          duration: Duration(seconds: 2),
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: Color(0xFFFF5C83),
                          message: "Mismatch Password and Confirm password",
                        )..show(context);
                      } else if (passwordController.text.length < 6) {
                        Flushbar(
                          duration: Duration(seconds: 2),
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: Color(0xFFFF5C83),
                          message: "Password length atleast 6 characters",
                        )..show(context);
                      } else if (!EmailValidator.validate(emailController.text)) {
                        Flushbar(
                          duration: Duration(seconds: 2),
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: Color(0xFFFF5C83),
                          message: "Wrong Email Format",
                        )..show(context);
                      } else {
                        widget.registrationData.name = nameController.text;
                        widget.registrationData.email = emailController.text;
                        widget.registrationData.password = passwordController.text;

                        context.bloc<PageBloc>().add(GoToPreferencePage(widget.registrationData));
                      }
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
