import 'package:flutter/material.dart';
import 'package:sengyo/view/submit/submit_cook_scene.dart';
import 'package:sengyo/view/submit/widget/form_actions.dart';
import 'package:sengyo/view/submit/widget/multipleline_text_field.dart';
import 'package:sengyo/view/widget/app_text_style.dart';

class SubmitCutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Text('ひとこと', style: AppTextStyle.label),
                  const SizedBox(height: 8),
                  MultipleLineTextField(isRequired: false),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.black12,
              child: Center(
                child: Icon(Icons.add_a_photo, color: Colors.black54, size: 54,)
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('注意すること', style: AppTextStyle.label),
                  const SizedBox(height: 8),
                  MultipleLineTextField(isRequired: false),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(height: 32),
            FormActions(
              onBackTap: () => Navigator.pop(context),
              onForwardTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitCookScene())),
              onPauseTap: () {},
              forwardText: '食べ方に進む',
            ),
          ],
        ),
      ),
    );
  }
}