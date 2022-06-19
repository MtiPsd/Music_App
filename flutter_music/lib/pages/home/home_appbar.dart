import 'package:flutter_neumorphic/flutter_neumorphic.dart';
//*****

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSize appbar;
  final Widget title;
  final List<Widget> actions;
  final Color backgroundColor;
  final Widget? child;

  const MyAppBar({
    Key? key,
    required this.appbar,
    required this.title,
    required this.actions,
    required this.backgroundColor,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      titleSpacing: 40,
      actions: actions,
      backgroundColor: backgroundColor,
      elevation: 0,
      toolbarHeight: 120,
      automaticallyImplyLeading: false,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(double.infinity),
        child: child!,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appbar.preferredSize.height);
}
