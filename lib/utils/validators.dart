class Validators {
  static String? validateSoCCCD(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập số CCCD';
    }
    if (!RegExp(r'^\d{12}$').hasMatch(value)) {
      return 'Số CCCD phải có đúng 12 chữ số';
    }
    return null;
  }

  static String? validateSoCMND(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (!RegExp(r'^\d{9}$|^\d{12}$').hasMatch(value)) {
      return 'Số CMND phải có 9 hoặc 12 chữ số';
    }
    return null;
  }

  static String? validateHoTen(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập họ và tên';
    }
    if (value.trim().length < 2) {
      return 'Họ tên phải có ít nhất 2 ký tự';
    }
    return null;
  }

  static String? validateDate(String? value, {String fieldName = 'Ngày'}) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập $fieldName';
    }

    if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value)) {
      return '$fieldName phải có định dạng dd/MM/yyyy';
    }

    try {
      final parts = value.split('/');
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      final date = DateTime(year, month, day);

      if (date.day != day || date.month != month || date.year != year) {
        return '$fieldName không hợp lệ';
      }

      return null;
    } catch (e) {
      return '$fieldName không hợp lệ';
    }
  }

  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập nơi thường trú';
    }
    if (value.trim().length < 5) {
      return 'Địa chỉ phải có ít nhất 5 ký tự';
    }
    return null;
  }

  static DateTime parseDate(String dateStr) {
    final parts = dateStr.split('/');
    return DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );
  }
}
