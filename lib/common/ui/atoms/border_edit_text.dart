part of atoms;

class BorderEditText extends BaseEditText {
  const BorderEditText({
    Key? key,
    TextEditingController? controller,
    FocusNode? node,
    EditTextDecoration? decoration,
    void Function(String)? onFieldSubmitted,
    void Function(String)? onChanged,
  }) : super(
            key: key,
            controller: controller,
            node: node,
            decoration: decoration,
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted);
  static final _border =
      OutlineInputBorder(borderRadius: BorderRadius.circular(27.5));
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: node,
      decoration: InputDecoration(
        errorText: decoration?.errorText,
        prefixIcon: decoration?.prefixIcon,
        border: BorderEditText._border,
      ),
      keyboardType: decoration?.inputType,
      obscureText: decoration?.isPassword ?? false,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
    );
  }
}
