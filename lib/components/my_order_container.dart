import 'package:chef_lunch/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyOrderContainer extends StatelessWidget {
  final String foodId;
  final OrderModel orderInfo;
  const MyOrderContainer({
    super.key,
    required this.orderInfo,
    required this.foodId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: const Color(0x1F371240),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/svgs/icons8-complete.svg',
                  // ignore: deprecated_member_use
                  color: Colors.green,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Order id -#$foodId'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text('Order on- ${orderInfo.data}')
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Price(items)'),
                const Spacer(),
                Text('\$ ${orderInfo.foodInfo.first.foodInfo.price}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
