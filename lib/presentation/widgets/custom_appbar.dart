import "../../utils/main_imports.dart";

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  const CustomAppbar({super.key, required this.title, this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: showBackButton
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_outlined,
                color: AppColors.strongWhite,
              ),
              iconSize: 20.w,
            )
          : null,
      title: Text(
        title,
        style: TextStyle(color: AppColors.strongWhite, fontSize: 20.sp, fontWeight: FontWeight.w800),
      ),
      backgroundColor: AppColors.primary,
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, kToolbarHeight);
}
