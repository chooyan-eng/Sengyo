import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sengyo/bloc/submit_cook_bloc.dart';
import 'package:sengyo/view/submit/widget/form_actions.dart';
import 'package:sengyo/view/submit/widget/multipleline_text_field.dart';
import 'package:sengyo/view/submit/widget/pickup_photo.dart';
import 'package:sengyo/view/submit/widget/singleline_text_field.dart';
import 'package:sengyo/view/widget/app_text_style.dart';

class SubmitCookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SubmitCookBloc>(
      builder: (context, submitCookBloc, child) => Scaffold(
        appBar: AppBar(
          title: Text('食べ方について'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('食べ方', style: AppTextStyle.label),
                    const SizedBox(height: 8),
                    SingleLineTextField(
                      isRequired: true,
                      controller: submitCookBloc.nameController,
                      hint: '刺身',
                      onChanged: (value) => submitCookBloc.callNotifyListeners(),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              PickupPhoto(
                onTap: submitCookBloc.pickupImage,
                data: submitCookBloc.cookImageData,
                isProcessing: submitCookBloc.isProcessingImage,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('ひとこと', style: AppTextStyle.label),
                    const SizedBox(height: 8),
                    MultipleLineTextField(
                      isRequired: false,
                      controller: submitCookBloc.memoController,
                      hint: '味や盛り付けはどうでしたか？',
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              FormActions(
                onBackTap: () => Navigator.pop(context),
                onForwardTap: submitCookBloc.isSubmittable && !submitCookBloc.isSubmitting ? () async {
                  await submitCookBloc.submit();
                  Navigator.popUntil(
                      context, (route) => !route.navigator.canPop());
                } : null,
                onPauseTap: () {},
                forwardText: '投稿する',
                isLastForm: true,
                isSubmitting: submitCookBloc.isSubmitting,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
