part of atoms;

abstract class BaseEditText extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? node;
  final EditTextDecoration? decoration;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;

  const BaseEditText(
      {Key? key,
      this.controller,
      this.node,
      this.decoration,
      this.onFieldSubmitted,
      this.onChanged})
      : super(key: key);
}

class EditTextDecoration {
  final String? hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final TextInputType? inputType;

  EditTextDecoration(
      {this.hintText,
      this.errorText,
      this.prefixIcon,
      this.suffixIcon,
      this.inputType,
      this.isPassword = false});
}
