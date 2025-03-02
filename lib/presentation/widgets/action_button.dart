import "../../utils/main_imports.dart";

class ActionButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? margin;

  const ActionButton({super.key, required this.iconData, this.onPressed, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.strongWhite,
        border: Border.all(color: AppColors.strongGrey),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            color: AppColors.lightBlack,
            blurRadius: 2,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(iconData, color: AppColors.strongBlack),
        onPressed: onPressed,
      ),
    );
  }
}