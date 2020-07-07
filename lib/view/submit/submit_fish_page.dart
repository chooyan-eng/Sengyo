import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sengyo/bloc/submit_fish_bloc.dart';
import 'package:sengyo/view/submit/submit_cut_scene.dart';
import 'package:sengyo/view/submit/widget/form_actions.dart';
import 'package:sengyo/view/submit/widget/multipleline_text_field.dart';
import 'package:sengyo/view/submit/widget/singleline_text_field.dart';
import 'package:sengyo/view/widget/app_text_style.dart';

class SubmitFishPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SubmitFishBloc>(
      builder: (context, submitFishBloc, child) => Scaffold(
        appBar: AppBar(
          title: Text('お魚について'),
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
                    Text('お魚の名前', style: AppTextStyle.label),
                    const SizedBox(height: 8),
                    SingleLineTextField(isRequired: true, controller: submitFishBloc.nameController),
                    const SizedBox(height: 16),
                    Text('手に入れた場所', style: AppTextStyle.label),
                    const SizedBox(height: 8),
                    SingleLineTextField(isRequired: true, controller: submitFishBloc.placeController),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              InkWell(
                onTap: submitFishBloc.pickupImage,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.black12,
                  child: submitFishBloc.fishImageData == null ? Center(
                    child: Icon(Icons.add_a_photo, color: Colors.black54, size: 54,)
                  ) : Image.memory(submitFishBloc.fishImageData, fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('ひとこと', style: AppTextStyle.label),
                    const SizedBox(height: 8),
                    MultipleLineTextField(isRequired: false, controller: submitFishBloc.memoController),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              FormActions(
                onBackTap: () => Navigator.pop(context),
                onForwardTap: () async {
                  final document = await submitFishBloc.submit();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitCutScene()));
                },
                onPauseTap: () {},
                forwardText: '捌き方に進む',
              ),
            ],
          ),
        ),
      ),
    );
  }
}