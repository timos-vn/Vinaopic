class ListDoctorResponse {
  List<ListDoctorResponseData>? data;
  int? statusCode;
  String? message;

  ListDoctorResponse({this.data, this.statusCode, this.message});

  ListDoctorResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ListDoctorResponseData>[];
      json['data'].forEach((v) {
        data?.add(new ListDoctorResponseData.fromJson(v));
      });
    }
    statusCode = json['status_code'];
    message = json['message'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class ListDoctorResponseData {
  String? maBs;
  String? tenBs;
  String? chuyenNganh;
  String? unit;
  String? store;
  String? congTac;
  String? avatar;

  ListDoctorResponseData(
      {this.maBs,
        this.tenBs,
        this.chuyenNganh,
        this.unit,
        this.store,
        this.congTac,
        this.avatar});

  ListDoctorResponseData.fromJson(Map<String?, dynamic> json) {
    maBs = json['ma_bs'];
    tenBs = json['ten_bs'];
    chuyenNganh = json['chuyen_nganh'];
    unit = json['unit'];
    store = json['store'];
    congTac = json['cong_tac'];
    avatar = json['avatar'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['ma_bs'] = this.maBs;
    data['ten_bs'] = this.tenBs;
    data['chuyen_nganh'] = this.chuyenNganh;
    data['unit'] = this.unit;
    data['store'] = this.store;
    data['cong_tac'] = this.congTac;
    data['avatar'] = this.avatar;
    return data;
  }
}