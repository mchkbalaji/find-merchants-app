import 'package:flutter/material.dart';
import '../models/merchant.dart';

class MerchantBottomSheet extends StatelessWidget {
  final List<Merchant> merchants;
  final void Function(double, double)? onTapPin;

  const MerchantBottomSheet({
    super.key,
    required this.merchants,
    this.onTapPin,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.25,
      minChildSize: 0.15,
      maxChildSize: 0.6,
      builder: (context, scrollController) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            // ←——— Pull bar indicator
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 12),
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // The merchant list
            Expanded(
              child: merchants.isEmpty
                  ? const Center(child: Text("No merchants found nearby."))
                  : ListView.builder(
                controller: scrollController,
                itemCount: merchants.length,
                itemBuilder: (context, index) {
                  final merchant = merchants[index];
                  return ListTile(
                    title: Text(merchant.name),
                    subtitle: Text('${merchant.category} • ${merchant.distance}m away'),
                    trailing: IconButton(
                      icon: const Icon(Icons.location_pin, color: Colors.redAccent),
                      onPressed: () {
                        if (merchant.latitude != null && merchant.longitude != null) {
                          onTapPin?.call(merchant.latitude!, merchant.longitude!);
                        }
                      },
                    ),
                    leading: CircleAvatar(child: Icon(Icons.storefront, color: Colors.red[600],)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
