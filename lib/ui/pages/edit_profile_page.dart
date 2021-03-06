part of 'pages.dart';

class EditProfilePage extends StatefulWidget {
  final User user;

  EditProfilePage(this.user);
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController;
  String profilePath;
  bool isDataEdited = false;
  File profileImageFile;
  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    profilePath = widget.user.profilePicture;
  }

  @override
  Widget build(BuildContext context) {
    context.bloc<ThemeBloc>().add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor2)));

    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToProfilePage());

        return;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ],
          leading: GestureDetector(
            onTap: () {
              context.bloc<PageBloc>().add(GoToProfilePage());
              print('JO JO');
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Align(
            alignment: Alignment.center,
            child: Text(
              "Edit Your Profile",
              style: blackTextFont.copyWith(fontSize: 20),
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              SafeArea(
                  child: Stack(children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: ListView(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 22, bottom: 10),
                            width: 90,
                            height: 104,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: (profileImageFile != null)
                                                ? FileImage(profileImageFile)
                                                : (profilePath != "")
                                                    ? NetworkImage(profilePath)
                                                    : AssetImage("assets/user_pic.png"),
                                            fit: BoxFit.cover))),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (profilePath == "") {
                                        profileImageFile = await getImage();

                                        if (profileImageFile != null) {
                                          profilePath = basename(profileImageFile.path);
                                        }
                                      } else {
                                        profileImageFile = null;
                                        profilePath = "";
                                      }

                                      setState(() {
                                        isDataEdited =
                                            (nameController.text.trim() != widget.user.name ||
                                                    profilePath != widget.user.profilePicture)
                                                ? true
                                                : false;
                                      });
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage((profilePath == "")
                                                  ? "assets/btn_add_photo.png"
                                                  : "assets/btn_remove_photo.png"))),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          AbsorbPointer(
                            child: TextField(
                              controller: TextEditingController(text: widget.user.email),
                              style: greyTextFont,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                labelText: "Email Address",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextField(
                            controller: nameController,
                            onChanged: (text) {
                              setState(() {
                                isDataEdited = (text.trim() != widget.user.name ||
                                        profilePath != widget.user.profilePicture)
                                    ? true
                                    : false;
                              });
                            },
                            style: blackTextFont,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              labelText: "Full Name",
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: 250,
                            height: 45,
                            child: RaisedButton(
                                elevation: 0,
                                shape:
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      MdiIcons.alertCircle,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Change Password",
                                      style: whiteTextFont.copyWith(
                                          fontSize: 16,
                                          color: (isUpdating) ? Color(0xFFBEBEBE) : Colors.white),
                                    ),
                                  ],
                                ),
                                disabledColor: Color(0xFFE4E4E4),
                                color: Colors.red[400],
                                onPressed: (isUpdating)
                                    ? null
                                    : () async {
                                        await AuthServices.resetPassword(widget.user.email);

                                        Flushbar(
                                          duration: Duration(milliseconds: 2000),
                                          flushbarPosition: FlushbarPosition.BOTTOM,
                                          backgroundColor: Color(0xFFFF5C83),
                                          message:
                                              "The link to change your password has been sent to your email.",
                                        )..show(context);
                                      }),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          (isUpdating)
                              ? SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: SpinKitFadingCircle(
                                    color: Color(0xFF3E9D9D),
                                  ),
                                )
                              : SizedBox(
                                  width: 250,
                                  height: 45,
                                  child: RaisedButton(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8)),
                                      child: Text(
                                        "Update Profile",
                                        style: whiteTextFont.copyWith(
                                            fontSize: 16,
                                            color:
                                                (isDataEdited) ? Colors.white : Color(0xFFBEBEBE)),
                                      ),
                                      disabledColor: Color(0xFFE4E4E4),
                                      color: Color(0xFF3E9D9D),
                                      onPressed: (isDataEdited)
                                          ? () async {
                                              setState(() {
                                                isUpdating = true;
                                              });

                                              if (profileImageFile != null) {
                                                profilePath = await uploadImage(profileImageFile);
                                              }

                                              context.bloc<UserBloc>().add(UpdateData(
                                                  name: nameController.text,
                                                  profileImage: profilePath));

                                              context.bloc<PageBloc>().add(GoToProfilePage());
                                            }
                                          : null),
                                )
                        ],
                      )
                    ],
                  ),
                ),
              ])),
            ],
          ),
        ),
      ),
    );
  }
}
