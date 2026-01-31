import 'package:flutter/material.dart';
  class AppButton extends StatelessWidget {
   final String text;
   final VoidCallback onPressed;
   final Color? color;
   final bool useThemeColor;
   final IconData? icon;


  const AppButton( {
  super.key,
  required this.text,
  required this.onPressed,
  this.color,
  this.useThemeColor = false,
  this.icon,
   });


          @override
        Widget build(BuildContext context) {
         return SizedBox(
          height: 48,
            child: ElevatedButton(
             style: ElevatedButton.styleFrom(
             backgroundColor: useThemeColor? 
             Theme.of(context).colorScheme.primary:
             (color ?? Theme.of(context).colorScheme.primary),
             shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
         ),
        ),
         onPressed: onPressed,
           child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(icon != null)...[
                Container(
                  width: 24.0,
                  height: 24.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: Icon(icon, size: 16.0,
                  color: color ?? Colors.black87,
                  ),
                  ),
                const SizedBox(width: 8.0),

              ],
              Text(text,
              style: const TextStyle(fontWeight:FontWeight.w600),),
            ],
           ),
          ),
         );
        }
        }