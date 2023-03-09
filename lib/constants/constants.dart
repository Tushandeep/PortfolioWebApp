import 'package:flutter/material.dart';

const double kAppHeight = 100;

class SocialMedia {
  final Image image;
  final Function() onPress;

  const SocialMedia({
    required this.image,
    required this.onPress,
  });
}

final List<SocialMedia> socials = <SocialMedia>[
  SocialMedia(
    image: Image.asset("assets/images/instagram.png"),
    onPress: () {},
  ),
  SocialMedia(
    image: Image.asset("assets/images/linkedin.png"),
    onPress: () {},
  ),
  SocialMedia(
    image: Image.asset("assets/images/whatsapp.png"),
    onPress: () {},
  ),
];
