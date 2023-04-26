class GetListAwaitingCustomerResponse {
  List<GetListAwaitingCustomerResponseData>? data;
  int? statusCode;
  String? message;

  GetListAwaitingCustomerResponse({this.data, this.statusCode, this.message});

  GetListAwaitingCustomerResponse.fromJson(Map<String?, dynamic> json) {
    if (json['data'] != null) {
      data = <GetListAwaitingCustomerResponseData>[];
      json['data'].forEach((v) {
        data?.add(new GetListAwaitingCustomerResponseData.fromJson(v));
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

class GetListAwaitingCustomerResponseData {
  String? maKh;
  String? tenKh;
  String? statusname;

  GetListAwaitingCustomerResponseData({this.maKh, this.tenKh, this.statusname});

  GetListAwaitingCustomerResponseData.fromJson(Map<String?, dynamic> json) {
    maKh = json['ma_kh'];
    tenKh = json['ten_kh'];
    statusname = json['statusname'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['ma_kh'] = this.maKh;
    data['ten_kh'] = this.tenKh;
    data['statusname'] = this.statusname;
    return data;
  }
}

