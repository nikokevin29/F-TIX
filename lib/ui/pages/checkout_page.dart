part of 'pages.dart';

class CheckoutPage extends StatefulWidget {
  final Ticket ticket;
  CheckoutPage(this.ticket);
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    var total = 26500 * widget.ticket.seats.length;
    return WillPopScope(
        onWillPop: () {
          context.bloc<PageBloc>().add(GoToSelectSeatPage(widget.ticket));
          return;
        },
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                color: accentColor1,
              ),
              SafeArea(
                child: Container(color: Colors.white),
              ),
              ListView(
                children: [
                  Stack(
                    children: [
                      //note: BACK BUTTON
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(
                              left: defaultMargin,
                              top: 10,
                            ),
                            child: GestureDetector(
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                              onTap: () {
                                context.bloc<PageBloc>().add(GoToSelectSeatPage(widget.ticket));
                              },
                            ),
                          ),
                        ),
                      ),
                      // note: PAGE TITLE
                      BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
                        User user = (userState as UserLoaded).user;

                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                "CheckOut\nMovie",
                                style: blackTextFont.copyWith(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 70,
                                  height: 90,
                                  margin: EdgeInsets.only(left: defaultMargin, right: 20),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(imageBaseURL +
                                              'w342' +
                                              widget.ticket.movieDetail.posterPath),
                                          fit: BoxFit.cover)),
                                ),
                                //TITLE
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          2 * defaultMargin -
                                          20 -
                                          70,
                                      child: Text(
                                        widget.ticket.movieDetail.title,
                                        style: whiteNumberFont.copyWith(
                                            fontSize: 18, color: Colors.black),
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                    Container(
                                        width: MediaQuery.of(context).size.width -
                                            2 * defaultMargin -
                                            20 -
                                            70,
                                        margin: EdgeInsets.symmetric(vertical: 6),
                                        child: Text(
                                          widget.ticket.movieDetail.genresAndLanguage,
                                          style: greyTextFont.copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        )),
                                    RatingStars(
                                      voteAverage: widget.ticket.movieDetail.voteAverage,
                                      color: accentColor3,
                                    )
                                  ],
                                )
                              ],
                            ),
                            //DIVIDER
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20, horizontal: defaultMargin),
                              child: Divider(
                                color: Color(0xFFE4E4E4),
                                thickness: 1,
                              ),
                            ),
                            //ORDER ID
                            Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Order ID",
                                          style: greyTextFont.copyWith(
                                              fontSize: 16, fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          widget.ticket.bookingCode,
                                          style: whiteNumberFont.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 9,
                            ),
                            //CINEMA
                            Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Cinemma",
                                          style: greyTextFont.copyWith(
                                              fontSize: 16, fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.55,
                                          child: Text(
                                            widget.ticket.theater.name,
                                            textAlign: TextAlign.end,
                                            style: whiteNumberFont.copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 9,
                            ),
                            //DATE AND TIME
                            Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Date & Time",
                                          style: greyTextFont.copyWith(
                                              fontSize: 16, fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          widget.ticket.time.dateAndTime,
                                          style: whiteNumberFont.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 9,
                            ),
                            //SEAT NUMBER
                            Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Seat Numbers",
                                          style: greyTextFont.copyWith(
                                              fontSize: 16, fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.55,
                                          child: Text(
                                            widget.ticket.seatsInString,
                                            textAlign: TextAlign.end,
                                            style: whiteNumberFont.copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 9,
                            ),
                            //PRICE
                            Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Price",
                                          style: greyTextFont.copyWith(
                                              fontSize: 16, fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "IDR 25.000 x ${widget.ticket.seats.length}",
                                          textAlign: TextAlign.right,
                                          style: whiteNumberFont.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 9,
                            ),
                            //FEE
                            Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Fee",
                                          style: greyTextFont.copyWith(
                                              fontSize: 16, fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "IDR 1.500 x ${widget.ticket.seats.length}",
                                          textAlign: TextAlign.right,
                                          style: whiteNumberFont.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 9,
                            ),
                            //TOTAL
                            Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total",
                                          style: greyTextFont.copyWith(
                                              fontSize: 16, fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          NumberFormat.currency(
                                                  locale: 'id-ID', decimalDigits: 2, symbol: "IDR ")
                                              .format(total),
                                          textAlign: TextAlign.right,
                                          style: whiteNumberFont.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 9,
                            ),
                            //DIVIDER
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20, horizontal: defaultMargin),
                              child: Divider(
                                color: Color(0xFFE4E4E4),
                                thickness: 1,
                              ),
                            ),
                            //User Balance
                            Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Your Wallet",
                                          style: greyTextFont.copyWith(
                                              fontSize: 16, fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          NumberFormat.currency(
                                                  locale: 'id-ID', decimalDigits: 2, symbol: "IDR ")
                                              .format(user.balance),
                                          textAlign: TextAlign.right,
                                          style: whiteNumberFont.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: user.balance >= total
                                                  ? Color(0xFF3E9D9D)
                                                  : Colors.red),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 250,
                              height: 46,
                              margin: EdgeInsets.only(top: 36, bottom: 50),
                              child: RaisedButton(
                                elevation: 0,
                                color: user.balance >= total ? Color(0xFF3E9D9D) : mainColor,
                                shape:
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  user.balance >= total ? "Checkout Now" : "Top Up My Wallet",
                                  style: whiteTextFont.copyWith(fontSize: 16),
                                ),
                                onPressed: () {
                                  if (user.balance >= total) {
                                    FlutixTransaction transaction = FlutixTransaction(
                                        //Uang Cukup
                                        userID: user.id,
                                        title: widget.ticket.movieDetail.title,
                                        subtitle: widget.ticket.theater.name,
                                        time: DateTime.now(),
                                        amount: -total,
                                        picture: widget.ticket.movieDetail.posterPath);

                                    context.bloc<PageBloc>().add(GoToSuccessPage(
                                        widget.ticket.copyWith(totalPrice: total), transaction));
                                  } else {
                                    // uang Tidak Cukup

                                  }
                                },
                              ),
                            )
                          ],
                          //note: movie desc
                        );
                      }),
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
