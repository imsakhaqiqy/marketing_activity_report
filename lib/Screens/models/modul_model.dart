class ModulModel {
  String id;
  String title;
  String path;
  String createdAt;

  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
  ModulModel({this.id, this.title, this.path, this.createdAt});

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  factory ModulModel.fromJson(Map<String, dynamic> json) => ModulModel(
      id: json['id'],
      title: json['title'],
      path: json['path'],
      createdAt: json['createdAt']);
}
