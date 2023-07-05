class BusDetail {
  final String season;
  final String stationTypeA;
  final String stationTypeB;
  final Fee fee;
  final Time time;
  final String extra;

  BusDetail({
    this.season = "",
    this.stationTypeA = "",
    this.stationTypeB = "",
    this.fee =
        const Fee(amount: 0, paymentMethods: [], nonAcceptablePayments: []),
    this.time = const Time(
        duringSemester: DuringSemester(weekday: "", saturday: ""),
        duringVacation: DuringVacation(weekday: "", saturday: ""),
        operationDays: "",
        nonOperationDays: ""),
    this.extra = "",
  });

  factory BusDetail.fromJson(Map<String, dynamic> json) {
    return BusDetail(
      season: json['season'],
      stationTypeA: json['stationTypeA'],
      stationTypeB: json['stationTypeB'],
      fee: Fee.fromJson(json['fee']),
      time: Time.fromJson(json['time']),
      extra: json['extra'],
    );
  }
}

class Fee {
  final int amount;
  final List<String> paymentMethods;
  final List<String> nonAcceptablePayments;

  const Fee(
      {this.amount = 0,
      this.paymentMethods = const [],
      this.nonAcceptablePayments = const []});

  factory Fee.fromJson(Map<String, dynamic> json) {
    return Fee(
      amount: json['amount'],
      paymentMethods: List<String>.from(json['paymentMethods']),
      nonAcceptablePayments: List<String>.from(json['nonAcceptablePayments']),
    );
  }
}

class Time {
  final DuringSemester duringSemester;
  final DuringVacation duringVacation;
  final String operationDays;
  final String nonOperationDays;

  const Time({
    this.duringSemester = const DuringSemester(weekday: "", saturday: ""),
    this.duringVacation = const DuringVacation(weekday: "", saturday: ""),
    this.operationDays = "",
    this.nonOperationDays = "",
  });

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      duringSemester: DuringSemester.fromJson(json['duringSemester']),
      duringVacation: DuringVacation.fromJson(json['duringVacation']),
      operationDays: json['operationDays'],
      nonOperationDays: json['nonOperationDays'],
    );
  }
}

class DuringSemester {
  final String weekday;
  final String saturday;

  const DuringSemester({this.weekday = "", this.saturday = ""});

  factory DuringSemester.fromJson(Map<String, dynamic> json) {
    return DuringSemester(
      weekday: json['평일'],
      saturday: json['토요일'],
    );
  }
}

class DuringVacation {
  final String weekday;
  final String saturday;

  const DuringVacation({this.weekday = "", this.saturday = ""});

  factory DuringVacation.fromJson(Map<String, dynamic> json) {
    return DuringVacation(
      weekday: json['평일'],
      saturday: json['토요일'],
    );
  }
}
