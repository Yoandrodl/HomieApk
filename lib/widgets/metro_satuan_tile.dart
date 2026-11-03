import 'package:flutter/material.dart';
import '../models/service_item.dart';
import 'metro_tile_card.dart';

class MetroSatuanTile extends StatelessWidget {
  final Function(String item) onSelectSatuan;

  const MetroSatuanTile({
    super.key,
    required this.onSelectSatuan,
  });

  void _showSatuanDialog(BuildContext context) {
    final items = ServiceItem.satuanItems;

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF131926),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
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
                    '👔 Cuci Satuan & Khusus',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
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
                        width: 36,
                        height: 36,
                        color: Colors.white.withValues(alpha: 0.1),
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MetroTileCard(
        backgroundColor: const Color(0xFF1E293B),
        leftAccentColor: const Color(0xFFA855F7),
        height: 80,
        onTap: () => _showSatuanDialog(context),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              color: Colors.white.withValues(alpha: 0.08),
              alignment: Alignment.center,
              child: const Text('👔', style: TextStyle(fontSize: 24)),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Cuci Satuan & Khusus',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Jas, Boneka, Bedcover, Gorden, Stroller',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFFCBD5E1),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              color: const Color(0xFF7E22CE),
              child: const Text(
                'Daftar +',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
