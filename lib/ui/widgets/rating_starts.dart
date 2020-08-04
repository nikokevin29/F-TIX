part of 'widgets.dart';

class RatingStars extends StatelessWidget {
  final double voteAverage;
  final double startSize;
  final double fontSize;
  RatingStars({this.voteAverage = 0, this.startSize = 20, this.fontSize = 12});
  @override
  Widget build(BuildContext context) {
    int n = (voteAverage / 2).round();//round untuk pembulatan bintang

    List<Widget> widgets = List.generate(
        5,
        (index) => Icon(
              index < n ? MdiIcons.star : MdiIcons.starOutline,
              color: accentColor2,
              size: startSize,
            ));

    widgets.add(SizedBox(
      width: 3,
    ));
    widgets.add(Text(
      '$voteAverage/10',
      style: whiteTextFont.copyWith(fontWeight: FontWeight.w300, fontSize: fontSize),
    ));

    return Row(
      children: widgets,
    );
  }
}
