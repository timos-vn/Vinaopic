class GetDetailOrderCustomerResponse {
  List<GetDetailOrderCustomerResponseData>? data;
  int? statusCode;
  String? message;

  GetDetailOrderCustomerResponse({this.data, this.statusCode, this.message});

  GetDetailOrderCustomerResponse.fromJson(Map<String?, dynamic> json) {
    if (json['data'] != null) {
      data = <GetDetailOrderCustomerResponseData>[];
      json['data'].forEach((v) {
        data?.add(new GetDetailOrderCustomerResponseData.fromJson(v));
      });
    }
    statusCode = json['status_code'];
    message = json['message'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class GetDetailOrderCustomerResponseData {
  String? maVt;
  String? dvt;
  int? soLuong;
  int? giaNt2;
  int? tienNt2;
  int? ckNt;
  String? maKho;
  String? tenVt;

  GetDetailOrderCustomerResponseData(
      {this.maVt,
        this.dvt,
        this.soLuong,
        this.giaNt2,
        this.tienNt2,
        this.ckNt,
        this.maKho,
        this.tenVt});

  GetDetailOrderCustomerResponseData.fromJson(Map<String?, dynamic> json) {
    maVt = json['ma_vt'];
    dvt = json['dvt'];
    soLuong = json['so_luong'];
    giaNt2 = json['gia_nt2'];
    tienNt2 = json['tien_nt2'];
    ckNt = json['ck_nt'];
    maKho = json['ma_kho'];
    tenVt = json['ten_vt'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['ma_vt'] = this.maVt;
    data['dvt'] = this.dvt;
    data['so_luong'] = this.soLuong;
    data['gia_nt2'] = this.giaNt2;
    data['tien_nt2'] = this.tienNt2;
    data['ck_nt'] = this.ckNt;
    data['ma_kho'] = this.maKho;
    data['ten_vt'] = this.tenVt;
    return data;
  }
}

