part of 'pages.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToMainPage());
        return;
      },
      child: MaterialApp(
        home: Scaffold(
            body: Stack(children: [
          Container(
            color: accentColor1,
          ),
          SafeArea(
              child: Container(
            color: Colors.white,
          )),
          Container(
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width,
            height: 100,
            decoration: BoxDecoration(
              color: accentColor1,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
            ),
            child: Container(
              margin:
                  EdgeInsets.only(left: defaultMargin, right: defaultMargin, top: defaultMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Profile Page",
                    style: blackTextFont.copyWith(fontSize: 22, color: Colors.white),
                  ),
                  //LOGOUT
                  GestureDetector(
                    onTap: () {
                      context.bloc<UserBloc>().add(SignOut());
                      AuthServices.signOut();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage("assets/logout.png"))),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text("Logout",
                            style:
                                whiteTextFont.copyWith(fontSize: 12, fontWeight: FontWeight.w400))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ListView(
              children: [
                BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
                  if (userState is UserLoaded) {
                    User user = userState.user;
                    return Column(
                      children: [
                        Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(top: 130, bottom: 10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.amber[100], width: 3),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SpinKitFadingCircle(
                                          color: accentColor2,
                                          size: 50,
                                        ),
                                        Container(
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage(user.profilePicture),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ],
                                    )),
                                Text(
                                  user.name,
                                  style: blackTextFont.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  user.email,
                                  style: greyTextFont.copyWith(
                                      fontWeight: FontWeight.w400, fontSize: 16),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //EDIT PROFILE
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .bloc<PageBloc>()
                                              .add(GoToEditProfilePage((userState).user));
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/edit_profile.png"))),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "Edit Profile",
                                                  style: blackTextFont.copyWith(
                                                      fontSize: 16, fontWeight: FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                      //DIVIDER
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: DottedLine(
                                          direction: Axis.horizontal,
                                          lineThickness: 1.0,
                                          dashLength: 300,
                                          dashColor: Colors.grey[200],
                                          dashGapLength: 4.0,
                                        ),
                                      ),
                                      //MY WALLET
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .bloc<PageBloc>()
                                              .add(GoToWalletPage(GoToProfilePage()));
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image:
                                                              AssetImage("assets/my_wallet.png"))),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "My Wallet",
                                                  style: blackTextFont.copyWith(
                                                      fontSize: 16, fontWeight: FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                      //DIVIDER
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: DottedLine(
                                          direction: Axis.horizontal,
                                          lineThickness: 1.0,
                                          dashLength: 300,
                                          dashColor: Colors.grey[200],
                                          dashGapLength: 4.0,
                                        ),
                                      ),
                                      //CHANGE LANGUAGE
                                      GestureDetector(
                                        onTap: () {},
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/language_icon.png"))),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "Change Language",
                                                  style: blackTextFont.copyWith(
                                                      fontSize: 16, fontWeight: FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                      //DIVIDER
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: DottedLine(
                                          direction: Axis.horizontal,
                                          lineThickness: 1.0,
                                          dashLength: 300,
                                          dashColor: Colors.grey[200],
                                          dashGapLength: 4.0,
                                        ),
                                      ),
                                      //HELP CENTER
                                      GestureDetector(
                                        onTap: () {},
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/verified_user_24px_outlined.png"))),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "Help Center",
                                                  style: blackTextFont.copyWith(
                                                      fontSize: 16, fontWeight: FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                      //DIVIDER
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: DottedLine(
                                          direction: Axis.horizontal,
                                          lineThickness: 1.0,
                                          dashLength: 300,
                                          dashColor: Colors.grey[200],
                                          dashGapLength: 4.0,
                                        ),
                                      ),
                                      //RATE THIS APP
                                      GestureDetector(
                                        onTap: () {},
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage("assets/like.png"))),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "Rate This App",
                                                  style: blackTextFont.copyWith(
                                                      fontSize: 16, fontWeight: FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    );
                  } else {
                    return SizedBox(height: 20);
                  }
                })
              ],
            ),
          ),
        ])),
      ),
    );
  }
}
