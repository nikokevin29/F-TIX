part of 'pages.dart';

class PreferencePage extends StatefulWidget {
  final List<String> genres = ["Horror", "Musical", "Action", "War", "Crime", "Drama"];
  final List<String> languages = ["Bahasa", "English", "Japanese", "Javanese"];
  final RegistrationData registrationData;
  PreferencePage(this.registrationData);
  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  List<String> selectedGenres = [];
  String selectedLanguage = "English";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.registrationData.password = "";
        context.bloc<PageBloc>().add(GoToRegistrationPage(widget.registrationData));

        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 56,
                    margin: EdgeInsets.only(top: 20, bottom: 4),
                    child: GestureDetector(
                        onTap: () {
                          widget.registrationData.password = "";
                          context
                              .bloc<PageBloc>()
                              .add(GoToRegistrationPage(widget.registrationData));
                        },
                        child: Icon(Icons.arrow_back)),
                  ),
                  Text(
                    "Select Your Four\nFavourite Genres",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Wrap(spacing: 24, runSpacing: 24, children: genreWidgets(context)),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Movie Language\nYou Prefer?",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: languageWidgets(context),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                      child: FloatingActionButton(
                          elevation: 0,
                          backgroundColor: mainColor,
                          child: Icon(Icons.arrow_forward),
                          onPressed: () {
                            if (selectedGenres.length != 4) {
                              Flushbar(
                                duration: Duration(seconds: 2),
                                flushbarPosition: FlushbarPosition.TOP,
                                backgroundColor: Color(0xFFFF5C83),
                                message: "Please Select 4 Genre",
                              )..show(context);
                            } else {
                              widget.registrationData.selectedGenres = selectedGenres;
                              widget.registrationData.selectedLanguage = selectedLanguage;

                              context
                                  .bloc<PageBloc>()
                                  .add(GoToAccountConfirmationPage(widget.registrationData));
                            }
                          })),
                  SizedBox(
                    height: 40,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> languageWidgets(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    return widget.languages
        .map((e) => SelectableBox(
              e,
              width: width,
              isSelected: selectedLanguage == e,
              onTap: () {
                setState(() {
                  selectedLanguage = e;
                });
              },
            ))
        .toList();
  }

  List<Widget> genreWidgets(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    return widget.genres
        .map((e) => SelectableBox(
              e,
              width: width,
              isSelected: selectedGenres.contains(e),
              onTap: () {
                onSelectGenre(e);
              },
            ))
        .toList();
  }

  void onSelectGenre(String genre) {
    if (selectedGenres.contains(genre)) {
      setState(() {
        selectedGenres.remove(genre);
      });
    } else {
      if (selectedGenres.length < 4) {
        setState(() {
          selectedGenres.add(genre);
        });
      }
    }
  }
}
