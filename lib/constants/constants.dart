import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const double kAppHeight = 100;

const String mail = "tushansingh03@gmail.com";
const String phone = "(+91) 7710164491";
const String location = "Punjab, India";

class SocialMedia {
  final Widget image;
  final Function() onPress;

  const SocialMedia({
    required this.image,
    required this.onPress,
  });
}

final List<SocialMedia> socials = <SocialMedia>[
  SocialMedia(
    image: Image.asset("assets/images/instagram.png"),
    onPress: () async {
      final Uri instaUrl = Uri.parse(
          "https://instagram.com/_a_u_l_a_k_h__sahb?igshid=ZDdkNTZiNTM=");
      if (await canLaunchUrl(instaUrl)) {
        await launchUrl(instaUrl);
      }
    },
  ),
  SocialMedia(
    image: Image.asset("assets/images/linkedin.png"),
    onPress: () async {
      final Uri linkedInUrl =
          Uri.parse("https://www.linkedin.com/in/tushandeep-singh-15a5b622a/");
      if (await canLaunchUrl(linkedInUrl)) {
        await launchUrl(linkedInUrl);
      }
    },
  ),
  SocialMedia(
    image: Image.asset("assets/images/whatsapp.png"),
    onPress: () async {
      var contact = "+917710164491";
      var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Hi')}";

      if (await canLaunchUrl(Uri.parse(iosUrl))) {
        await launchUrl(Uri.parse(iosUrl));
      }
    },
  ),
  SocialMedia(
    image: const Icon(
      CupertinoIcons.mail,
      color: Colors.white,
      size: 40,
    ),
    onPress: () async {
      const String url = "mailto:$mail";
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    },
  ),
];
