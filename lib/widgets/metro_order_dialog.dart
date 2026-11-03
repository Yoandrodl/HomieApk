import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_config.dart';
import '../services/launcher_service.dart';

class MetroOrderDialog extends StatefulWidget {
  final String selectedService;
  final String promoCode;

  const MetroOrderDialog({
    super.key,
    required this.selectedService,
    required this.promoCode,
  });

  static Future<void> show(
    BuildContext context, {
    required String selectedService,
    required String promoCode,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF131926),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      builder: (context) => MetroOrderDialog(
        selectedService: selectedService,
        promoCode: promoCode,
      ),
    );
  }

  @override
  State<MetroOrderDialog> createState() => _MetroOrderDialogState();
}

class _MetroOrderDialogState extends State<MetroOrderDialog> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _notesController = TextEditingController();
  late final TextEditingController _promoController;

  String _selectedOutlet = AppConfig.centralBranchName;

  @override
  void initState() {
    super.initState();
    _promoController = TextEditingController(text: widget.promoCode);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _notesController.dispose();
    _promoController.dispose();
    super.dispose();
  }

  Future<void> _submitOrder() async {
    Navigator.pop(context);

    await LauncherService.sendWhatsAppOrder(
      serviceName: widget.selectedService,
      customerName: _nameController.text.trim().isNotEmpty
          ? _nameController.text.trim()
          : 'Pelanggan Homie',
      address: _addressController.text.trim().isNotEmpty
          ? _addressController.text.trim()
          : '(Alamat akan dibagikan via chat / share location)',
      notes: _notesController.text.trim(),
      promoCode: _promoController.text.trim(),
      preferredBranch: _selectedOutlet,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        18,
        20,
        MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '📲 Konfirmasi Order WhatsApp',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white70, size: 20),
                onPressed: () => Navigator.pop(context),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            color: const Color(0xFF0284C7).withValues(alpha: 0.25),
            child: Row(
              children: [
                const Icon(Icons.check_circle_outline, color: AppColors.lumiaCyan, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Layanan: ${widget.selectedService}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Field Nama
          _buildField(
            controller: _nameController,
            label: 'Nama Pemesan (Opsional):',
            hint: 'Contoh: Bu Rina',
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 10),

          // Field Alamat
          _buildField(
            controller: _addressController,
            label: 'Alamat Jemput Samarinda (Opsional):',
            hint: 'Contoh: Jl. Juanda No. 12 (bisa share loc nanti di WA)',
            icon: Icons.location_on_outlined,
          ),
          const SizedBox(height: 10),

          // Field Catatan
          _buildField(
            controller: _notesController,
            label: 'Catatan Tambahan (Opsional):',
            hint: 'Contoh: Baju kerja 3 kg, jemput jam 2 siang',
            icon: Icons.edit_note,
          ),
          const SizedBox(height: 10),

          // Field Promo
          _buildField(
            controller: _promoController,
            label: 'Kode Promo:',
            hint: 'JUMATBERKAH',
            icon: Icons.confirmation_number_outlined,
          ),
          const SizedBox(height: 10),

          // Field Outlet
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Outlet Rujukan:',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2536),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedOutlet,
                    isExpanded: true,
                    dropdownColor: const Color(0xFF1E2536),
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                    items: const [
                      DropdownMenuItem(
                        value: AppConfig.centralBranchName,
                        child: Text(AppConfig.centralBranchName),
                      ),
                      DropdownMenuItem(
                        value: AppConfig.branchTwoName,
                        child: Text(AppConfig.branchTwoName),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedOutlet = val;
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Tombol Buka WhatsApp
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: _submitOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF25D366),
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              icon: const Icon(Icons.send_rounded, size: 18, color: Colors.black),
              label: const Text(
                'Buka WhatsApp Sekarang',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          style: const TextStyle(fontSize: 12, color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 11, color: Colors.white38),
            prefixIcon: Icon(icon, size: 16, color: Colors.white60),
            filled: true,
            fillColor: const Color(0xFF1E2536),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
