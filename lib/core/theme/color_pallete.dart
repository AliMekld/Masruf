import 'package:flutter/cupertino.dart';
import 'package:masrof/core/theme/theme_model.dart';
import 'package:masrof/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class ColorsPalette extends ThemeModel {
  /// inherted widget to get currnet app theme based on brightness
   static ThemeModel of(BuildContext context) =>
      Provider.of<ThemeProvider>(context).appTheme;

  ///==============================>>[dark_palette]<<=================================///
  ColorsPalette.dark({
    super.isDark = true,
    super.primaryColor = const Color(0xffCB96FF),      
    super.secondaryColor = const Color(0xffA78F66),    
    super.backgroundColor = const Color(0xff121212),   
    super.surfaceColor = const Color(0xff1E1E1E),      
    super.primaryTextColor = const Color(0xffE0E0E0),  
    super.secondaryTextColor = const Color(0xffA0A0A0),
    super.errorColor = const Color(0xffCF6679),        
    super.buttonColor = const Color(0xff03DAC5),       
    super.buttonDisabledColor = const Color(0xff3E3E3E),
    super.dividerColor = const Color(0xff282828),      
    super.iconColor = const Color(0xffA0A0A0),         
    super.successColor = const Color(0xff27A745),      
    super.watingColor = const Color(0xffFFD600),       
});

  ///==============================>>[dark_palette]<<=================================///
 ColorsPalette.light({
    super.isDark = false,
    super.primaryColor = const Color(0xffCB96FF),       
    super.secondaryColor = const Color(0xffD1B894),     
    super.backgroundColor = const Color(0xffFDFDFD),    
    super.surfaceColor = const Color(0xffffffff),       
    super.primaryTextColor = const Color(0xff000000),   
    super.secondaryTextColor = const Color(0xff757575), 
    super.errorColor = const Color(0xffB00020),         
    super.buttonColor = const Color(0xff6200EE),        
    super.buttonDisabledColor = const Color(0xffBDBDBD),
    super.dividerColor = const Color(0xffBDBDBD),       
    super.iconColor = const Color(0xff757575),          
    super.successColor = const Color(0xff27A745),       
    super.watingColor = const Color(0xffFFC107),       
});
}