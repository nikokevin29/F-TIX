part of 'models.dart';

class Promo extends Equatable {
  final String title;
  final String subtitle;
  final int discount;

  Promo({@required this.title, @required this.subtitle, @required this.discount});

  @override
  List<Object> get props => [title, subtitle, discount];
}

List<Promo> dummyPromo = [
  Promo(title: "Family Sur", subtitle: "Maximum 3 People", discount: 30),
  Promo(title: "Holiday Started", subtitle: "For 1 year Member Only", discount: 100),
  Promo(title: "Subscribe Promo", subtitle: "Minimal 6 month", discount: 10),
];
