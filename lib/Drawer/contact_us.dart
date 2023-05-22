import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../const.dart';
class ContactUs extends StatefulWidget {
  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  final Uri _url = Uri.parse('https://www.fiverr.com/share/pP0lD8');
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kAppBarColour,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Get in touch',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10.0),
                const Text(
                    "If you face any problem with this app you can contact with me",
                    style: TextStyle(
                        color: Color(0xFFA895D1),
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal)),
                const SizedBox(height: 30.0),
                TextButton(
                  onPressed: () async{
                    String telephoneNumber = '+923068745160';
                    String telephoneUrl = "tel:$telephoneNumber";
                    if (await canLaunch(telephoneUrl)) {
                    await launch(telephoneUrl);
                    } else {
                    throw "Error occured trying to call that number.";
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.phone, color: Color(0xFFED92A2)),
                      SizedBox(width: 20.0),
                      Text('+9230 6874 5160',
                          style: TextStyle(
                              color: Color(0xFFA294C2),
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () async{
                    String telephoneNumber = '+923068745160';
                    String smsUrl = "sms:$telephoneNumber";
                    if (await canLaunch(smsUrl)) {
                    await launch(smsUrl);
                    } else {
                    throw "Error occured trying to send a message that number.";
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.sms, color: Color(0xFFED92A2)),
                      SizedBox(width: 20.0),
                      Text('+9230 6874 5160',
                          style: TextStyle(
                              color: Color(0xFFA294C2),
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () async{
                    String email = 'Muhmmadwaqas449@gmail.com';
                    String subject = '';
                    String body = '';

                    String emailUrl = "mailto:$email?subject=$subject&body=$body";

                    if (await canLaunch(emailUrl)) {
                      await launch(emailUrl);
                    } else {
                      throw "Error occured sending an email";
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.mail, color: Color(0xFFED92A2)),
                      SizedBox(width: 20.0),
                      Text('Muhmmadwaqas449@gmail.com',
                          style: TextStyle(
                              color: Color(0xFFA294C2),
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _launchUrl();
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.child_friendly_outlined, color: Color(0xFFED92A2)),
                      SizedBox(width: 20.0),
                      Text('Fiverr Profile',
                          style: TextStyle(
                              color: Color(0xFFA294C2),
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
