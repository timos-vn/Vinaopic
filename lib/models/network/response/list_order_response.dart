class OrderResponse {
  List<OrderResponseData>? data;
  int? statusCode;
  String? message;

  OrderResponse({this.data, this.statusCode, this.message});

  OrderResponse.fromJson(Map<String?, dynamic> json) {
    if (json['data'] != null) {
      data = <OrderResponseData>[];
      json['data'].forEach((v) {
        data?.add(new OrderResponseData.fromJson(v));
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

class OrderResponseData {
  String? sttRec;
  String? maKh;
  String? tenKh;
  String? dienThoai;
  String? diaChi;
  String? tenBs;
  String? ngaySinh;
  int? age;
  int? gioiTinh;
  String? email;
  String? ngayCt;
  String? dienGiai;
  String? nguoiTao;
  int? dataType;

  OrderResponseData(
      {this.sttRec,
        this.maKh,
        this.tenKh,
        this.dienThoai,
        this.diaChi,
        this.tenBs,
        this.ngaySinh,
        this.age,
        this.gioiTinh,
        this.email,
        this.ngayCt,
        this.dienGiai,
        this.nguoiTao,this.dataType});

  OrderResponseData.fromJson(Map<String?, dynamic> json) {
    sttRec = json['stt_rec'];
    maKh = json['ma_kh'];
    tenKh = json['ten_kh'];
    dienThoai = json['dien_thoai'];
    diaChi = json['dia_chi'];
    tenBs = json['ten_bs'];
    ngaySinh = json['ngay_sinh'];
    age = json['age'];
    gioiTinh = json['gioi_tinh'];
    email = json['email'];
    ngayCt = json['ngay_ct'];
    dienGiai = json['dien_giai'];
    nguoiTao = json['nguoi_tao'];
    dataType = json['data_type'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['stt_rec'] = this.sttRec;
    data['ma_kh'] = this.maKh;
    data['ten_kh'] = this.tenKh;
    data['dien_thoai'] = this.dienThoai;
    data['dia_chi'] = this.diaChi;
    data['ten_bs'] = this.tenBs;
    data['ngay_sinh'] = this.ngaySinh;
    data['age'] = this.age;
    data['gioi_tinh'] = this.gioiTinh;
    data['email'] = this.email;
    data['ngay_ct'] = this.ngayCt;
    data['dien_giai'] = this.dienGiai;
    data['nguoi_tao'] = this.nguoiTao;
    data['data_type'] = this.dataType;
    return data;
  }
}

