class InfoStoreResponse{
  int? statusCode;
  String? message;
  List<InfoStoreResponseData>? stores;

  InfoStoreResponse({this.statusCode,this.message,this.stores});

  InfoStoreResponse.fromJson(Map<String?, dynamic> json) {
    if (json['stores'] != null) {
      stores = <InfoStoreResponseData>[];(json['stores'] as List).forEach((v) { stores?.add(new InfoStoreResponseData.fromJson(v)); });
    }
    statusCode = json['statusCode'];
    message = json['message'];

  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    if (this.stores != null) {
      data['stores'] =  this.stores?.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class InfoStoreResponseData{
  String? storeId;
  String? storeName;

  InfoStoreResponseData({this.storeId,this.storeName});

  InfoStoreResponseData.fromJson(Map<String?, dynamic> json) {
    storeId = json['storeId'];
    storeName = json['storeName'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['storeId'] = this.storeId;
    data['storeName'] = this.storeName;
    return data;
  }
}