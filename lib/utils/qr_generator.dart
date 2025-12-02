import 'package:pretty_qr_code/pretty_qr_code.dart';

class QRGenerator {
  static QrCode generate(String data) {
    return QrCode.fromData(
      data: data,
      errorCorrectLevel: QrErrorCorrectLevel.M,
    );
  }

  static QrImage createImage(QrCode qrCode) {
    return QrImage(qrCode);
  }
}
