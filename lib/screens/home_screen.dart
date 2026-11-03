import 'package:flutter/material.dart';
import '../models/promo_banner.dart';
import '../services/promo_service.dart';
import '../widgets/homie_hero_banner.dart';
import '../widgets/homie_express_grid.dart';
import '../widgets/homie_special_services.dart';
import '../widgets/homie_satuan_tile.dart';
import '../widgets/homie_bottom_actions.dart';
import '../widgets/metro_order_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PromoBanner> _promos = PromoBanner.defaultPromos;
  int _currentPromoIndex = 0;
  String _selectedDuration = 'Express 5 Jam';
  String _selectedService = 'Cuci Kiloan (Express 5 Jam)';
  String _promoCode = 'JUMATBERKAH';

  @override
  void initState() {
    super.initState();
    _loadPromos();
  }

  Future<void> _loadPromos() async {
    final fetched = await PromoService.fetchPromos(forceRefresh: true);
    if (mounted) {
      setState(() {
        _promos = fetched;
        if (fetched.isNotEmpty && _promoCode.isEmpty) {
          _promoCode = fetched.first.promoCode;
        }
      });
    }
  }

  void _cycleNextPromo() {
    if (_promos.isEmpty) return;
    setState(() {
      _currentPromoIndex = (_currentPromoIndex + 1) % _promos.length;
      _promoCode = _promos[_currentPromoIndex].promoCode;
    });
    _showNotificationToast(
      '🎁 Promo Diklaim',
      '${_promos[_currentPromoIndex].title} (KODE: $_promoCode)',
    );
  }

  void _showNotificationToast(String title, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF0284C7),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 120,
          left: 14,
          right: 14,
        ),
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    message,
                    style: const TextStyle(fontSize: 11, color: Color(0xFFE0F2FE)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSelectDuration(String title, String subtitle) {
    setState(() {
      _selectedDuration = '$title $subtitle';
      _selectedService = 'Cuci Kiloan ($title $subtitle)';
    });
    _showNotificationToast('⚡ Durasi Diubah', 'Paket: Cuci Kiloan ($title)');
  }

  void _handleSelectService(String serviceName) {
    setState(() {
      _selectedService = serviceName;
    });
    _showNotificationToast('✓ Layanan Dipilih', serviceName);
  }

  void _handleOpenWhatsApp() {
    MetroOrderDialog.show(
      context,
      selectedService: _selectedService,
      promoCode: _promoCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    final activePromo = _promos.isNotEmpty ? _promos[_currentPromoIndex] : null;

    return Scaffold(
      backgroundColor: const Color(0xFF090D16),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadPromos,
          color: const Color(0xFF00A4EF),
          backgroundColor: const Color(0xFF131926),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Hero Banner Atas (Cat Mascot + Cuci Kiloan & Express + Durasi Aktif)
                HomieHeroBanner(
                  activeDuration: _selectedDuration,
                  activePromoTitle: activePromo?.title,
                  activePromoCode: activePromo?.promoCode,
                  onPromoTap: _cycleNextPromo,
                  onBannerTap: _handleOpenWhatsApp,
                ),

                const SizedBox(height: 8),

                // 2. Grid 6 Kotak Durasi Kiloan (3x2)
                HomieExpressGrid(
                  selectedDuration: _selectedDuration,
                  onSelectDuration: _handleSelectDuration,
                ),

                const SizedBox(height: 8),

                // 3. Dua Ubin Spesifik: Ambal & Sajadah + Sepatu & Tas Treatment
                HomieSpecialServices(
                  onAmbalTap: () => _handleSelectService('Cuci Ambal & Sajadah'),
                  onSepatuTap: () => _handleSelectService('Cuci Sepatu & Tas Treatment'),
                ),

                const SizedBox(height: 8),

                // 4. Ubin Cuci Satuan & Khusus
                HomieSatuanTile(
                  onSelectSatuan: (item) => _handleSelectService('Satuan ($item)'),
                ),

                const SizedBox(height: 8),

                // 5. Dua Ubin Terbawah: Pesan Antar WhatsApp + Outlet Samarinda (Islamic Center)
                HomieBottomActions(
                  onWhatsAppTap: _handleOpenWhatsApp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
