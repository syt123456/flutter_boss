class CompanyDetail {
  final String id;
  final String inc;
//  final List companyImgsResult;
  final String companyImgsResult;

  CompanyDetail({this.id, this.inc, this.companyImgsResult});

  factory CompanyDetail.fromJson(Map<String, dynamic> json) {
    return CompanyDetail(
        id: json['id'],
        inc: json['inc'],
        companyImgsResult: json['companyImgsResult']
    );
  }
}