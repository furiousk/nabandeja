import 'package:flutter/material.dart';
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
  var deliveryPlaceName = order.deliveryPlaceName ?? "";
  var accountName = order.accountName ?? "";
  var itemDescription = order.entries![0].itemDescription ?? "";
  var entryQuantity = order.entries![0].entryQuantity ?? "";
  var note = order.entries![0].note ?? "";
  var launchCode = order.launchCode ?? "";

  return GestureDetector(
    onTap: () {},
    child: Card(
      elevation: 4.0,
      margin: const EdgeInsets.fromLTRB(20, 10 ,20, 10),
      child: Column(
        children: [
          ListTile(
            title: Text(deliveryPlaceName),
            subtitle: Text(accountName),
          ),
          ListTile(
            title: Text("${entryQuantity}x $itemDescription"),
            subtitle: Text(note),
          ),
        ],
      ),
    ),
  );
}
