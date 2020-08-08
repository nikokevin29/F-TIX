part of 'widgets.dart';

class BrowseButton extends StatelessWidget {
  final String genre;
  BrowseButton(this.genre);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: 70,
            height: 70,
            decoration:
                BoxDecoration(color: Colors.teal[50], borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 36,width: 36, child: Image(image: AssetImage(getGenre(genre)))),
                SizedBox(height: 5,),
                Text(genre),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getGenre(String genre) {
    switch (genre) {
      case "Horror":
        return "assets/ic_horror.png";//
        break;
      case "Music":
        return "assets/ic_music.png";//
        break;
      case "Action":
        return "assets/ic_action.png";//
        break;
      case "Drama":
        return "assets/ic_drama.png";//
        break;
      case "War":
        return "assets/ic_war.png";//
        break;
      case "Crime":
        return "assets/ic_crime.png";//
        break;
      default:
        return "";
    }
  }
}
