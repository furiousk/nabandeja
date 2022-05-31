import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nabandeja/assets/themes/app_colors.dart';
import '../../model/kds_sales_order.dart';
import './methods.dart';

class CardWidget extends StatelessWidget {
  final Methods _methods = Methods();

  final int status;
  final String filter;

  CardWidget(BuildContext context,
      {required this.status, required this.filter, Key? key})
      : super(key: key);

  @override
  Widget build(context) {
    return FutureBuilder<List<KdsSalesOrder>>(
        future: _methods.loadKdsSalesOrder(status, filter),
        builder: (BuildContext context,
            AsyncSnapshot<List<KdsSalesOrder>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              controller: ScrollController(),
              itemCount: snapshot.data?.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return buildCard(snapshot.data![index], context);
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

GestureDetector buildCard(KdsSalesOrder order, BuildContext context) {
  final salesOrderDate = order.salesOrderDate ?? '';
  final deliveryPlaceName = order.deliveryPlaceName ?? '';
  final accountName = order.accountName ?? '';
  final item = order.entries!.map((entrie) {
    var newItem = '${entrie.entryQuantity}x ${entrie.itemDescription}';
    if (entrie.note != null) {
      newItem += '\n${entrie.note}';
    }
    return newItem;
  });
  final launchCode = order.launchCode ?? '';

  print(json.encode(order));
  
  return GestureDetector(
    onTap: () {},
    child: Card(
      elevation: 4.0,
      margin: const EdgeInsets.fromLTRB(20, 10 ,20, 10),
      child: Column(
        children: [
          Container(
            height: 30,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
              ),
              color: Colors.red,
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Icon(Icons.access_alarm, color: Colors.white,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    '$salesOrderDate min',
                    style: const TextStyle(color: Colors.white,),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[100],
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
              child: ListTile(
                title: Text(deliveryPlaceName),
                subtitle: Text(accountName),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              item.join('\n'),
              style: const TextStyle(
                color: AppColors.primary,
                height: 1.8,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only( bottom: 8.0),
            child: Text(
              launchCode,
              style: const TextStyle(
                color: AppColors.secondary,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
