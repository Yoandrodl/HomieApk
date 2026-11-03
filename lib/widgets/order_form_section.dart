import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_config.dart';
import '../services/launcher_service.dart';

class OrderFormSection extends StatefulWidget {
  final String selectedService;
  final String promoCode;
  final Function(String service) onServiceChanged;
  final Function(String promo) onPromoChanged;

  const OrderFormSection({
    super.key,
    required this.selectedService,
    required this.promoCode,
    required this.onServiceChanged,
    required this.onPromoChanged,
  });

  @override
  State<OrderFormSection> createState() => _OrderFormSectionState();
}

class _OrderFormSectionState extends State<OrderFormSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _notesController = TextEditingController();
  late final TextEditingController _promoController;

  String _selectedOutlet = AppConfig.centralBranchName;

  final List<String> _quickServiceOptions = [
    'Cuci Kiloan & Express',
    'Cuci Ambal & Sajadah',
    'Cuci Sepatu & Tas Treatment',
    'Cuci Satuan & Khusus',
  ];

  @override
  void initState() {
    super.initState();
    _promoController = TextEditingController(text: widget.promoCode);
  }

  @override
  void didUpdateWidget(covariant OrderFormSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.promoCode != oldWidget.promoCode) {
      _promoController.text = widget.promoCode;
    }
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
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final serviceToUse = widget.selectedService.isNotEmpty
        ? widget.selectedService
        : 'Cuci Kiloan & Express';

    await LauncherService.sendWhatsAppOrder(
      serviceName: serviceToUse,
      customerName: _nameController.text.trim(),
      address: _addressController.text.trim(),
      notes: _notesController.text.trim(),
      promoCode: _promoController.text.trim(),
      preferredBranch: _selectedOutlet,
      customPhoneNumber: AppConfig.primaryWhatsAppNumber,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.whatsappGreen.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.local_shipping_rounded,
                    color: Color(0xFF15803D),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Formulir Pesan Antar-Jemput',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark,
                          letterSpacing: -0.2,
                        ),
                      ),
                      Text(
                        'Langsung terhubung ke WhatsApp resmi Homie Laundry',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Pilihan Layanan
            const Text(
              'Pilih Layanan Utama:',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _quickServiceOptions.map((opt) {
                final isSelected = widget.selectedService == opt ||
                    (widget.selectedService.startsWith('Satuan') &&
                        opt.startsWith('Cuci Satuan'));
                return ChoiceChip(
                  label: Text(
                    opt,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected ? Colors.white : AppColors.textDark,
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: AppColors.primary,
                  backgroundColor: AppColors.surfaceVariant,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: isSelected ? AppColors.primary : AppColors.border,
                    ),
                  ),
                  showCheckmark: false,
                  onSelected: (selected) {
                    if (selected) {
                      widget.onServiceChanged(opt);
                    }
                  },
                );
              }).toList(),
            ),

            if (widget.selectedService.isNotEmpty &&
                !_quickServiceOptions.contains(widget.selectedService)) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check, size: 14, color: AppColors.primary),
                    const SizedBox(width: 6),
                    Text(
                      'Pilihan Khusus: ${widget.selectedService}',
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 16),

            // Field Nama
            _buildLabel('Nama Lengkap:'),
            TextFormField(
              controller: _nameController,
              decoration: _inputDecoration(
                hintText: 'Contoh: Ibu Rina / Pak Hendra',
                prefixIcon: Icons.person_outline_rounded,
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Mohon tulis nama Anda';
                }
                return null;
              },
            ),

            const SizedBox(height: 14),

            // Field Alamat
            _buildLabel('Alamat Penjemputan (Area Samarinda):'),
            TextFormField(
              controller: _addressController,
              maxLines: 2,
              decoration: _inputDecoration(
                hintText: 'Contoh: Jl. Juanda No. 12, RT 05 (Dekat Apotek Kimia Farma)',
                prefixIcon: Icons.location_on_outlined,
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Mohon cantumkan alamat penjemputan';
                }
                return null;
              },
            ),

            const SizedBox(height: 14),

            // Field Catatan
            _buildLabel('Catatan Tambahan (Opsional):'),
            TextFormField(
              controller: _notesController,
              decoration: _inputDecoration(
                hintText: 'Cth: Baju kerja 3 kg express 3 jam / jemput jam 2 siang',
                prefixIcon: Icons.edit_note_rounded,
              ),
            ),

            const SizedBox(height: 14),

            // Field Kode Promo
            _buildLabel('Kode Promo (Opsional):'),
            TextFormField(
              controller: _promoController,
              textCapitalization: TextCapitalization.characters,
              onChanged: (val) => widget.onPromoChanged(val),
              decoration: _inputDecoration(
                hintText: 'Contoh: JUMATBERKAH',
                prefixIcon: Icons.confirmation_number_outlined,
                suffixWidget: widget.promoCode.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 16),
                        onPressed: () {
                          _promoController.clear();
                          widget.onPromoChanged('');
                        },
                      )
                    : null,
              ),
            ),

            const SizedBox(height: 16),

            // Outlet Selector
            _buildLabel('Outlet Referensi Penjemputan:'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedOutlet,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded,
                      color: AppColors.textMuted),
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w600,
                  ),
                  onChanged: (newVal) {
                    if (newVal != null) {
                      setState(() {
                        _selectedOutlet = newVal;
                      });
                    }
                  },
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
                ),
              ),
            ),

            const SizedBox(height: 22),

            // Tombol Kirim WhatsApp
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _submitOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.whatsappGreen,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chat_rounded, size: 20, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Pesan Antar Jemput via WhatsApp',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                '0% Biaya Admin • Pesan langsung terkirim ke WhatsApp Kasir',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
          color: AppColors.textDark,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixWidget,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 12, color: AppColors.textLight),
      prefixIcon: Icon(prefixIcon, size: 18, color: AppColors.textMuted),
      suffixIcon: suffixWidget,
      filled: true,
      fillColor: AppColors.background,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    );
  }
}
