import 'package:flutter/material.dart';
import 'package:nabandeja/assets/themes/app_colors.dart';
import 'card_build.dart';
import 'text_company_name.dart';

class OrderApp extends StatefulWidget {
  const OrderApp({Key? key}) : super(key: key);

  @override
  State<OrderApp> createState() => _Order();
}

class _Order extends State<OrderApp> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _buttonAnimatedIcon;
  late Animation<double> _translateButton;

  bool _isExpanded = false;

  @override
  initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600))
      ..addListener(() {
        setState(() {});
      });

    _buttonAnimatedIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

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

  _toggle() {
    if (_isExpanded) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    _isExpanded = !_isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            shape: const Border(bottom: BorderSide(color: AppColors.secondary)),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.receipt), text: 'Fila'),
                Tab(icon: Icon(Icons.access_alarms), text: 'Preparo'),
                Tab(icon: Icon(Icons.restaurant), text: 'Pronto'),
                Tab(icon: Icon(Icons.room_service), text: 'Retirado'),
              ],
            ),
            title: TextCompanyNameWidget(context),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Transform(
                transform: Matrix4.translationValues(
                  0.0,
                  _translateButton.value * 7,
                  0.0,
                ),
                child: FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 73, 73, 73),
                  onPressed: () {/* Do something */},
                  child: const Icon(
                    Icons.all_inclusive,
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(
                  0.0,
                  _translateButton.value * 6,
                  0.0,
                ),
                child: FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 112, 6, 145),
                  onPressed: () {/* Do something */},
                  child: const Icon(
                    Icons.wine_bar,
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(
                  0.0,
                  _translateButton.value * 5,
                  0.0,
                ),
                child: FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 212, 12, 243),
                  onPressed: () {/* Do something */},
                  child: const Icon(
                    Icons.icecream,
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(
                  0.0,
                  _translateButton.value * 4,
                  0.0,
                ),
                child: FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 234, 20, 17),
                  onPressed: () {/* Do something */},
                  child: const Icon(
                    Icons.dinner_dining,
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(
                  0,
                  _translateButton.value * 3,
                  0,
                ),
                child: FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 222, 92, 11),
                  onPressed: () {/* Do something */},
                  child: const Icon(
                    Icons.kebab_dining,
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(
                  0,
                  _translateButton.value * 2,
                  0,
                ),
                child: FloatingActionButton(
                  backgroundColor: Colors.amber,
                  onPressed: () {/* Do something */},
                  child: const Icon(Icons.local_bar),
                ),
              ),
              FloatingActionButton(
                onPressed: _toggle,
                backgroundColor: AppColors.secondary,
                child: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: _buttonAnimatedIcon,
                ),
              ),
            ],
          ),
          body: TabBarView(
            children: <Widget>[
              CardWidget(
                context,
                status: 0,
                filter: "00000000-0000-0000-0000-000000000000",
              ),
              CardWidget(
                context,
                status: 1,
                filter: "00000000-0000-0000-0000-000000000000",
              ),
              CardWidget(
                context,
                status: 2,
                filter: "00000000-0000-0000-0000-000000000000",
              ),
              const Icon(Icons.room_service),
            ],
          ),
        ),
    );
  }
}
