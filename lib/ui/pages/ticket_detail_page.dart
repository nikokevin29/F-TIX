part of 'pages.dart';

class TicketDetailPage extends StatelessWidget {
  final Ticket ticket;

  TicketDetailPage(this.ticket);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          context.bloc<PageBloc>().add(
              GoToMainPage(bottomNavBarIndex: 1, isExpired: ticket.time.isBefore(DateTime.now())));
          return;
        },
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: ListView(
              children: [
                SizedBox(
                  height: 25,
                ),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () {
                          context.bloc<PageBloc>().add(GoToMainPage(
                              bottomNavBarIndex: 1,
                              isExpired: ticket.time.isBefore(DateTime.now())));
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Ticket Details",
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Card(
                  color: accentColor1,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 125,
                              width: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          imageBaseURL + "w500" + ticket.movieDetail.posterPath),
                                      fit: BoxFit.contain),
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: 75,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        image:
                                            DecorationImage(image: AssetImage('assets/cgv.png')))),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 2 * defaultMargin - 110,
                                  child: Text(
                                    ticket.movieDetail.title,
                                    style: blackTextFont.copyWith(
                                      color: accentColor2,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.clip,
                                    maxLines: 2,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 2 * defaultMargin - 110,
                                  child: Text(
                                    ticket.movieDetail.genresAndLanguage,
                                    style: greyTextFont.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                    overflow: TextOverflow.clip,
                                    maxLines: 2,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                RatingStars(voteAverage: ticket.movieDetail.voteAverage),
                                SizedBox(
                                  height: 25,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: Hexcolor("#F8CA75"),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                //DATE & TIME
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Date & Time",
                                          style: blackTextFont.copyWith(
                                              color: Hexcolor("#89631A"),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                      Text(
                                        ticket.time.dateAndTime,
                                        style: blackTextFont.copyWith(
                                            color: Hexcolor("#89631A"),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                //CINEMA
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Cinema",
                                          style: blackTextFont.copyWith(
                                              color: Hexcolor("#89631A"),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width -
                                            2 * defaultMargin -
                                            133,
                                        child: Text(
                                          ticket.theater.name,
                                          style: blackTextFont.copyWith(
                                              color: Hexcolor("#89631A"),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                          overflow: TextOverflow.clip,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                //SEAT
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Seat",
                                          style: blackTextFont.copyWith(
                                              color: Hexcolor("#89631A"),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                      Text(ticket.seatsInString,
                                          style: blackTextFont.copyWith(
                                              fontSize: 16, fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 7,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 15,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("assets/half_circle.png"))),
                                ),
                                Container(
                                  width: 15,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("assets/half_circle.png"))),
                                ),
                                Container(
                                  width: 15,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("assets/half_circle.png"))),
                                ),
                                Container(
                                  width: 15,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("assets/half_circle.png"))),
                                ),
                                Container(
                                  width: 15,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("assets/half_circle.png"))),
                                ),
                                Container(
                                  width: 15,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("assets/half_circle.png"))),
                                ),
                                Container(
                                  width: 15,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("assets/half_circle.png"))),
                                ),
                                Container(
                                  width: 15,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("assets/half_circle.png"))),
                                ),
                                Container(
                                  width: 15,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("assets/half_circle.png"))),
                                ),
                                Container(
                                  width: 15,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("assets/half_circle.png"))),
                                ),
                                Container(
                                  width: 15,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("assets/half_circle.png"))),
                                ),
                                Container(
                                  width: 15,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("assets/half_circle.png"))),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("ID Order",
                                      style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  Text(
                                    ticket.bookingCode,
                                    style: whiteNumberFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                              Container(
                                  height: 1,
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.grey[200]),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Order Name",
                                            style: blackTextFont.copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey)),
                                        Text(ticket.name,
                                            style: blackTextFont.copyWith(
                                                fontSize: 16, fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Paid*",
                                            style: blackTextFont.copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey)),
                                        Text(ticket.totalPrice.toString(),
                                            style: whiteNumberFont.copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Text("*INCLUDE TAX",
                        style: greyTextFont.copyWith(fontSize: 12, fontWeight: FontWeight.w400))),
              ],
            ),
          ),
        ));
  }
}
