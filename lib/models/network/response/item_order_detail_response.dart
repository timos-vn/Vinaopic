class ItemOrderDetailResponse {
  ItemOrderDetailResponseData? data;
  int? statusCode;
  String? message;

  ItemOrderDetailResponse({this.data, this.statusCode, this.message});

  ItemOrderDetailResponse.fromJson(Map<String?, dynamic> json) {
    data = json['data'] != null ? new ItemOrderDetailResponseData.fromJson(json['data']) : null;
    statusCode = json['status_code'];
    message = json['message'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class ItemOrderDetailResponseData {
  List<Master>? master;
  List<Detail>? detail;

  ItemOrderDetailResponseData({this.master, this.detail});

  ItemOrderDetailResponseData.fromJson(Map<String?, dynamic> json) {
    if (json['master'] != null) {
      master = <Master>[];
      json['master'].forEach((v) {
        master?.add(new Master.fromJson(v));
      });
    }
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
      data['master'] = this.master?.map((v) => v.toJson()).toList();
    }
    if (this.detail != null) {
      data['detail'] = this.detail?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Master {
  String? sttRec;
  String? soCt;
  String? ngayCt;
  String? maKh;
  String? tenKh;
  String? dienThoai;

  Master(
      {this.sttRec,
        this.soCt,
        this.ngayCt,
        this.maKh,
        this.tenKh,
        this.dienThoai});

  Master.fromJson(Map<String?, dynamic> json) {
    sttRec = json['stt_rec'];
    soCt = json['so_ct'];
    ngayCt = json['ngay_ct'];
    maKh = json['ma_kh'];
    tenKh = json['ten_kh'];
    dienThoai = json['dien_thoai'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['stt_rec'] = this.sttRec;
    data['so_ct'] = this.soCt;
    data['ngay_ct'] = this.ngayCt;
    data['ma_kh'] = this.maKh;
    data['ten_kh'] = this.tenKh;
    data['dien_thoai'] = this.dienThoai;
    return data;
  }
}

class Detail {
  String? maVt;
  String? dvt;
  num? soLuong;
  num? giaNt2;
  num? tienNt2;
  num? tlCk;
  num? ckNt;
  String? maKho;
  String? tenVt;
  String? nuocSx;

  Detail(
      {this.maVt,
        this.dvt,
        this.soLuong,
        this.giaNt2,
        this.tienNt2,
        this.tlCk,
        this.ckNt,
        this.maKho,
        this.tenVt,
        this.nuocSx});

  Detail.fromJson(Map<String?, dynamic> json) {
    maVt = json['ma_vt'];
    dvt = json['dvt'];
    soLuong = json['so_luong'];
    giaNt2 = json['gia_nt2'];
    tienNt2 = json['tien_nt2'];
    tlCk = json['tl_ck'];
    ckNt = json['ck_nt'];
    maKho = json['ma_kho'];
    tenVt = json['ten_vt'];
    nuocSx = json['nuoc_sx'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['ma_vt'] = this.maVt;
    data['dvt'] = this.dvt;
    data['so_luong'] = this.soLuong;
    data['gia_nt2'] = this.giaNt2;
    data['tien_nt2'] = this.tienNt2;
    data['tl_ck'] = this.tlCk;
    data['ck_nt'] = this.ckNt;
    data['ma_kho'] = this.maKho;
    data['ten_vt'] = this.tenVt;
    data['nuoc_sx'] = this.nuocSx;
    return data;
  }
}

