import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String leadingIcon;
  final bool trailingIcon;
  final VoidCallback? onTap;

  const CustomListTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    this.trailingIcon = true, // Default to true
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 2,
                blurRadius: 5,
                blurStyle: BlurStyle.outer,
              ),
            ],
          ),
          child: ListTile(
            leading: SvgPicture.asset(leadingIcon),
            title: Text(title),
            subtitle: trailingIcon ? Text(subtitle) : null,
            trailing: trailingIcon
                ? SvgPicture.asset('assets/svgs/forward_arrow.svg')
                : const SizedBox(),
          ),
        ),
      ),
    );
  }
}
