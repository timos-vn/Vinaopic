class DoctorRequestBody {
  int? pageIndex;
  int? pageCount;
  String? units;
  int? userId;

  DoctorRequestBody({this.pageIndex, this.pageCount,this.units,this.userId});

  DoctorRequestBody.fromJson(Map<String, dynamic> json) {
    pageIndex = json['page_index'];
    pageCount = json['page_count'];
    units = json['unit'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_index'] = this.pageIndex;
    data['page_count'] = this.pageCount;
    data['unit'] = this.units;
    data['user_id'] = this.userId;
    return data;
  }
}
