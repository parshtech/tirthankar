class UnionData {
  int id;
  int linkid;
  String eRole;
  String mRole;
  String mAdd;
  String eAdd;
  String email;
  String mName;
  String eName;
  String other1;
  String other2;
  String mobile;
  String photourl;
  String lat;
  String long;

  UnionData(
      this.id,
      this.linkid,
      this.eRole,
      this.mRole,
      this.eAdd,
      this.email,
      this.mName,
      this.mAdd,
      this.other1,
      this.other2,
      this.eName,
      this.mobile,
      this.photourl,
      this.lat,
      this.long);

  factory UnionData.fromJson(dynamic json) {
    return UnionData(
        json['id'] as int,
        json['linkid'] as int,
        json['eRole'] as String,
        json['mRole'] as String,
        json['eAdd'] as String,
        json['email'] as String,
        json['mName'] as String,
        json['mAdd'] as String,
        json['other1'] as String,
        json['other2'] as String,
        json['eName'] as String,
        json['mobile'] as String,
        json['photourl'] as String,
        json['lat'] as String,
        json['long'] as String);
  }

  @override
  String toString() {
    return '{ ${this.id},${this.linkid}, ${this.eRole},${this.mRole}, ${this.eAdd}, ${this.email},  ${this.mName} , ${this.mAdd}, ${this.other1} , ${this.other2}, ${this.eName} , ${this.mobile} ,${this.photourl},${this.lat},${this.long} }';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'linkid': linkid,
      'eRole': eRole,
      'mRole': mRole,
      'eAdd': eAdd,
      'email': email,
      'mName': mName,
      'mAdd': mAdd,
      'other1': other1,
      'other2': other2,
      'eName': eName,
      'mobile': mobile,
      'photourl': photourl,
      'lat': lat,
      'long': long
    };
  }

  // ignore: missing_return
  UnionData? fromMap(Map<String, dynamic> map) {
    id = map['id'];
    linkid = map['linkid'];
    eRole = map['eRole'];
    mRole = map['mRole'];
    eAdd = map['eAdd'];
    email = map['email'];
    mName = map['mName'];
    mAdd = map['mAdd'];
    other1 = map['other1'];
    other2 = map['other2'];
    eName = map['eName'];
    mobile = map['mobile'];
    photourl = map['photourl'];
    lat = map['lat'];
    long = map['long'];
  }
}
