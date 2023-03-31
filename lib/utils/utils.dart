import 'package:flutter/material.dart';
import 'package:qrscanner/models/scan.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL(BuildContext context, ScanModel scan) async {
  final Uri url = Uri.parse(scan.value); 
  if(scan.type == 'htpp'){
    await canLaunchUrl(url);
  }else if(!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
  else{
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, 'maps', arguments: scan);
  }
}