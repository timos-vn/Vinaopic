class SearchProductResponse {
  List<SearchProductResponseData>? data;
  int? statusCode;
  String? message;

  SearchProductResponse({this.data, this.statusCode, this.message});

  SearchProductResponse.fromJson(Map<String?, dynamic> json) {
    if (json['data'] != null) {
      data = <SearchProductResponseData>[];
      json['data'].forEach((v) {
        data?.add(new SearchProductResponseData.fromJson(v));
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

class SearchProductResponseData {
  String? maVt;
  String? tenVt;
  String? imageUrl;

  SearchProductResponseData({this.maVt, this.tenVt, this.imageUrl});

  SearchProductResponseData.fromJson(Map<String?, dynamic> json) {
    maVt = json['ma_vt'];
    tenVt = json['ten_vt'];
    imageUrl = json['image_url'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['ma_vt'] = this.maVt;
    data['ten_vt'] = this.tenVt;
    data['image_url'] = this.imageUrl;
    return data;
  }
}

