part of 'models.dart';

class Theater extends Equatable {
  final String name;
  final String address;
  Theater(this.name, this.address);
  @override
  List<Object> get props => [name, address];
}

List<Theater> dummyTheaters = [
  Theater("Jogja City XXI",
      "Jogja City Mall, Jl. Magelang No.KM. 6 No. 18, Kutu Patran, Sinduadi, Kec. Mlati, Kabupaten Sleman, Daerah Istimewa Yogyakarta 55284"),
  Theater("CGV Cinemas - Hartono Mall",
      "Hartono Mall, Jl. Ring Road Utara Jl. Kaliwaru, Kaliwaru, Condongcatur, Depok Sub-District, Sleman Regency, Special Region of Yogyakarta 55283"),
  Theater("CGV Cinemas Jwalk Mall",
      "J-Walk Mall, Jl. Babarsari No.2, Janti, Caturtunggal, Kec. Depok, Kabupaten Sleman, Daerah Istimewa Yogyakarta 55281"),
  Theater("Ambarrukmo XXI",
      "Plaza Ambarrukmo Lantai 3, Jl. Laksda Adisucipto No.KM 6.5, Ambarukmo, Caturtunggal, Kec. Depok, Kabupaten Sleman, Daerah Istimewa Yogyakarta 55281"),
  Theater("Cinépolis Lippo Plaza Jogja",
      "Lippo Plaza Lt 1 dan 4, Jl. Laksda Adisucipto No.32-34, RT.13/RW.4, Demangan, Kec. Gondokusuman, Kota Yogyakarta, Daerah Istimewa Yogyakarta 55221"),
];
