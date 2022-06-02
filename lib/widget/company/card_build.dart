import 'package:flutter/material.dart';
import 'package:nabandeja/assets/themes/app_colors.dart';
import 'package:nabandeja/assets/themes/app_images.dart';
import '../../model/company.dart';
import '../../service/util.dart';
import './methods.dart';

class CardWidget extends StatelessWidget {
  final Methods _methods = Methods();
  CardWidget(BuildContext context, {Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return FutureBuilder<List<Company>>(
        future: _methods.loadCompany(),
        builder: (context, AsyncSnapshot<List<Company>> snapshot) {
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

Container buildCard(Company company, BuildContext context) {
  final Methods methods = Methods();
  var heading = company.companyFantasyName ?? "";
  var subheading = company.companyName ?? "";

  return Container(
    height: 212.0,
    margin: const EdgeInsets.all(10.0),
    child: GestureDetector(
      onTap: () {
        methods.goHome(company, context);
      },
      child: Card(
        shape: BeveledRectangleBorder(
          side: const BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        elevation: 4.0,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Container(
                  height: 100,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: AssetImage(AppImages.backgroundCompany),
                      fit: BoxFit.cover,
                    ),
                    color: AppColors.lightGrey,
                  ),
                  padding: const EdgeInsets.all(2),
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    transform: Matrix4.translationValues(0.0, 30.0, 0.0),
                    alignment: const FractionalOffset(0.0, 0.0),
                    decoration: const BoxDecoration(
                      color: AppColors.lightGrey,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        Util.createInitials(heading),
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              alignment: Alignment.center,
              child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        heading,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Text(
                        subheading,
                        style: const TextStyle(
                          color: AppColors.grey,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 76),
                      child: const Text(
                        'Ativo',
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ]),
              // ListTile(
              //   title: Text(heading),
              //   subtitle: Text(subheading),
              //   trailing: Icon(icon),
              // ),
            ),
          ],
        ),
      ),
    ),
  );
}
