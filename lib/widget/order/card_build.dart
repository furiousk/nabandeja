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
            if (snapshot.data?.length == 0) {
              return Center(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: const <Widget> [
                    Icon(
                      Icons.no_food_outlined,
                      size: 32,
                      color: Colors.grey,
                    ),
                    Text(
                      '\n\n\n\nNenhum pedido na fila!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )
              );
            }
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
  final timeElapsed = DateTime.now().difference(DateTime.parse(salesOrderDate));
  final timeTrackingNormal = order.timeTrackingNormal ?? '';
  final timeTrackingWarning = order.timeTrackingWarning ?? '';
  final timeTrackingDanger = order.timeTrackingDanger ?? '';
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

  int getMinute(String time) {
    return int.tryParse(time.split(':')[1]) ?? 0;
  }

  Color colorStatus(Duration orderTime) {
    if (orderTime.inMinutes >= getMinute(timeTrackingWarning)) {
      return Colors.red;
    } else if (orderTime.inMinutes >= getMinute(timeTrackingNormal)) {
      return Colors.amber;
    } else {
      return Colors.lightGreen;
    }
  }

  print(order.toJson());
  
  return GestureDetector(
    onTap: () {},
    child: Card(
      elevation: 4.0,
      margin: const EdgeInsets.fromLTRB(20, 10 ,20, 10),
      child: Column(
        children: [
          Container(
            height: 30,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
              ),
              color: colorStatus(timeElapsed),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Icon(Icons.access_alarm, color: Colors.white, size: 16,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    '${timeElapsed.inMinutes} min',
                    style: const TextStyle(color: Colors.white,),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: AppColors.lightGrey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
              child: ListTile(
                title: Text(
                  deliveryPlaceName,
                  style: const TextStyle(
                    fontSize: 20,
                    color: AppColors.primary,
                  ),
                ),
                subtitle: Text(accountName),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              item.join('\n'),
              style: const TextStyle(
                color: AppColors.primary,
                height: 1.8,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(4),
              ),
              color: AppColors.lightGrey,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                launchCode,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.secondary,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
