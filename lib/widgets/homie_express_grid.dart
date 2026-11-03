import 'package:flutter/material.dart';
import 'metro_tile_card.dart';

class HomieExpressGrid extends StatelessWidget {
  final String selectedDuration;
  final Function(String title, String subtitle) onSelectDuration;

  const HomieExpressGrid({
    super.key,
    required this.selectedDuration,
    required this.onSelectDuration,
  });

  static const List<Map<String, dynamic>> items = [
    {
      'title': '2 Jam',
      'subtitle': 'Express',
      'icon': Icons.timer_outlined,
      'isExpress': true,
    },
    {
      'title': '3 Jam',
      'subtitle': 'Regular',
      'icon': Icons.timer_outlined,
      'isExpress': false,
    },
    {
      'title': '5 Jam',
      'subtitle': 'Express',
      'icon': Icons.timer_outlined,
      'isExpress': true,
    },
    {
      'title': 'Same Day',
      'subtitle': 'Hari Ini',
      'icon': Icons.calendar_today_outlined,
      'isExpress': false,
    },
    {
      'title': '1x24 Jam',
      'subtitle': 'Layanan',
      'icon': Icons.cached_rounded,
      'isExpress': false,
    },
    {
      'title': 'Bulanan',
      'subtitle': 'Paket',
      'icon': Icons.event_note_outlined,
      'isExpress': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1.05,
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          final title = item['title'] as String;
          final subtitle = item['subtitle'] as String;
          final icon = item['icon'] as IconData;

          final isSelected = selectedDuration.contains(title);

          final tileBg = isSelected ? const Color(0xFF00A4EF) : const Color(0xFF0267C1);
          final leftAccent = isSelected ? const Color(0xFFBAE6FD) : const Color(0xFF0284C7);

          return MetroTileCard(
            backgroundColor: tileBg,
            leftAccentColor: leftAccent,
            onTap: () => onSelectDuration(title, subtitle),
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 26,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -0.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                if (isSelected)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.chevron_right_rounded,
                        size: 14,
                        color: Color(0xFF00A4EF),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
