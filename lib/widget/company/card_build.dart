import 'package:flutter/material.dart';
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
              itemCount: snapshot.data?.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return buildCard(snapshot.data![index]);
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

Card buildCard(Company company) {
  var heading = company.companyFantasyName ?? "";
  var subheading = company.companyName ?? "";
  var logo = company.logo ?? "";
  var cardImage = logo.isEmpty
      ? Text(Util.createInitials(heading))
      : Ink.image(image: NetworkImage(logo), fit: BoxFit.cover);
  var status = company.companyStatus ?? 1;
  IconData icon = status == 0 ? Icons.done : Icons.close;

  return Card(
      elevation: 4.0,
      child: Column(
        children: [
          ListTile(
            title: Text(heading),
            subtitle: Text(subheading),
            trailing: Icon(icon),
          ),
          SizedBox(
            height: 200.0,
            child: cardImage,
          ),
          ButtonBar(
            children: [
              TextButton(
                child: const Text('CONTACT AGENT'),
                onPressed: () {/* ... */},
              ),
              TextButton(
                child: const Text('LEARN MORE'),
                onPressed: () {/* ... */},
              )
            ],
          )
        ],
      ));
}
