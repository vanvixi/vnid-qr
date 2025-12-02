import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import '../../models/cccd_model.dart';
import '../../utils/qr_generator.dart';

class QRDisplayWidget extends StatefulWidget {
  const QRDisplayWidget({super.key, required this.cccdModel});

  final CCCDModel cccdModel;

  @override
  State<QRDisplayWidget> createState() => _QRDisplayWidgetState();
}

class _QRDisplayWidgetState extends State<QRDisplayWidget>
    with SingleTickerProviderStateMixin {
  QrImage? _qrImage;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _generateQRCode();
  }

  @override
  void didUpdateWidget(QRDisplayWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Regenerate QR code when model changes
    if (widget.cccdModel != oldWidget.cccdModel) {
      _animationController.reset();
      _generateQRCode();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _generateQRCode() {
    final qrString = widget.cccdModel.toQRString();
    final qrCode = QRGenerator.generate(qrString);
    _qrImage = QRGenerator.createImage(qrCode);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const .all(24),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  width: 280,
                  height: 280,
                  padding: const .all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: .circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: PrettyQrView(
                    qrImage: _qrImage!,
                    decoration: const PrettyQrDecoration(
                      shape: PrettyQrSmoothSymbol(color: Colors.black),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const .all(16),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    'Thông tin CCCD',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Divider(height: 24),
                  _buildInfoRow('Số CCCD:', widget.cccdModel.soCCCD),
                  if (widget.cccdModel.soCMND != null)
                    _buildInfoRow('Số CMND cũ:', widget.cccdModel.soCMND!),
                  _buildInfoRow('Họ và tên:', widget.cccdModel.hoVaTen),
                  _buildInfoRow(
                    'Giới tính:',
                    widget.cccdModel.gioiTinh.displayName,
                  ),
                  _buildInfoRow(
                    'Nơi thường trú:',
                    widget.cccdModel.noiThuongTru,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const .only(bottom: 8),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
