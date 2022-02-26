class CommonModel {

  var data;

  CommonModel({this.data});

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
     
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    
    data['data'] = this.data;

    return data;
  }
}
