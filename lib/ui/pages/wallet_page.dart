part of 'pages.dart';

class WalletPage extends StatelessWidget {
  final PageEvent pageEvent;
  WalletPage(this.pageEvent);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(pageEvent);
        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: accentColor1,
            ),
            SafeArea(
                child: Container(
              color: Colors.white,
            )),
            SafeArea(
              child: Container(
                margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 0),
                child: ListView(
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: GestureDetector(
                            onTap: () {
                              context.bloc<PageBloc>().add(pageEvent);
                            },
                            child: Icon(Icons.arrow_back, color: Colors.black),
                          ),
                        ),
                        BlocBuilder<UserBloc, UserState>(
                          builder: (_, userState) => Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text("My Wallet", style: blackTextFont.copyWith(fontSize: 20)),
                              //ID CARD
                              Container(
                                height: 185,
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: accentColor1,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 10,
                                          spreadRadius: 0,
                                          offset: Offset(0, 5))
                                    ]),
                                child: Stack(
                                  children: [
                                    ClipPath(
                                      clipper: CardReflectionClipper(),
                                      child: Container(
                                        height: 185,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            gradient: LinearGradient(colors: [
                                              Colors.white.withOpacity(0.03),
                                              Colors.white.withOpacity(0)
                                            ])),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 25,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage('assets/card_logo.png'))),
                                          ),
                                          Text(
                                              NumberFormat.currency(
                                                      locale: 'id_ID',
                                                      symbol: 'IDR ',
                                                      decimalDigits: 0)
                                                  .format((userState as UserLoaded).user.balance),
                                              style: whiteNumberFont.copyWith(
                                                  fontSize: 28, fontWeight: FontWeight.w600)),
                                          Row(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Card Holder",
                                                      style: whiteTextFont.copyWith(
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w300)),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        (userState as UserLoaded).user.name,
                                                        style: whiteTextFont.copyWith(fontSize: 12),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(3.0),
                                                        child: SizedBox(
                                                          height: 14,
                                                          width: 14,
                                                          child: Image.asset('assets/ic_check.png'),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Card ID",
                                                      style: whiteTextFont.copyWith(
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w300)),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        (userState as UserLoaded)
                                                            .user
                                                            .id
                                                            .substring(0, 12)
                                                            .toUpperCase(),
                                                        style: whiteTextFont.copyWith(fontSize: 12),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(3.0),
                                                        child: SizedBox(
                                                          height: 14,
                                                          width: 14,
                                                          child: Image.asset('assets/ic_check.png'),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            )
                                          ]),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Recent Transaction",
                                    style: blackTextFont,
                                  )),
                              SizedBox(
                                height: 12,
                              ),
                              FutureBuilder(
                                  future: FlutixTransactionServices.getTransaction(
                                      (userState as UserLoaded).user.id),
                                  builder: (_, snapshot) {
                                    if (snapshot.hasData) {
                                      return generateTransactionList(snapshot.data,
                                          MediaQuery.of(context).size.width - 2 * defaultMargin);
                                    } else {
                                      return SpinKitFadingCircle(
                                        size: 50,
                                        color: mainColor,
                                      );
                                    }
                                  }),
                              SizedBox(
                                height: 75,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: 250,
                                  height: 46,
                                  margin: EdgeInsets.only(bottom: 30),
                                  child: RaisedButton(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8)),
                                      color: mainColor,
                                      child: Text(
                                        "Top Up",
                                        style: whiteTextFont.copyWith(fontSize: 16),
                                      ),
                                      onPressed: () {
                                        context
                                            .bloc<PageBloc>()
                                            .add(GoToTopUpPage(GoToWalletPage(GoToMainPage())));
                                      }),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column generateTransactionList(List<FlutixTransaction> transaction, var width) {
    transaction
        .sort((transaction1, transaction2) => transaction2.time.compareTo(transaction1.time));
    return Column(
        children: transaction
            .map((transaction) => Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: TransactionCard(transaction, width),
                ))
            .toList());
  }
}

class CardReflectionClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 15);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
