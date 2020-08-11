part of 'pages.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;
  MovieDetailPage(this.movie);

  @override
  Widget build(BuildContext context) {
    MovieDetail movieDetail;
    List<Credit> credits;
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              color: accentColor1,
            ),
            SafeArea(
                child: Container(
              color: Colors.white,
            )),
            ListView(
              children: <Widget>[
                FutureBuilder(
                  future: MovieServices.getDetails(movie),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      movieDetail = snapshot.data;
                    }
                    return Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            // NOTE : BACK DROP
                            Container(
                              height: 270,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          imageBaseURL + "w1280" + movie.backdropPath ??
                                              movie.posterPath),
                                      fit: BoxFit.cover)),
                            ),
                            Container(
                              height: 271,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment(0, 1),
                                      end: Alignment(0, 0.05),
                                      colors: [Colors.white, Colors.white.withOpacity(0)])),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: defaultMargin,
                                top: 20,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.black.withOpacity(0.04)),
                              child: GestureDetector(
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  context.bloc<PageBloc>().add(GoToMainPage());
                                },
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(defaultMargin, 16, defaultMargin, 6),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              //Title
                              Text(
                                movie.title,
                                style: blackTextFont.copyWith(
                                    fontWeight: FontWeight.w300, fontSize: 24),
                              ),
                              //Genre
                              (snapshot.hasData)
                                  //Jika ada Akan Ditampilkan
                                  ? Text(movieDetail.genresAndLanguage,
                                      style: greyTextFont.copyWith(
                                          fontSize: 12, fontWeight: FontWeight.w300))
                                  //Jika Kosong maka SpinKit
                                  : SizedBox(
                                      height: 50,
                                      child: SpinKitFadingCircle(
                                        color: accentColor3,
                                      ),
                                    ),
                              SizedBox(
                                height: 5,
                              ),
                              //Rating Star
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RatingStars(
                                    voteAverage: movie.voteAverage,
                                    color: accentColor3,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  child: Text(
                                    "Cast & Crew",
                                    style: blackTextFont.copyWith(fontSize: 14),
                                  ),
                                  margin: EdgeInsets.only(left: defaultMargin, bottom: 12),
                                ),
                              ),
                              FutureBuilder(
                                future: MovieServices.getCredits(movie.id),
                                builder: (_, snapshot) {
                                  if (snapshot.hasData) {
                                    credits = snapshot.data;
                                    return SizedBox(
                                      height: 115,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: credits.length,
                                          itemBuilder: (_, index) => Container(
                                              margin: EdgeInsets.only(
                                                  left: (index == 0) ? defaultMargin : 0,
                                                  right: (index == credits.length - 1)
                                                      ? defaultMargin
                                                      : 16),
                                              child: CreditCard(credits[index]))),
                                    );
                                  } else {
                                    return SizedBox(
                                      height: 50,
                                      child: SpinKitFadingCircle(
                                        color: accentColor1,
                                      ),
                                    );
                                  }
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  child: Text(
                                    "Storyline",
                                    style: blackTextFont.copyWith(fontSize: 14),
                                  ),
                                  margin: EdgeInsets.only(left: defaultMargin, bottom: 12),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 30),
                                child: Text(
                                  movie.overview,
                                  style: greyTextFont.copyWith(fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  color: mainColor,
                                  child: Text(
                                    "Continue to Book",
                                    style: whiteTextFont.copyWith(fontSize: 16),
                                  ),
                                  onPressed: () {
                                    context
                                        .bloc<PageBloc>()
                                        .add(GoToSelectScedulePage(movieDetail));
                                  }),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
