class ListDistrictResponse {
  List<ListDistrictResponseData>? data;
  int? totalPage;
  int? statusCode;
  String? message;

  ListDistrictResponse(
      {this.data, this.totalPage, this.statusCode, this.message});

  ListDistrictResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ListDistrictResponseData>[];
      json['data'].forEach((v) {
        data!.add( ListDistrictResponseData.fromJson(v));
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

class ListDistrictResponseData {
  String? maQuan;
  String? tenQuan;
  String? tenQuan2;

  ListDistrictResponseData({this.maQuan, this.tenQuan, this.tenQuan2});

  ListDistrictResponseData.fromJson(Map<String, dynamic> json) {
    maQuan = json['ma_quan'];
    tenQuan = json['ten_quan'];
    tenQuan2 = json['ten_quan2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ma_quan'] = this.maQuan;
    data['ten_quan'] = this.tenQuan;
    data['ten_quan2'] = this.tenQuan2;
    return data;
  }
}

