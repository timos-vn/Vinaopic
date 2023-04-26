class OrderHistoryResponse {
  List<OrderHistoryResponseData>? data;
  int? statusCode;
  String? message;

  OrderHistoryResponse({this.data, this.statusCode, this.message});

  OrderHistoryResponse.fromJson(Map<String?, dynamic> json) {
    if (json['data'] != null) {
      data = <OrderHistoryResponseData>[];
      json['data'].forEach((v) {
        data?.add(new OrderHistoryResponseData.fromJson(v));
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

class OrderHistoryResponseData {
  String? sttRec;
  String? maKh;
  String? tenKh;
  String? dienThoai;
  String? diaChi;
  String? tenBs;
  String? dienGiai;
  String? ngayCt;

  OrderHistoryResponseData(
      {this.sttRec,
        this.maKh,
        this.tenKh,
        this.dienThoai,
        this.diaChi,
        this.tenBs,
        this.dienGiai,
        this.ngayCt});

  OrderHistoryResponseData.fromJson(Map<String?, dynamic> json) {
    sttRec = json['stt_rec'];
    maKh = json['ma_kh'];
    tenKh = json['ten_kh'];
    dienThoai = json['dien_thoai'];
    diaChi = json['dia_chi'];
    tenBs = json['ten_bs'];
    dienGiai = json['dien_giai'];
    ngayCt = json['ngay_ct'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['stt_rec'] = this.sttRec;
    data['ma_kh'] = this.maKh;
    data['ten_kh'] = this.tenKh;
    data['dien_thoai'] = this.dienThoai;
    data['dia_chi'] = this.diaChi;
    data['ten_bs'] = this.tenBs;
    data['dien_giai'] = this.dienGiai;
    data['ngay_ct'] = this.ngayCt;
    return data;
  }
}

