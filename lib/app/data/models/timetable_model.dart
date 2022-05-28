class Timetable {
  Lectures? lectures;

  Timetable({this.lectures});

  Timetable.fromJson(Map<String, dynamic> json) {
    lectures =
        json['lectures'] != null ? Lectures?.fromJson(json['lectures']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (lectures != null) {
      data['lectures'] = lectures?.toJson();
    }
    return data;
  }
}

class Lectures {
  MonToThurs? monToThurs;
  MonToThurs? fri;

  Lectures({this.monToThurs, this.fri});

  Lectures.fromJson(Map<String, dynamic> json) {
    monToThurs = json['monToThurs'] != null
        ? MonToThurs?.fromJson(json['monToThurs'])
        : null;
    fri = json['fri'] != null ? MonToThurs?.fromJson(json['fri']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (monToThurs != null) {
      data['monToThurs'] = monToThurs?.toJson();
    }
    if (fri != null) {
      data['fri'] = fri?.toJson();
    }
    return data;
  }
}

class MonToThurs {
  String? s1;
  String? s2;
  String? s3;
  String? s4;
  String? s5;

  MonToThurs({this.s1, this.s2, this.s3, this.s4, this.s5});

  MonToThurs.fromJson(Map<String, dynamic> json) {
    s1 = json['1'];
    s2 = json['2'];
    s3 = json['3'];
    s4 = json['4'];
    s5 = json['5'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['1'] = s1;
    data['2'] = s2;
    data['3'] = s3;
    data['4'] = s4;
    data['5'] = s5;
    return data;
  }
}
