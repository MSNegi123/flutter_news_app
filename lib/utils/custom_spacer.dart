import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension Box on num {
  SizedBox bh() {
    return SizedBox(
      height: this * 1.h,
    );
  }

  SizedBox bw() {
    return SizedBox(
      width: this * 1.w,
    );
  }
}