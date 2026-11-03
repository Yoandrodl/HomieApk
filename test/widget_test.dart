import 'package:flutter_test/flutter_test.dart';
import 'package:homie_laundry/models/promo_banner.dart';
import 'package:homie_laundry/models/service_item.dart';
import 'package:homie_laundry/widgets/homie_express_grid.dart';

void main() {
  group('Homie Laundry Lumia Metro UI Tests', () {
    test('Default promos should contain expected active promos', () {
      final promos = PromoBanner.defaultPromos;
      expect(promos.isNotEmpty, true);
      expect(promos.any((p) => p.promoCode == 'JUMATBERKAH'), true);
      expect(promos.any((p) => p.promoCode == 'WEEKENDCLEAN'), true);
      expect(promos.any((p) => p.promoCode == 'AMBALSUCI'), true);
    });

    test('PromoBanner fromJson parsing works correctly', () {
      final json = {
        'judul_promo': 'Promo Gas Kilat',
        'keterangan': 'Diskon sepatu 30%',
        'kode_promo': 'GASKILAT',
        'badge': 'HEMAT',
        'status': 'Aktif',
      };
      final banner = PromoBanner.fromJson(json);
      expect(banner.title, 'Promo Gas Kilat');
      expect(banner.description, 'Diskon sepatu 30%');
      expect(banner.promoCode, 'GASKILAT');
      expect(banner.badge, 'HEMAT');
      expect(banner.isActive, true);
    });

    test('PromoBanner fromCsvRow parsing works correctly', () {
      final row = ['Promo Lebaran', 'Diskon ambal', 'LEBARAN20', 'HEMAT', 'Aktif'];
      final banner = PromoBanner.fromCsvRow(row);
      expect(banner.title, 'Promo Lebaran');
      expect(banner.description, 'Diskon ambal');
      expect(banner.promoCode, 'LEBARAN20');
      expect(banner.badge, 'HEMAT');
      expect(banner.isActive, true);
    });

    test('Main services should contain Kiloan, Ambal, and Sepatu', () {
      final services = ServiceItem.mainServices;
      expect(services.length, 3);
      expect(services[0].id, 'kiloan');
      expect(services[1].id, 'ambal');
      expect(services[2].id, 'sepatu');
    });

    test('HomieExpressGrid contains 6 express options (2h, 3h, 5h, Same Day, 1x24h, Bulanan)', () {
      final titles = HomieExpressGrid.items.map((i) => i['title']).toList();
      expect(titles.contains('2 Jam'), true);
      expect(titles.contains('3 Jam'), true);
      expect(titles.contains('5 Jam'), true);
      expect(titles.contains('Same Day'), true);
      expect(titles.contains('1x24 Jam'), true);
      expect(titles.contains('Bulanan'), true);
    });

    test('Satuan items should contain Jas, Boneka, Bedcover', () {
      final satuan = ServiceItem.satuanItems;
      expect(satuan.isNotEmpty, true);
      expect(satuan.any((item) => item['nama']!.contains('Jas')), true);
      expect(satuan.any((item) => item['nama']!.contains('Boneka')), true);
      expect(satuan.any((item) => item['nama']!.contains('Bedcover')), true);
    });
  });
}
