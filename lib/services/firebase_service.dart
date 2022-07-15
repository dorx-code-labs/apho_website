import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';

class StorageServices {
  launchSocialLink(
    String link,
    String lead,
  ) {
    String top;
    if (lead.startsWith("@")) {
      top = link.replaceFirst(RegExp(r'@'), "");

      top = "$lead$top";
    } else {
      if (link.startsWith("www")) {
        top = link;
      } else {
        top = lead;
      }
    }

    launchUrl(Uri.parse(top));
  }

  int getPrice(String priceText, {double deMoney}) {
    int price = deMoney == null
        ? double.parse(priceText.trim()).toInt()
        : deMoney.toInt();

    int pricetoShow = price;

    return pricetoShow;
  }

  decreaseCount(String top, String user) {
    FirebaseDatabase.instance.ref().child(top).child(user).once().then(
      (vav) {
        FirebaseDatabase.instance.ref().child(top).update(
          {
            user: vav.snapshot.value == null || vav.snapshot.value == 0
                ? 0
                : (vav.snapshot.value as int) - 1,
          },
        );
      },
    );
  }
}
