class Mahasiswa {
  int id;
  String Name;
  String BirthPlace;
  String Gender;
  String Religion;
  String RegEmail;
  String HpNumber;

  Mahasiswa(
      {this.id,
      this.Name,
      this.BirthPlace,
      this.Gender,
      this.Religion,
      this.RegEmail,
      this.HpNumber});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['Name'] = Name;
    map['BirthPlace'] = BirthPlace;
    map['Gender'] = Gender;
    map['Religion'] = Religion;
    map['RegEmail'] = RegEmail;
    map['HpNumber'] = HpNumber;
    return map;
  }

  Mahasiswa.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.Name = map['Name'];
    this.BirthPlace = map['BirthPlace'];
    this.Gender = map['Gender'];
    this.Religion = map['Religion'];
    this.RegEmail = map['RegEmail'];
    this.HpNumber = map['HpNumber'];
  }
}
