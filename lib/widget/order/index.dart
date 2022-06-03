import 'package:flutter/material.dart';
import 'package:nabandeja/assets/themes/app_colors.dart';
import 'package:nabandeja/model/kds_order_status.dart';
import 'card_build.dart';
import 'text_company_name.dart';
import './transform_btn.dart';

class OrderApp extends StatefulWidget {
  const OrderApp({Key? key}) : super(key: key);

  @override
  State<OrderApp> createState() => _Order();
}

class _Order extends State<OrderApp> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _translateButton;

  bool _isExpanded = false;
  String _filter = "00000000-0000-0000-0000-000000000000";

  Map<String, dynamic> filterName = {
    '00000000-0000-0000-0000-000000000000': 'Todos',
    'd03114e6-c563-41a8-8442-ac8b87b3c077': 'Vinhos',
    '61efef19-004f-4703-a3c6-dd35645903ca': 'Sobremesas',
    'db121a53-ccfe-4143-bacc-7254ae096022': 'Prato Principal',
    '7588d16b-4606-4cfc-ace5-e17d0f3008de': 'Entrada',
    '7aa28158-9d7a-42e7-93f0-deabc9392574': 'Bebidas',
  };

  @override
  initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addListener(() {
        _update();
      });

    _translateButton = Tween<double>(
      begin: 100,
      end: -10,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggle() {
    if (_isExpanded) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    _isExpanded = !_isExpanded;
  }

  void _update() {
    setState(() {
      _translateButton.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          shape: const Border(bottom: BorderSide(color: AppColors.secondary)),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.receipt), text: 'Fila'),
              Tab(icon: Icon(Icons.access_alarms), text: 'Preparo'),
              Tab(icon: Icon(Icons.restaurant), text: 'Pronto'),
              //Tab(icon: Icon(Icons.room_service), text: 'Retirado'),
            ],
          ),
          title: TextCompanyNameWidget(context),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TransformBtnWidget(
              context,
              translateButton: (_translateButton.value * 7),
              colorBtn: const Color.fromARGB(255, 73, 73, 73),
              iconBtn: const Icon(Icons.all_inclusive),
              callback: () {
                setState(() {
                  _filter = "00000000-0000-0000-0000-000000000000";
                });
              },
            ),
            TransformBtnWidget(
              context,
              translateButton: (_translateButton.value * 6),
              colorBtn: const Color.fromARGB(255, 112, 6, 145),
              iconBtn: const Icon(Icons.wine_bar),
              callback: () {
                setState(() {
                  _filter = "d03114e6-c563-41a8-8442-ac8b87b3c077";
                });
              },
            ),
            TransformBtnWidget(
              context,
              translateButton: (_translateButton.value * 5),
              colorBtn: const Color.fromARGB(255, 212, 12, 243),
              iconBtn: const Icon(Icons.icecream),
              callback: () {
                setState(() {
                  _filter = "61efef19-004f-4703-a3c6-dd35645903ca";
                });
              },
            ),
            TransformBtnWidget(
              context,
              translateButton: (_translateButton.value * 4),
              colorBtn: const Color.fromARGB(255, 234, 20, 17),
              iconBtn: const Icon(Icons.dinner_dining),
              callback: () {
                setState(() {
                  _filter = "db121a53-ccfe-4143-bacc-7254ae096022";
                });
              },
            ),
            TransformBtnWidget(
              context,
              translateButton: (_translateButton.value * 3),
              colorBtn: const Color.fromARGB(255, 222, 92, 11),
              iconBtn: const Icon(Icons.lunch_dining),
              callback: () {
                setState(() {
                  _filter = "7588d16b-4606-4cfc-ace5-e17d0f3008de";
                });
              },
            ),
            TransformBtnWidget(
              context,
              translateButton: (_translateButton.value * 2),
              colorBtn: Colors.amber,
              iconBtn: const Icon(Icons.local_drink),
              callback: () {
                setState(() {
                  _filter = "7aa28158-9d7a-42e7-93f0-deabc9392574";
                });
              },
            ),
            FloatingActionButton(
              onPressed: _toggle,
              backgroundColor: AppColors.secondary,
              child: !_isExpanded
                  ? const Icon(Icons.filter_alt_rounded)
                  : const Icon(Icons.close),
            ),
          ],
        ),
        body: Stack(
          alignment: AlignmentDirectional.topStart,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 20, top: 12),
              child: Text(
                'Exibindo - ${filterName[_filter]}',
                style: const TextStyle(
                  color: AppColors.secondary,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 42, bottom: 10),
              child: TabBarView(
                children: <Widget>[
                  CardWidget(
                    context,
                    status: KdsOrderStatus.Queued,
                    filter: _filter,
                  ),
                  CardWidget(
                    context,
                    status: KdsOrderStatus.InPreparation,
                    filter: _filter,
                  ),
                  CardWidget(
                    context,
                    status: KdsOrderStatus.Ready,
                    filter: _filter,
                  ),
                  //const Icon(Icons.room_service),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
