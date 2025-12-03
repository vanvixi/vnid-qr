import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/cccd_model.dart';
import '../models/gender.dart';
import '../utils/date_input_formatter.dart';
import '../utils/validators.dart';
import 'widgets/gender_dropdown_form_field.dart';
import 'widgets/my_form.dart';
import 'widgets/qr_display_widget.dart';
import 'widgets/scaffold_responsive.dart';
import 'widgets/string_input_form_field.dart';

class QrFormScreen extends StatefulWidget {
  const QrFormScreen({super.key});

  @override
  State<QrFormScreen> createState() => _QrFormScreenState();
}

class _QrFormScreenState extends State<QrFormScreen> {
  bool isDesktop = false;

  // Form values
  String _soCCCD = '';
  String? _soCMND;
  String _hoVaTen = '';
  String _ngaySinh = '';
  Gender _gioiTinh = Gender.nam;
  String _noiThuongTru = '';
  String _ngayCap = '';

  final ValueNotifier<CCCDModel?> _cccdModelNotifier = ValueNotifier(null);

  @override
  void dispose() {
    _cccdModelNotifier.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final cccdModel = CCCDModel(
      soCCCD: _soCCCD,
      soCMND: _soCMND,
      hoVaTen: _hoVaTen,
      ngaySinh: Validators.parseDate(_ngaySinh),
      gioiTinh: _gioiTinh,
      noiThuongTru: _noiThuongTru,
      ngayCapCCCD: Validators.parseDate(_ngayCap),
    );

    if (isDesktop) {
      _cccdModelNotifier.value = cccdModel;
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.8,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return QRDisplayWidget(cccdModel: cccdModel);
          },
        );
      },
    );
  }

  void _handleReset() {
    _cccdModelNotifier.value = null;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldResponsive(
      appBar: AppBar(title: const Text('Tạo QR Code CCCD')),
      mobileBuilder: (context) {
        isDesktop = false;
        return _buildFormArea();
      },
      tabletBuilder: (context) {
        isDesktop = true;
        return Row(
          crossAxisAlignment: .start,
          children: [
            Flexible(flex: 2, child: _buildFormArea()),
            Flexible(flex: 3, child: _buildQrArea()),
          ],
        );
      },
    );
  }

  Widget _buildQrArea() {
    return ValueListenableBuilder<CCCDModel?>(
      valueListenable: _cccdModelNotifier,
      builder: (context, cccdModel, child) {
        if (cccdModel == null) {
          return Center(
            child: Column(
              mainAxisAlignment: .start,
              children: [
                Icon(Icons.qr_code_rounded, size: 240, color: Colors.grey[300]),
                const SizedBox(height: 16),
                Text(
                  'Nhập thông tin và nhấn "Tạo QR Code"',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }

        return QRDisplayWidget(cccdModel: cccdModel);
      },
    );
  }

  Widget _buildFormArea() {
    return MyForm(
      onReset: _handleReset,
      onSubmit: _handleSubmit,
      children: [
        StringInputFormField(
          initialValue: _soCCCD,
          labelText: 'Số CCCD *',
          hintText: '001085008171',
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(12),
          ],
          validator: Validators.validateSoCCCD,
          onSaved: (value) => _soCCCD = value?.trim() ?? '',
        ),
        StringInputFormField(
          initialValue: _soCMND,
          labelText: 'Số CMND cũ',
          hintText: '112140305 (không bắt buộc)',
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(12),
          ],
          validator: Validators.validateSoCMND,
          onSaved: (value) => _soCMND = value?.trim(),
        ),
        StringInputFormField(
          initialValue: _hoVaTen,
          labelText: 'Họ và tên *',
          hintText: 'Nguyễn Văn A',
          textCapitalization: TextCapitalization.words,
          validator: Validators.validateHoTen,
          onSaved: (value) => _hoVaTen = value?.trim() ?? '',
        ),
        StringInputFormField(
          initialValue: _ngaySinh,
          labelText: 'Ngày sinh *',
          hintText: 'dd/MM/yyyy',
          keyboardType: TextInputType.number,
          inputFormatters: [DateInputFormatter()],
          validator: (value) =>
              Validators.validateDate(value, fieldName: 'Ngày sinh'),
          onSaved: (value) => _ngaySinh = value ?? '',
        ),
        GenderDropdownFormField(
          initialValue: _gioiTinh,
          onSaved: (value) => _gioiTinh = value ?? Gender.nam,
        ),
        StringInputFormField(
          initialValue: _noiThuongTru,
          labelText: 'Nơi thường trú *',
          hintText: 'Thôn Hàn, Sơn Đồng, Hoài Đức, Hà Nội',
          maxLines: 2,
          textCapitalization: TextCapitalization.words,
          validator: Validators.validateAddress,
          onSaved: (value) => _noiThuongTru = value?.trim() ?? '',
        ),
        StringInputFormField(
          initialValue: _ngayCap,
          labelText: 'Ngày cấp CCCD *',
          hintText: 'dd/MM/yyyy',
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          inputFormatters: [DateInputFormatter()],
          validator: (value) =>
              Validators.validateDate(value, fieldName: 'Ngày cấp'),
          onSaved: (value) => _ngayCap = value ?? '',
        ),
      ],
    );
  }
}
