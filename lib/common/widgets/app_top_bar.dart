import 'package:flutter/material.dart';
import 'package:spotify/common/helpers/navigation_utils.dart';
import 'package:spotify/common/helpers/theme_utils.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {

  final Widget? title;

  const AppTopBar({
    super.key,
    this.title
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: title ?? const Text(''),
        centerTitle: true,
        leading: IconButton(
            onPressed: () { context.back(); },
            icon: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: context.adaptiveOpaqueColor,
                shape: BoxShape.circle
              ),
              child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 20,
                  color: context.adaptiveTextColor
              ),
            )
        ),
      ),
    );
  }
}
