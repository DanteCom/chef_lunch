import 'package:chef_lunch/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyOrderContainer extends StatelessWidget {
  final OrderModel orderInfo;
  const MyOrderContainer({
    super.key,
    required this.orderInfo,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Column(
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .6,
                    child: Text(
                      'ID- #${orderInfo.orderId}',
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Order on- ${orderInfo.data}')
                ],
              ),
            ],
          ),
        ],
      ),
      children: [
        ...List.generate(
          orderInfo.foodInfo.length,
          (index) {
            return Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Image(
                        image: NetworkImage(
                            orderInfo.foodInfo[index].foodInfo.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Name: ${orderInfo.foodInfo[index].foodInfo.name}'),
                        Text('Items: ${orderInfo.foodInfo[index].quantity}'),
                      ],
                    ),
                    const Spacer(),
                    Text('\$${orderInfo.foodInfo[index].foodInfo.price}'),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ],
    );
  }
}
