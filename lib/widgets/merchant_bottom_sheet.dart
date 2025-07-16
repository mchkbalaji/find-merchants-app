import 'package:flutter/material.dart';
import '../models/merchant.dart';

class MerchantBottomSheet extends StatelessWidget {
  final List<Merchant> merchants;

  const MerchantBottomSheet({super.key, required this.merchants});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.25,
      minChildSize: 0.1,
      maxChildSize: 0.6,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListView.builder(
            controller: scrollController,
            itemCount: merchants.length,
            itemBuilder: (context, index) {
              final merchant = merchants[index];
              return ListTile(
                title: Text(merchant.name),
                subtitle: Text('${merchant.category} • ${merchant.distance} m'),
                trailing: Icon(Icons.location_pin),
                isThreeLine: true,
                dense: false,
                contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                onTap: () {}, // Optional: Add logic for place details
                leading: const CircleAvatar(child: Icon(Icons.storefront)),
              );
            },
          ),
        );
      },
    );
  }
}
