class JobDetail {
  final String id;
  final String context;
  final String address;

  JobDetail({this.id, this.context, this.address});

  factory JobDetail.fromJson(Map<String, dynamic> json) {
    return JobDetail(
        id: json['id'],
        context: json['context'],
        address: json['address']
    );
  }
}