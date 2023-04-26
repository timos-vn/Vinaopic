class ListCommuneResponse {
  List<ListCommuneResponseData>? data;
  int? totalPage;
  int? statusCode;
  String? message;

  ListCommuneResponse(
      {this.data, this.totalPage, this.statusCode, this.message});

  ListCommuneResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ListCommuneResponseData>[];
      json['data'].forEach((v) {
        data!.add(new ListCommuneResponseData.fromJson(v));
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

class ListCommuneResponseData {
  String? maPhuong;
  String? tenPhuong;
  String? tenPhuong2;

  ListCommuneResponseData({this.maPhuong, this.tenPhuong, this.tenPhuong2});

  ListCommuneResponseData.fromJson(Map<String, dynamic> json) {
    maPhuong = json['ma_phuong'];
    tenPhuong = json['ten_phuong'];
    tenPhuong2 = json['ten_phuong2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ma_phuong'] = this.maPhuong;
    data['ten_phuong'] = this.tenPhuong;
    data['ten_phuong2'] = this.tenPhuong2;
    return data;
  }
}

