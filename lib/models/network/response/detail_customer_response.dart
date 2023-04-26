class DetailCustomerResponse {
  DetailCustomerResponseData? data;
  int? statusCode;
  String? message;

  DetailCustomerResponse({this.data, this.statusCode, this.message});

  DetailCustomerResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DetailCustomerResponseData.fromJson(json['data']) : null;
    statusCode = json['status_code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class DetailCustomerResponseData {
  MainInfo? mainInfo;
  List<HdlHistory>? hdlHistory;

  DetailCustomerResponseData({this.mainInfo, this.hdlHistory});

  DetailCustomerResponseData.fromJson(Map<String, dynamic> json) {
    mainInfo = json['mainInfo'] != null
        ? new MainInfo.fromJson(json['mainInfo'])
        : null;
    if (json['hdlHistory'] != null) {
      hdlHistory = <HdlHistory>[];
      json['hdlHistory'].forEach((v) {
        hdlHistory?.add(new HdlHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mainInfo != null) {
      data['mainInfo'] = this.mainInfo?.toJson();
    }
    if (this.hdlHistory != null) {
      data['hdlHistory'] = this.hdlHistory?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MainInfo {
  String? maKh;
  String? tenKh;
  String? dienThoai;
  int? gioiTinh;
  String? diaChi;
  String? email;
  String? ngaySinh;
  String? avatar;
  int? status;

  MainInfo(
      {this.maKh,
        this.tenKh,
        this.dienThoai,
        this.gioiTinh,
        this.diaChi,
        this.email,
        this.ngaySinh,
        this.avatar,
        this.status});

  MainInfo.fromJson(Map<String, dynamic> json) {
    maKh = json['ma_kh'];
    tenKh = json['ten_kh'];
    dienThoai = json['dien_thoai'];
    gioiTinh = json['gioi_tinh'];
    diaChi = json['dia_chi'];
    email = json['email'];
    ngaySinh = json['ngay_sinh'];
    avatar = json['avatar'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ma_kh'] = this.maKh;
    data['ten_kh'] = this.tenKh;
    data['dien_thoai'] = this.dienThoai;
    data['gioi_tinh'] = this.gioiTinh;
    data['dia_chi'] = this.diaChi;
    data['email'] = this.email;
    data['ngay_sinh'] = this.ngaySinh;
    data['avatar'] = this.avatar;
    data['status'] = this.status;
    return data;
  }
}

class HdlHistory {
  int? stt;
  String? sttRec;
  String? maKh;
  String? ngayCt;
  String? soCt;
  String? noiDung;
  String? ghiChu;
  String? statusName;
  String? tenNV;

  HdlHistory(
      {this.stt, this.sttRec, this.maKh, this.ngayCt, this.soCt, this.noiDung,this.ghiChu,this.statusName,this.tenNV});

  HdlHistory.fromJson(Map<String, dynamic> json) {
    stt = json['stt'];
    sttRec = json['stt_rec'];
    maKh = json['ma_kh'];
    ngayCt = json['ngay_ct'];
    soCt = json['so_ct'];
    noiDung = json['noi_dung'];

    statusName = json['statusname'];
    ghiChu = json['ghi_chu_sc'];
    tenNV = json['ten_nv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stt'] = this.stt;
    data['stt_rec'] = this.sttRec;
    data['ma_kh'] = this.maKh;
    data['ngay_ct'] = this.ngayCt;
    data['so_ct'] = this.soCt;
    data['noi_dung'] = this.noiDung;

    data['ghi_chu_sc'] = this.ghiChu;
    data['statusname'] = this.statusName;
    data['ten_nv'] = this.tenNV;
    return data;
  }
}

