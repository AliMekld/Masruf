import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masrof/utilites/extensions.dart';

import '../../gen/assets.gen.dart';

class SplashScreen extends StatefulWidget {
  static const String routerName = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffCB96FF).withOpacity(0.2),
        body: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
               const Spacer(),
                SvgPicture.asset(
                  Assets.images.appLogo,
                  width: 240.r,
                  height: 240.r,
                ),
                16.0.heightBox,
                Text(
                  'masruf'.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'Agbalumo',
                    letterSpacing: 8,
                    color: const Color(
                      0xffCB96FF,
                    ),
                    fontSize: 24.sp,
                  ),
                ),
                16.h.heightBox,
                CircularProgressIndicator(
                  color:const Color(0xffCB96FF),
                  strokeWidth: 6.r,
                  strokeAlign: 0.2.r,
                  strokeCap: StrokeCap.round,
                ),
                const Spacer(),
                Text(
                  'version 1.0'.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'Agbalumo',
                    letterSpacing: 4,
                    fontWeight: FontWeight.normal,
                    color: const Color(
                      0xffCB96FF,
                    ),
                    fontSize: 8.r,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
