part of 'pages.dart';

class SelectSeatPage extends StatefulWidget {
  final Ticket ticket;

  SelectSeatPage(this.ticket);
  @override
  _SelectSeatPageState createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  List<String> selectedSeats = [];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          context.bloc<PageBloc>().add(GoToSelectScedulePage(widget.ticket.movieDetail));

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
                  // note: HEADER
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
                            context
                                .bloc<PageBloc>()
                                .add(GoToSelectScedulePage(widget.ticket.movieDetail));
                          },
                        ),
                      ),
                    ),
                  ),
                  // note : Title + Poster
                  Container(
                    margin: EdgeInsets.only(right: defaultMargin, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 16),
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            widget.ticket.movieDetail.title,
                            style: blackTextFont.copyWith(fontSize: 20),
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.end,
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      imageBaseURL + 'w154' + widget.ticket.movieDetail.posterPath),
                                  fit: BoxFit.cover)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    width: 277,
                    height: 84,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('assets/screen.png'))),
                  ),
                  // note: SEATS
                  generateSeats(),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    height: 20,
                    width: 252,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/indicatorSeats1.png'),
                        Image.asset('assets/indicatorSeats2.png'),
                        Image.asset('assets/indicatorSeats3.png'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // note: Button
                  Align(
                    alignment: Alignment.topCenter,
                    child: FloatingActionButton(
                      elevation: 0,
                      backgroundColor: selectedSeats.length > 0 ? mainColor : Color(0xFFE4E4E4),
                      child: Icon(
                        Icons.arrow_forward,
                        color: selectedSeats.length > 0 ? Colors.white : Color(0xFFBEBEBE),
                      ),
                      onPressed: selectedSeats.length > 0
                          ? () {
                              context.bloc<PageBloc>().add(
                                  GoToCheckoutPage(widget.ticket.copyWith(seats: selectedSeats)));
                            }
                          : null,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Column generateSeats() {
    List<int> numberofSeats = [3, 5, 5, 5, 5];
    List<Widget> widgets = [];

    for (int i = 0; i < numberofSeats.length; i++) {
      widgets.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              numberofSeats[i],
              (index) => Padding(
                  padding:
                      EdgeInsets.only(right: index < numberofSeats[i] - 1 ? 16 : 0, bottom: 16),
                  child: SelectableBox(
                    "${String.fromCharCode(i + 65)}${i + 1}",
                    height: 40,
                    width: 40,
                    textStyle: whiteNumberFont.copyWith(color: Colors.black),
                    isSelected:
                        selectedSeats.contains("${String.fromCharCode(i + 65)}${index + 1}"),
                    onTap: () {
                      String seatNumber = "${String.fromCharCode(i + 65)}${index + 1}";
                      setState(() {
                        if (selectedSeats.contains(seatNumber)) {
                          selectedSeats.remove(seatNumber);
                        } else {
                          selectedSeats.add(seatNumber);
                        }
                      });
                    },
                    isEnabled: index != 4,
                  )))));
    }

    return Column(
      children: widgets,
    );
  }
}
