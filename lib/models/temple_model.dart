class TempleData {
  int id;
  String eTaluka;
  String mTaluka;
  String mAdd;
  String eAdd;
  String email;
  String mName;
  String eName;
  String other1;
  String other2;
  String mobile;
  String photourl;
  String eState;
  String mState;
  String eDist;
  String mDist;
  String pincode;
  String rooms;
  String pahad;
  String food;
  String lat;
  String long;

  TempleData(
      this.id,
      this.eTaluka,
      this.mTaluka,
      this.eAdd,
      this.email,
      this.mName,
      this.mAdd,
      this.other1,
      this.other2,
      this.eName,
      this.mobile,
      this.photourl,
      this.eState,
      this.mState,
      this.eDist,
      this.mDist,
      this.pincode,
      this.rooms,
      this.pahad,
      this.food,
      this.lat,
      this.long);

  factory TempleData.fromJson(dynamic json) {
    return TempleData(
        json['id'] as int,
        json['eTaluka'] as String,
        json['mTaluka'] as String,
        json['eAdd'] as String,
        json['email'] as String,
        json['mName'] as String,
        json['mAdd'] as String,
        json['other1'] as String,
        json['other2'] as String,
        json['eName'] as String,
        json['mobile'] as String,
        json['photourl'] as String,
        json['eState'] as String,
        json['mState'] as String,
        json['eDist'] as String,
        json['mDist'] as String,
        json['pincode'] as String,
        json['rooms'] as String,
        json['pahad'] as String,
        json['food'] as String,
        json['lat'] as String,
        json['long'] as String);
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.eTaluka},${this.mTaluka}, ${this.eAdd}, ${this.email},  ${this.mName} , ${this.mAdd}, ${this.other1} , ${this.other2}, ${this.eName} , ${this.mobile} ,${this.photourl},${this.eState},${this.mState},${this.eDist},${this.mDist},${this.pincode},${this.rooms},${this.pahad},${this.food},${this.lat},${this.long} }';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eTaluka': eTaluka,
      'mTaluka': mTaluka,
      'eAdd': eAdd,
      'email': email,
      'mName': mName,
      'mAdd': mAdd,
      'other1': other1,
      'other2': other2,
      'eName': eName,
      'mobile': mobile,
      'photourl': photourl,
      'eState': eState,
      'mState': mState,
      'eDist': eDist,
      'mDist': mDist,
      'pincode': pincode,
      'rooms': rooms,
      'pahad': pahad,
      'food': food,
      'lat': lat,
      'long': long
    };
  }

  TempleData? fromMap(Map<String, dynamic> map) {
    id = map['id'];

    eTaluka = map['eTaluka'];
    mTaluka = map['mTaluka'];
    eAdd = map['eAdd'];
    email = map['email'];
    mName = map['mName'];
    mAdd = map['mAdd'];
    other1 = map['other1'];
    other2 = map['other2'];
    eName = map['eName'];
    mobile = map['mobile'];
    photourl = map['photourl'];
    eState = map['eState'];
    mState = map['mState'];
    eDist = map['eDist'];
    mDist = map['mDist'];
    pincode = map['pincode'];
    rooms = map['rooms'];
    pahad = map['pahad'];
    food = map['food'];
    lat = map['lat'];
    long = map['long'];
  }
}
