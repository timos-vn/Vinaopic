class SearchCustomerResponse {
  List<SearchCustomerResponseData>? data;
  int? statusCode;
  String? message;

  SearchCustomerResponse({this.data, this.statusCode, this.message});

  SearchCustomerResponse.fromJson(Map<String?, dynamic> json) {
    if (json['data'] != null) {
      data = <SearchCustomerResponseData>[];
      json['data'].forEach((v) {
        data?.add(new SearchCustomerResponseData.fromJson(v));
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

class SearchCustomerResponseData {
  String? maKh;
  String? tenKh;
  String? dienThoai;
  int? sex;
  String? diaChi;
  String? ngaySinh;
  String? email;

  SearchCustomerResponseData({this.maKh, this.tenKh, this.dienThoai,this.sex,this.diaChi,this.ngaySinh,this.email});

  SearchCustomerResponseData.fromJson(Map<String?, dynamic> json) {
    maKh = json['ma_kh'];
    tenKh = json['ten_kh'];
    dienThoai = json['dien_thoai'];
    sex = json['gioi_tinh'];
    diaChi = json['dia_chi'];
    ngaySinh = json['ngay_sinh'];
    email = json['email'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['ma_kh'] = this.maKh;
    data['ten_kh'] = this.tenKh;
    data['dien_thoai'] = this.dienThoai;
    data['gioi_tinh'] = this.sex;
    data['dia_chi'] = this.diaChi;
    data['ngay_sinh'] = this.ngaySinh;
    data['email'] = this.email;
    return data;
  }
}

