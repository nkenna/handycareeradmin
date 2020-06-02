import 'package:flutter/material.dart';

class DesktopNavbar extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return 
    Container(
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
              SizedBox(
                width: 30
              ),

              MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                color: Color(0xFF2fcc76),
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                onPressed: (){

                },
              )

              
            ],
          ),
        
      ),
    );
  
  }
}