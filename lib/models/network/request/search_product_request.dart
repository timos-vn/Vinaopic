class SearchProductRequest {
  int? pageIndex;
  int? pageCount;
  String? keyWord;

  SearchProductRequest({this.pageIndex, this.pageCount, this.keyWord});

  SearchProductRequest.fromJson(Map<String, dynamic> json) {
    pageIndex = json['page_index'];
    pageCount = json['page_count'];
    keyWord = json['key_word'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_index'] = this.pageIndex;
    data['page_count'] = this.pageCount;
    data['key_word'] = this.keyWord;
    return data;
  }
}