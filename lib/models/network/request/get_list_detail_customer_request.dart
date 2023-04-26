class ListDetailPromissoryNoteCustomerRequestBody {
  int? pageIndex;
  int? pageCount;
  String? maKh;
  String? typeData;

  ListDetailPromissoryNoteCustomerRequestBody({this.pageIndex, this.pageCount,this.maKh,this.typeData});

  ListDetailPromissoryNoteCustomerRequestBody.fromJson(Map<String, dynamic> json) {
    pageIndex = json['page_index'];
    pageCount = json['page_count'];
    maKh = json['ma_kh'];
    typeData = json['data_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_index'] = this.pageIndex;
    data['page_count'] = this.pageCount;
    data['ma_kh'] = this.maKh;
    data['data_type'] = this.typeData;
    return data;
  }
}
