import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../app/config/app_colors.dart';

class CustomProgressDialog extends StatelessWidget {
  const CustomProgressDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.discreteCircle(
        color: AppColors.primaryRedColor, size: 40);
  }
}
