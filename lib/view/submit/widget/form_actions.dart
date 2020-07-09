import 'package:flutter/material.dart';
import 'package:sengyo/view/widget/app_colors.dart';

class FormActions extends StatelessWidget {
  final VoidCallback onBackTap;
  final VoidCallback onForwardTap;
  final VoidCallback onPauseTap;
  final String forwardText;
  final bool isLastForm;
  final bool isSubmitting;

  const FormActions({
    Key key,
    this.onBackTap,
    this.onForwardTap,
    this.onPauseTap,
    this.forwardText,
    this.isLastForm = false,
    this.isSubmitting = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final whiteSpaceWidth = 16 * 3;
    final forwardButtonWidth = (MediaQuery.of(context).size.width - whiteSpaceWidth) * 2 / 3;
    final backButtonWidth = MediaQuery.of(context).size.width - whiteSpaceWidth - forwardButtonWidth;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              RaisedButton(
                onPressed: onBackTap,
                padding: const EdgeInsets.all(0.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Container(
                  width: backButtonWidth,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.accent, width: 1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Center(
                    child: Text(
                      '戻る',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              RaisedButton(
                onPressed: onForwardTap,
                padding: const EdgeInsets.all(0.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Container(
                  width: forwardButtonWidth,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: onForwardTap == null ? Colors.black12 : isLastForm ? AppColors.theme : AppColors.accent,
                  ),
                  child: Center(
                    child: isSubmitting ? CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                    ) : Text(
                      forwardText,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // const SizedBox(height: 16),
          // InkWell(
          //   onTap: onPauseTap,
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 36, vertical: 8),
          //     child: Text(
          //       '保存して中断',
          //       style: TextStyle(fontSize: 16, color: AppColors.theme),
          //     ),
          //   ),
          // ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
