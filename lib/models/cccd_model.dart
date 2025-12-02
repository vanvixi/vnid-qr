import 'gender.dart';

class CCCDModel {
  final String soCCCD;
  final String? soCMND;
  final String hoVaTen;
  final DateTime ngaySinh;
  final Gender gioiTinh;
  final String noiThuongTru;
  final DateTime ngayCapCCCD;

  CCCDModel({
    required this.soCCCD,
    this.soCMND,
    required this.hoVaTen,
    required this.ngaySinh,
    required this.gioiTinh,
    required this.noiThuongTru,
    required this.ngayCapCCCD,
  });

  String toQRString() {
    final ngaySinhStr = _formatDate(ngaySinh);
    final ngayCapStr = _formatDate(ngayCapCCCD);

    return [
      soCCCD,
      soCMND ?? '',
      hoVaTen,
      ngaySinhStr,
      gioiTinh.displayName,
      noiThuongTru,
      ngayCapStr,
      '',
      '',
      '',
      '',
    ].join('|');
  }

  String _formatDate(DateTime date) {
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString();
    return '$day$month$year';
  }

  @override
  operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CCCDModel &&
        other.soCCCD == soCCCD &&
        other.soCMND == soCMND &&
        other.hoVaTen == hoVaTen &&
        other.ngaySinh == ngaySinh &&
        other.gioiTinh == gioiTinh &&
        other.noiThuongTru == noiThuongTru &&
        other.ngayCapCCCD == ngayCapCCCD;
  }

  @override
  int get hashCode => Object.hash(
    soCCCD,
    soCMND,
    hoVaTen,
    ngaySinh,
    gioiTinh,
    noiThuongTru,
    ngayCapCCCD,
  );
}
