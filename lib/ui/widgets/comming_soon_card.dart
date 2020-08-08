part of 'widgets.dart';

class CommingSoonCard extends StatelessWidget {
  final Movie movie;
  final Function onTap;
  CommingSoonCard(this.movie, {this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: NetworkImage(imageBaseURL + "w780" + movie.posterPath), fit: BoxFit.fitHeight)),
      child: Container(
        height: 140,
        width: 100,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: <Color>[Colors.black.withOpacity(0.6), Colors.black.withOpacity(0)],
            )),
      ),
    );
  }
}
