import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sengyo/bloc/submit_cut_bloc.dart';
import 'package:sengyo/view/submit/submit_cook_scene.dart';
import 'package:sengyo/view/submit/widget/form_actions.dart';
import 'package:sengyo/view/submit/widget/multipleline_text_field.dart';
import 'package:sengyo/view/submit/widget/pickup_photo.dart';
import 'package:sengyo/view/widget/app_text_style.dart';

class SubmitCutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SubmitCutBloc>(
      builder: (context, submitCutBloc, child) => Scaffold(
        appBar: AppBar(
          title: Text('捌き方について'),
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
                    Text(
                      '注意すること', 
                      style: AppTextStyle.label,
                    ),
                    const SizedBox(height: 8),
                    MultipleLineTextField(
                      isRequired: false, 
                      controller: submitCutBloc.cautionController,
                      hint: '「トゲが鋭い」「毒がある」「寄生虫が入りやすい」など、捌いて食べる上で注意すべき点',
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
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
                      controller: submitCutBloc.memoController,
                      hint: '捌いた時の様子を詳しく教えてください',
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              PickupPhoto(
                onTap: submitCutBloc.pickupImage,
                data: submitCutBloc.cutImageData,
              ),
              const SizedBox(height: 32),
              FormActions(
                onBackTap: () => Navigator.pop(context),
                onForwardTap: () async {
                  final document = await submitCutBloc.submit();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitCookScene(document: document)));
                },
                onPauseTap: () {},
                forwardText: '食べ方に進む',
              ),
            ],
          ),
        ),
      ),
    );
  }
}