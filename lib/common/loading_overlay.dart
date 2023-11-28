import 'package:flutter/material.dart';
import 'package:hrms/common/app_colors.dart';

class LoadingOverlay {
  late OverlayEntry _overlay;
  bool isLoading = false;

  LoadingOverlay();

  void show(BuildContext context) {
    _overlay = OverlayEntry(
        builder: (context) => const ColoredBox(
              color: Colors.transparent,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                ),
              ),
            ));
    Overlay.of(context).insert(_overlay);
    isLoading = true;
  }

  void hide() {
    if (isLoading) {
      _overlay.remove();
      isLoading = false;
    }
  }
}
