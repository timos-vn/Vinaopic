class SearchCustomerRequestBody {
  int? pageIndex;
  int? pageCount;
  String? maKh;
  String? keyWord;


  SearchCustomerRequestBody({this.pageIndex, this.pageCount,this.maKh,this.keyWord});

  SearchCustomerRequestBody.fromJson(Map<String, dynamic> json) {
    pageIndex = json['page_index'];
    pageCount = json['page_count'];
    maKh = json['ma_kh'];
    keyWord = json['key_word'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
      data['page_index'] = this.pageIndex;
      data['page_count'] = this.pageCount;
      data['ma_kh'] = this.maKh;data['key_word'] = this.keyWord;
    return data;
  }
}
