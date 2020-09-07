import 'package:flutter/material.dart';

class BarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final Function onTap;

  const BarItem({Key key, this.icon, this.title, this.isSelected, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color blueColor = const Color(0XFF04959A);
    const Color iconBackgroundColor = const Color(0xFF647082);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: isSelected ? blueColor : Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              color: isSelected ? Colors.white : iconBackgroundColor,
            ),
            if (isSelected)
              VerticalDivider(
                color: iconBackgroundColor,
              ),
            if (isSelected)
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
