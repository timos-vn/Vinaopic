class GetListBannerResponse {
  List<GetListBannerResponseData>? data;
  int? statusCode;
  String? message;

  GetListBannerResponse({this.data, this.statusCode, this.message});

  GetListBannerResponse.fromJson(Map<String?, dynamic> json) {
    if (json['data'] != null) {
      data = <GetListBannerResponseData>[];
      json['data'].forEach((v) {
        data?.add(new GetListBannerResponseData.fromJson(v));
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

class GetListBannerResponseData {
  int? type;
  String? tittle;
  String? body;
  String? imageUrl;

  GetListBannerResponseData({this.type, this.tittle, this.body, this.imageUrl});

  GetListBannerResponseData.fromJson(Map<String?, dynamic> json) {
    type = json['type'];
    tittle = json['tittle'];
    body = json['body'];
    imageUrl = json['imageUrl'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['type'] = this.type;
    data['tittle'] = this.tittle;
    data['body'] = this.body;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}

