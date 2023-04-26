class GetListAwaitingCustomer {
  int? pageIndex;
  int? pageCount;
  String? dateForm;
  String? dateTo;

  GetListAwaitingCustomer(
      {this.pageIndex, this.pageCount, this.dateForm, this.dateTo});

  GetListAwaitingCustomer.fromJson(Map<String, dynamic> json) {
    pageIndex = json['page_index'];
    pageCount = json['page_count'];
    dateForm = json['datefrom'];
    dateTo = json['dateto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_index'] = this.pageIndex;
    data['page_count'] = this.pageCount;
    data['datefrom'] = this.dateForm;
    data['dateto'] = this.dateTo;
    return data;
  }
}

