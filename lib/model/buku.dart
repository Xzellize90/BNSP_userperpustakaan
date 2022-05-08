class Buku {
  String? judulbuku;
  String? status;

  Buku({
    this.judulbuku,
    this.status,
  });

  factory Buku.fromJson(Map<String, dynamic> json) => Buku(
        judulbuku: json['judulbuku'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'judulbuku': judulbuku,
        'status': status,
      };
}