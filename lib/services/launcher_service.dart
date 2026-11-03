import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/app_config.dart';

class LauncherService {
  /// Membuka WhatsApp dengan nomor tujuan dan pesan terformat
  static Future<bool> sendWhatsAppOrder({
    required String serviceName,
    required String customerName,
    required String address,
    required String notes,
    required String promoCode,
    String? preferredBranch,
    String? customPhoneNumber,
  }) async {
    final phoneNumber = customPhoneNumber ?? AppConfig.primaryWhatsAppNumber;

    final buffer = StringBuffer();
    buffer.writeln('Halo Homie Laundry Samarinda, saya mau order layanan antar jemput:');
    buffer.writeln('');
    buffer.writeln('📋 *Detail Pemesanan:*');
    buffer.writeln('• *Layanan:* $serviceName');
    buffer.writeln('• *Nama Pemesan:* $customerName');
    buffer.writeln('• *Alamat Jemput:* $address');

    if (notes.trim().isNotEmpty) {
      buffer.writeln('• *Catatan:* ${notes.trim()}');
    }

    if (promoCode.trim().isNotEmpty) {
      buffer.writeln('• *Kode Promo:* ${promoCode.trim().toUpperCase()}');
    }

    if (preferredBranch != null && preferredBranch.isNotEmpty) {
      buffer.writeln('• *Outlet Rujukan:* $preferredBranch');
    } else {
      buffer.writeln('• *Outlet Rujukan:* ${AppConfig.centralBranchName}');
    }

    buffer.writeln('');
    buffer.writeln('Mohon konfirmasi jadwal penjemputannya ya min. Terima kasih! 🙏✨');

    final message = buffer.toString();
    final encodedMessage = Uri.encodeComponent(message);

    // 1. Coba deep link native WhatsApp
    final nativeUri = Uri.parse('whatsapp://send?phone=$phoneNumber&text=$encodedMessage');
    // 2. Fallback web wa.me
    final webUri = Uri.parse('https://wa.me/$phoneNumber?text=$encodedMessage');

    try {
      if (await canLaunchUrl(nativeUri)) {
        return await launchUrl(nativeUri, mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(webUri)) {
        return await launchUrl(webUri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('Error launching WhatsApp: $e');
    }

    // Terakhir coba launch web
    return await launchUrl(webUri, mode: LaunchMode.externalApplication);
  }

  /// Membuka Rute Google Maps Outlet
  static Future<bool> openGoogleMaps(String url) async {
    final uri = Uri.parse(url);
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Error opening maps: $e');
      return false;
    }
  }

  /// Membuka Website
  static Future<bool> openWebsite(String url) async {
    final uri = Uri.parse(url);
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Error opening website: $e');
      return false;
    }
  }
}
