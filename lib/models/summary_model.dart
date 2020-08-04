class SummaryOfCases {
  Global global;
  List<Countries> countries;
  String date;

  SummaryOfCases({this.global, this.countries, this.date});

  factory SummaryOfCases.fromJson(Map<String, dynamic> json) {
    return SummaryOfCases(
        global: Global.fromJson(json['Global']),
        countries: parsedCountries(json),
        date: json['Date']);
  }

  static List<Countries> parsedCountries(countriesJson) {
    var list = countriesJson['Countries'] as List;
    List<Countries> countriesList =
        list.map((data) => Countries.fromJson(data)).toList();
    return countriesList;
  }
}

class Global {
  int newConfirmed;
  int totalConfirmed;
  int newDeaths;
  int totalDeaths;
  int newRecovered;
  int totalRecovered;

  Global(
      {this.newConfirmed,
      this.totalConfirmed,
      this.newDeaths,
      this.totalDeaths,
      this.newRecovered,
      this.totalRecovered});

  factory Global.fromJson(Map<String, dynamic> json) {
    return Global(
        newConfirmed: json['NewConfirmed'],
        totalConfirmed: json['TotalConfirmed'],
        newDeaths: json['NewDeaths'],
        totalDeaths: json['TotalDeaths'],
        newRecovered: json['NewRecovered'],
        totalRecovered: json['TotalRecovered']);
  }
}

class Countries {
  String countryName;
  String countryCode;
  String slug;
  int newConfirmed;
  int totalConfirmed;
  int newDeaths;
  int totalDeaths;
  int newRecovered;
  int totalRecovered;
  String date;

  Countries(
      {this.countryName,
      this.countryCode,
      this.slug,
      this.newConfirmed,
      this.totalConfirmed,
      this.newDeaths,
      this.totalDeaths,
      this.newRecovered,
      this.totalRecovered,
      this.date});

  factory Countries.fromJson(Map<String, dynamic> parsedJson) {
    return Countries(
        countryName: parsedJson['Country'],
        countryCode: parsedJson['CountryCode'],
        slug: parsedJson['Slug'],
        newConfirmed: parsedJson['NewConfirmed'],
        totalConfirmed: parsedJson['TotalConfirmed'],
        newDeaths: parsedJson['NewDeaths'],
        totalDeaths: parsedJson['TotalDeaths'],
        newRecovered: parsedJson['NewRecovered'],
        totalRecovered: parsedJson['TotalRecovered'],
        date: parsedJson['Date']);
  }
}
