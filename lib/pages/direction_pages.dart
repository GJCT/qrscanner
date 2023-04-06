import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/providers/scan_provider.dart';
import 'package:qrscanner/utils/utils.dart';

class DirectionPage extends StatelessWidget {
  const DirectionPage({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanProvider = Provider.of<ScanListProvider>(context);

    return ListView.builder(
      itemCount: scanProvider.scan.length,
      itemBuilder: ( _, i)=> Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (DismissDirection direction) {
          Provider.of<ScanListProvider>(context, listen: false).borrarScanById(scanProvider.scan[i].id);
        },
        child: ListTile(
          leading: Icon(Icons.home, color: Theme.of(context).primaryColor),
          title: Text(scanProvider.scan[i].value),
          subtitle: Text(scanProvider.scan[i].id.toString()),
          trailing: const Icon(Icons.keyboard_arrow_right_sharp, color: Colors.grey),
          onTap: () => launchURL(context, scanProvider.scan[i]),
        ),
      )
    );
  }
}