import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../core/app_config.dart';
import '../models/promo_banner.dart';

class PromoService {
  static List<PromoBanner>? _cachedPromos;

  static Future<List<PromoBanner>> fetchPromos({bool forceRefresh = false}) async {
    if (!forceRefresh && _cachedPromos != null && _cachedPromos!.isNotEmpty) {
      return _cachedPromos!;
    }

    final url = AppConfig.googleSheetsPromoUrl.trim();
    if (url.isEmpty) {
      _cachedPromos = PromoBanner.defaultPromos;
      return _cachedPromos!;
    }

    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final body = response.body.trim();
        final List<PromoBanner> parsedList = [];

        // 1. Dukungan Format JSON (dari Google Apps Script Web App)
        if (body.startsWith('{') || body.startsWith('[')) {
          final dynamic decoded = jsonDecode(body);
          List<dynamic> items = [];

          if (decoded is Map<String, dynamic> && decoded.containsKey('data')) {
            items = decoded['data'] as List<dynamic>;
          } else if (decoded is List<dynamic>) {
            items = decoded;
          }

          for (final item in items) {
            if (item is Map<String, dynamic>) {
              final banner = PromoBanner.fromJson(item);
              if (banner.title.isNotEmpty && banner.isActive) {
                parsedList.add(banner);
              }
            }
          }
        } else {
          // 2. Dukungan Format CSV (dari Published Google Sheet CSV)
          final lines = body.split(RegExp(r'\r?\n'));
          int startIndex = 0;
          if (lines.isNotEmpty &&
              (lines[0].toLowerCase().contains('judul') ||
                  lines[0].toLowerCase().contains('promo'))) {
            startIndex = 1;
          }

          for (int i = startIndex; i < lines.length; i++) {
            final line = lines[i].trim();
            if (line.isEmpty) continue;

            final parts = _parseCsvLine(line);
            if (parts.isNotEmpty) {
              final banner = PromoBanner.fromCsvRow(parts);
              if (banner.title.isNotEmpty && banner.isActive) {
                parsedList.add(banner);
              }
            }
          }
        }

        if (parsedList.isNotEmpty) {
          _cachedPromos = parsedList;
          return parsedList;
        }
      }
    } catch (e) {
      debugPrint('PromoService fetch notice: $e');
      // Offline, timeout, atau Google Apps Script belum diautentikasi -> fallback ke promo bawaan
    }

    _cachedPromos = PromoBanner.defaultPromos;
    return _cachedPromos!;
  }

  static List<String> _parseCsvLine(String line) {
    final List<String> result = [];
    final StringBuffer current = StringBuffer();
    bool inQuotes = false;

    for (int i = 0; i < line.length; i++) {
      final char = line[i];
      if (char == '"') {
        inQuotes = !inQuotes;
      } else if (char == ',' && !inQuotes) {
        result.add(current.toString().trim());
        current.clear();
      } else {
        current.write(char);
      }
    }
    result.add(current.toString().trim());
    return result;
  }
}
