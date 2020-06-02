import 'package:flutter/material.dart';

class MobileNavbar extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
          child: Container(
        color: Colors.white10,
        
        
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Handy Careers",
                  style: TextStyle(
                    color: Color(0xFF2fcc76),
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold 
                  ),
                ),
               

                
              ],
            ),
          ),

      ),
    );
  
  }
}