import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sengyo/bloc/submit_fish_bloc.dart';
import 'package:sengyo/view/submit/submit_cut_scene.dart';
import 'package:sengyo/view/submit/widget/form_actions.dart';
import 'package:sengyo/view/submit/widget/multipleline_text_field.dart';
import 'package:sengyo/view/submit/widget/pickup_photo.dart';
import 'package:sengyo/view/submit/widget/singleline_text_field.dart';
import 'package:sengyo/view/widget/app_text_style.dart';

class SubmitFishPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SubmitFishBloc>(
      builder: (context, submitFishBloc, child) => Scaffold(
        appBar: AppBar(
          title: Text('食材について'),
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
                    Text('食材の名前', style: AppTextStyle.label),
                    const SizedBox(height: 8),
                    SingleLineTextField(
                      isRequired: true,
                      controller: submitFishBloc.nameController,
                      hint: 'マダイ',
                      onChanged: (value) => submitFishBloc.callNotifyListeners(),
                    ),
                    const SizedBox(height: 16),
                    Text('手に入れた場所', style: AppTextStyle.label),
                    const SizedBox(height: 8),
                    SingleLineTextField(
                      isRequired: true,
                      controller: submitFishBloc.placeController,
                      hint: '近所のスーパーで',
                      onChanged: (value) => submitFishBloc.callNotifyListeners(),
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '手に入れました',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              PickupPhoto(
                onTap: submitFishBloc.pickupImage,
                data: submitFishBloc.fishImageData,
                isProcessing: submitFishBloc.isProcessingImage,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('メモ', style: AppTextStyle.label),
                    const SizedBox(height: 8),
                    MultipleLineTextField(
                      isRequired: false,
                      controller: submitFishBloc.memoController,
                      hint: 'この食材について詳しく教えてください',
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              FormActions(
                onBackTap: () => Navigator.pop(context),
                onForwardTap: submitFishBloc.isSubmittable && !submitFishBloc.isSubmitting ? () async {
                  final document = await submitFishBloc.submit();
                  submitFishBloc.document = document;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubmitCutScene(document: document),
                    ),
                  );
                } : null,
                onPauseTap: () {},
                forwardText: '捌き方に進む',
                isSubmitting: submitFishBloc.isSubmitting,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
