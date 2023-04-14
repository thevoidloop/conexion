class Option {
  final String optionName;

  Option({required this.optionName});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(optionName: json['OptionName']);
  }
}


