class SendInvoiceRequest {
  SendInvoiceRequestBody? data;

  SendInvoiceRequest({this.data});

  SendInvoiceRequest.fromJson(Map<String?, dynamic> json) {
    data = json['data'] != null ? new SendInvoiceRequestBody.fromJson(json['data']) : null;
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class SendInvoiceRequestBody {
  Master? master;
  List<Detail>? detail;

  SendInvoiceRequestBody({this.master, this.detail});

  SendInvoiceRequestBody.fromJson(Map<String?, dynamic> json) {
    master =
    json['master'] != null ? new Master.fromJson(json['master']) : null;
    if (json['detail'] != null) {
      detail = <Detail>[];
      json['detail'].forEach((v) {
        detail?.add(new Detail.fromJson(v));
      });
    }
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    if (this.master != null) {
      data['master'] = this.master?.toJson();
    }
    if (this.detail != null) {
      data['detail'] = this.detail?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Master {
  String? phone;
  String? fullName;
  String? date;
  String? address;
  String? dienGiai;
  String? maNt;
  int? tyGia;
  String? birthDay;

  Master(
      {this.phone,
        this.fullName,
        this.date,
        this.address,
        this.dienGiai,
        this.maNt,
        this.tyGia,this.birthDay});

  Master.fromJson(Map<String?, dynamic> json) {
    phone = json['phone'];
    fullName = json['fullName'];
    date = json['date'];
    address = json['address'];
    dienGiai = json['dien_giai'];
    maNt = json['ma_nt'];
    tyGia = json['ty_gia'];
    birthDay = json['birthDay'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['phone'] = this.phone;
    data['fullName'] = this.fullName;
    data['date'] = this.date;
    data['address'] = this.address;
    data['dien_giai'] = this.dienGiai;
    data['ma_nt'] = this.maNt;
    data['ty_gia'] = this.tyGia;
    data['birthDay'] = this.birthDay;
    return data;
  }
}

class Detail {
  int? soLuong;
  num? gia;
  num? tlCk;
  String? maVt;
  String? maKho;

  Detail({this.soLuong, this.gia, this.tlCk, this.maVt, this.maKho});

  Detail.fromJson(Map<String?, dynamic> json) {
    soLuong = json['so_luong'];
    gia = json['gia_nt2'];
    tlCk = json['tl_ck'];
    maVt = json['ma_vt'];
    maKho = json['ma_kho'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['so_luong'] = this.soLuong;
    data['gia_nt2'] = this.gia;
    data['tl_ck'] = this.tlCk;
    data['ma_vt'] = this.maVt;
    data['ma_kho'] = this.maKho;
    return data;
  }
}

