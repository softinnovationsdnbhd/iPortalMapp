class Statement {
  int? cooperative;
  String? fromdt;
  String? todt;
  String? documentno;
  String? transactiondate;
  String? receiptno;
  String? description;
  String? sell;
  String? buy;
  String? weightdesc;
  String? message;

  Statement(
      {this.cooperative,
      this.fromdt,
      this.todt,
      this.documentno,
      this.transactiondate,
      this.receiptno,
      this.description,
      this.sell,
      this.buy,
      this.weightdesc,
      this.message});

  Statement.fromJson(Map<String, dynamic> json) {
    cooperative = json['cooperative'];
    fromdt = json['fromdt'];
    todt = json['todt'];
    documentno = json['documentno'];
    transactiondate = json['transactiondate'];
    receiptno = json['receiptno'];
    description = json['description'];
    sell = json['Sell'];
    buy = json['Buy'];
    weightdesc = json['weightdesc'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cooperative'] = this.cooperative;
    data['fromdt'] = this.fromdt;
    data['todt'] = this.todt;
    data['documentno'] = this.documentno;
    data['transactiondate'] = this.transactiondate;
    data['receiptno'] = this.receiptno;
    data['description'] = this.description;
    data['Sell'] = this.sell;
    data['Buy'] = this.buy;
    data['weightdesc'] = this.weightdesc;
    data['message'] = this.message;
    return data;
  }
}
