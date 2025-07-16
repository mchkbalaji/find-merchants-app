import 'package:flutter/material.dart';
import '../models/merchant.dart';

class MerchantBottomSheet extends StatelessWidget {
  const MerchantBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // Fake data until we integrate Foursquare
    final fakeMerchants = <Merchant>[
      Merchant(
        name: 'Sri Sai Durga Paints & Hardware',
        address: 'Shop No. 90, MG Road, Mahadevapura',
        distance: '1.4 km',
        openTime: 'Opens 9 am Fri',
        type: 'Paints Wholesaler',
      ),
      Merchant(
        name: 'Cafe Mocha',
        address: '12, 2nd Cross, Mahadevapura',
        distance: '800 m',
        openTime: 'Open Now',
        type: 'Café',
      ),
    ];

    return DraggableScrollableSheet(
      initialChildSize: 0.28,
      minChildSize: 0.28,
      maxChildSize: 0.6,
      builder: (context, controller) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: ListView.builder(
          controller: controller,
          itemCount: fakeMerchants.length,
          itemBuilder: (ctx, idx) {
            final m = fakeMerchants[idx];
            return ListTile(
              leading: Container(
                width: 48,
                height: 48,
                color: Colors.grey[300],
                child: const Icon(Icons.store, color: Colors.white70),
              ),
              title: Text(m.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${m.distance} • ${m.address}\n${m.type} • ${m.openTime}'),
              isThreeLine: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            );
          },
        ),
      ),
    );
  }
}
