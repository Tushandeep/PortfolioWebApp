class NavItem {
  final String label;
  final Function() onPress;
  final int value;

  NavItem({
    required this.label,
    required this.onPress,
    required this.value,
  });
}

final List<NavItem> navItems = <NavItem>[
  NavItem(
    label: "Home",
    onPress: () {},
    value: 0,
  ),
  NavItem(
    label: "About",
    onPress: () {},
    value: 1,
  ),
  NavItem(
    label: "Skills",
    onPress: () {},
    value: 2,
  ),
  NavItem(
    label: "Experience",
    onPress: () {},
    value: 3,
  ),
  NavItem(
    label: "Contact",
    onPress: () {},
    value: 4,
  ),
];
