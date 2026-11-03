import 'package:flutter/material.dart';
import '../models/service_item.dart';
import 'metro_tile_card.dart';

class HomieSatuanTile extends StatelessWidget {
  final Function(String selectedItem) onSelectSatuan;

  const HomieSatuanTile({
    super.key,
    required this.onSelectSatuan,
  });

  void _showSatuanSheet(BuildContext context) {
    final items = ServiceItem.satuanItems;

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF131926),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.fromLTRB(
            16,
            16,
            16,
            MediaQuery.of(context).padding.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '👔 Layanan Satuan & Khusus',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white70, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Text(
                'Perawatan bahan lembut dan terpisah per item.',
                style: TextStyle(fontSize: 11.5, color: Colors.white60),
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.45,
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: items.length,
                  separatorBuilder: (context, index) => const Divider(
                    color: Color(0xFF263248),
                    height: 8,
                  ),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      leading: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(item['emoji']!, style: const TextStyle(fontSize: 20)),
                      ),
                      title: Text(
                        item['nama']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        item['deskripsi']!,
                        style: const TextStyle(color: Colors.white60, fontSize: 10.5),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: const Icon(Icons.chevron_right, color: Colors.white38, size: 18),
                      onTap: () {
                        Navigator.pop(context);
                        onSelectSatuan(item['nama']!);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: MetroTileCard(
        backgroundColor: const Color(0xFF1E2536),
        leftAccentColor: const Color(0xFF38BDF8),
        height: 70,
        onTap: () => _showSatuanSheet(context),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            // Shirt Image Icon
            SizedBox(
              width: 44,
              height: 44,
              child: Image.asset(
                'assets/images/dress_shirt.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: const Text('👔', style: TextStyle(fontSize: 24)),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Titles
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Cuci Satuan & Khusus',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -0.2,
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(
                    'Jas, Boneka, Bedcover...',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF94A3B8),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Circle Chevron Button
            Container(
              width: 22,
              height: 22,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(
                Icons.chevron_right_rounded,
                size: 16,
                color: Color(0xFF1E2536),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
