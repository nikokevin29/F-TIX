part of 'widgets.dart';

class PromoCard extends StatelessWidget {
  final Promo promo;

  PromoCard(this.promo);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    promo.title,
                    style: whiteTextFont.copyWith(fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                  Text(
                    promo.subtitle,
                    style: greyTextFont.copyWith(fontSize: 11, fontWeight: FontWeight.w300),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    "OFF ",
                    style: yellowNumberFont.copyWith(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${promo.discount}%",
                    style: yellowNumberFont.copyWith(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        ShaderMask(
            shaderCallback: (rectangle) {
              return LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [Colors.black.withOpacity(0.1), Colors.transparent])
                  .createShader(Rect.fromLTRB(0, 0, 75, 80));
            },
            blendMode: BlendMode.dstIn,
            child: SizedBox(
              height: 80,
              width: 75,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                child: Image.asset("assets/reflection2.png"),
              ),
            ))
      ],
    );
  }
}
