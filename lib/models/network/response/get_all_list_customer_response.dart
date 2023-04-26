class GetAllListCustomerResponse {
  List<GetAllListCustomerResponseData>? data;
  int? statusCode;
  String? message;

  GetAllListCustomerResponse({this.data, this.statusCode, this.message});

  GetAllListCustomerResponse.fromJson(Map<String?, dynamic> json) {
    if (json['data'] != null) {
      data = <GetAllListCustomerResponseData>[];
      json['data'].forEach((v) {
        data?.add(new GetAllListCustomerResponseData.fromJson(v));
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

class GetAllListCustomerResponseData {
  String? maKh;
  String? tenKh;
  String? dienThoai;
  int? gioiTinh;
  String? diaChi;
  String? email;
  String? ngaySinh;
  String? avatar;

  GetAllListCustomerResponseData(
      {this.maKh,
        this.tenKh,
        this.dienThoai,
        this.gioiTinh,
        this.diaChi,
        this.email,
        this.ngaySinh,
        this.avatar});

  GetAllListCustomerResponseData.fromJson(Map<String?, dynamic> json) {
    maKh = json['ma_kh'];
    tenKh = json['ten_kh'];
    dienThoai = json['dien_thoai'];
    gioiTinh = json['gioi_tinh'];
    diaChi = json['dia_chi'];
    email = json['email'];
    ngaySinh = json['ngay_sinh'];
    avatar = json['avatar'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['ma_kh'] = this.maKh;
    data['ten_kh'] = this.tenKh;
    data['dien_thoai'] = this.dienThoai;
    data['gioi_tinh'] = this.gioiTinh;
    data['dia_chi'] = this.diaChi;
    data['email'] = this.email;
    data['ngay_sinh'] = this.ngaySinh;
    data['avatar'] = this.avatar;
    return data;
  }
}

