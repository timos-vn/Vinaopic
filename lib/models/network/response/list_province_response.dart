class ListProvinceResponse {
  List<ListProvinceResponseData>? data;
  int? totalPage;
  int? statusCode;
  String? message;

  ListProvinceResponse(
      {this.data, this.totalPage, this.statusCode, this.message});

  ListProvinceResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ListProvinceResponseData>[];
      json['data'].forEach((v) {
        data!.add(new ListProvinceResponseData.fromJson(v));
      });
    }
    totalPage = json['totalPage'];
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['totalPage'] = this.totalPage;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class ListProvinceResponseData {
  String? maTinh;
  String? tenTinh;
  String? tenTinh2;

  ListProvinceResponseData({this.maTinh, this.tenTinh, this.tenTinh2});

  ListProvinceResponseData.fromJson(Map<String, dynamic> json) {
    maTinh = json['ma_tinh'];
    tenTinh = json['ten_tinh'];
    tenTinh2 = json['ten_tinh2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ma_tinh'] = this.maTinh;
    data['ten_tinh'] = this.tenTinh;
    data['ten_tinh2'] = this.tenTinh2;
    return data;
  }
}

