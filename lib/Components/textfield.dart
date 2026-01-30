import 'package:flutter/material.dart';
class AppTextField extends StatefulWidget {
final String label;
final String hint;
final bool obscureText;
final TextEditingController? controller; 



const AppTextField({
super.key,
required this.label,
required this.hint,
this.obscureText = false,
this.controller,
});

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool obscure;
  @override
  void initState(){
    super.initState();
    obscure =widget.obscureText;
  }
     @override
Widget build(BuildContext context) {
return Container(
  child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(widget.label, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
             
          TextField( 
            controller: widget.controller,
              obscureText: obscure,
              decoration: InputDecoration(
               hintText: widget.hint,
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                    ),
                    suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      obscure ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                  )
                : null,
                    ),
                       ),
                ],
              ),
);
          }
}