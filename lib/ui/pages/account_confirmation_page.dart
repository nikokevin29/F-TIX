part of 'pages.dart';

class AccountConfirmationPage extends StatefulWidget {
  final RegistrationData registrationData;

  AccountConfirmationPage(this.registrationData);
  @override
  _AccountConfirmationPageState createState() => _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  bool isSigningUp = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToPreferencePage(widget.registrationData));
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
                    margin: EdgeInsets.only(bottom: 90, top: 20),
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
                            "Confirm\n New Account ",
                            style:
                                blackTextFont.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: (widget.registrationData.profileImage == null)
                                ? AssetImage("assets/user_pic.png")
                                : FileImage(widget.registrationData.profileImage),
                            fit: BoxFit.cover)),
                  ),
                  Text(
                    "Welcome",
                    style: blackTextFont.copyWith(fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "${widget.registrationData.name}",
                    textAlign: TextAlign.center,
                    style: blackTextFont.copyWith(fontSize: 22),
                  ),
                  SizedBox(
                    height: 110,
                  ),
                  (isSigningUp)
                      ? SpinKitFadingCircle(
                          color: Colors.green,
                          size: 45,
                        )
                      : SizedBox(
                          width: 250,
                          height: 45,
                          child: RaisedButton(
                              color: Color(0x3E9D9D),
                              child: Text(
                                "Create Account",
                                style: whiteTextFont.copyWith(fontSize: 16),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              onPressed: () async {
                                setState(() {
                                  isSigningUp = true;
                                });
                                imageFileToUpload = widget.registrationData.profileImage;

                                SignInSignUpResult result = await AuthServices.signUp(
                                    widget.registrationData.email,
                                    widget.registrationData.password,
                                    widget.registrationData.name,
                                    widget.registrationData.selectedGenres,
                                    widget.registrationData.selectedLanguage);

                                if (result.user == null) {
                                  setState(() {
                                    isSigningUp = false;
                                  });

                                  Flushbar(
                                    duration: Duration(seconds: 2),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    backgroundColor: Color(0xFFFF5C83),
                                    message: result.messeage,
                                  )..show(context);
                                }
                              }),
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
