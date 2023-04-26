class CreatesMakeAppointmentRequestBody {
  String? phoneNumber;
  String? fullName;
  String? date;
  int? sex;
  int? userId;
  String? address;
  String? birthDay;
  String? unit;
  String? store;
  String? dienGiai;
  String? status;
  int? traPhi;
  String? email;
  String? image;

  String? idProvince;
  String? idDistrict;
  String? idCommune;

  CreatesMakeAppointmentRequestBody({this.phoneNumber, this.fullName, this.date,
    this.sex,this.userId, this.address,this.birthDay,this.unit, this.store,this.dienGiai,
    this.status,this.traPhi,this.email,this.image,
    this.idProvince,this.idDistrict,this.idCommune
  });

  CreatesMakeAppointmentRequestBody.fromJson(Map<String?, dynamic> json) {
    phoneNumber = json['phone'];
    fullName = json['fullName'];
    date = json['date'];
    sex = json['sex'];userId = json['user_id'];
    address = json['address'];
    birthDay = json['birthDay'];
    dienGiai = json['dien_giai'];
    unit = json['unit'];
    store = json['store'];
    status = json['status'];
    traPhi = json['cp_yn'];
    email = json['e_mail'];
    image = json['image'];

    idProvince = json['idProvince'];
    idDistrict = json['idDistrict'];
    idCommune = json['idCommune'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['phone'] = this.phoneNumber;
    data['fullName'] = this.fullName;
    data['date'] = this.date;
    data['sex'] = this.sex;
    data['user_id'] = this.userId;
    data['address'] = this.address;
    data['birthDay'] = this.birthDay;
    data['dien_giai'] = this.dienGiai;
    data['unit'] = this.unit;
    data['store'] = this.store;
    data['status'] = this.status;
    data['cp_yn'] = this.traPhi;
    data['e_mail'] = this.email;
    data['image'] = this.image;

    data['idProvince'] = this.idProvince;
    data['idDistrict'] = this.idDistrict;
    data['idCommune'] = this.idCommune;
    return data;
  }
}
