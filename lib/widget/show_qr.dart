import 'package:qr_flutter/qr_flutter.dart';
import 'package:sprint2/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:sprint2/widget/glass_card.dart';

void showMyQR(BuildContext context, HestaBitUser user) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: AspectRatio(
          aspectRatio: 3 / 4,
          child: GlassCard(
            // height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(20.0),
            borderRadius: BorderRadius.circular(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        "CLOSE QR",
                        textScaleFactor: 1.1,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: QrImage(
                    data: {
                      'name': user.name,
                      'phone': user.phone,
                      'mail': user.email,
                      'id': user.id,
                      'dept': user.dept,
                      'location': user.location,
                    }.toString(),
                    backgroundColor: Colors.white,
                    embeddedImage:
                        const AssetImage('assets/logo/Hestabit-Logo.png'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
