import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  final Color? color;
  final Widget? icon;
  final IconData? iconData;
  final void Function()? onTap;
  const CircleIconButton({
    Key? key,
    this.color,
    this.icon,
    this.onTap,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color ?? Theme.of(context).colorScheme.primary),
      child: InkWell(
        onTap: onTap,
        child: icon ??
            Icon(
              iconData ?? Icons.holiday_village,
              color: Colors.white,
            ),
      ),
    );
  }
}
