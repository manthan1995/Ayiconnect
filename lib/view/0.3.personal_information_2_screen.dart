import 'package:flutter/material.dart';
import 'package:profile_demo/main.dart';
import 'package:profile_demo/model/user_model.dart';
import 'package:profile_demo/utils/common_methods.dart';
import 'package:profile_demo/view/0.0.profile_setup_screen.dart';
import 'package:profile_demo/widgets/textfield_header.dart';

import '../constant/text_style_decoration.dart';
import '../model/milestone_model.dart';

class PersonalInformation2Screen extends StatefulWidget {
  const PersonalInformation2Screen({
    super.key,
    required this.pageController,
    required this.onNextPage,
  });

  final PageController pageController;
  final VoidCallback onNextPage;

  @override
  State<PersonalInformation2Screen> createState() =>
      _PersonalInformation2ScreenState();
}

class _PersonalInformation2ScreenState
    extends State<PersonalInformation2Screen> {
  //------------------------------------------------------------------ Variables -----------------------------------------------------------------//
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode? autovalidateMode = AutovalidateMode.disabled;

  //--------------------------------------------------------------------- UI ---------------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          right: 15.0,
          left: 15.0,
          top: 15.0,
          bottom: 35.0,
        ),
        child: Form(
          key: _formKey,
          autovalidateMode: autovalidateMode,
          child: Wrap(
            runSpacing: 20.0,
            children: [
              // Occupation...
              TextfieldHeader(
                title: "Occupation",
                child: TextFormField(
                  textCapitalization: TextCapitalization.words,
                  validator: (text) => text?.validateOccupation,
                  decoration: const InputDecoration(
                    hintText: "Add your occupation",
                  ),
                ),
              ),
              // Company...
              TextfieldHeader(
                title: "Company",
                child: TextFormField(
                  textCapitalization: TextCapitalization.words,
                  validator: (text) => text?.validateCompannyName,
                  decoration: const InputDecoration(
                    hintText: "Add your company name",
                  ),
                ),
              ),
              // Fluently spoken language(s)...
              _buildLanguage(context),
              // Prefered Service...
              _buildPerferService(context),
              // Tell us about you...
              TextfieldHeader(
                title: "Tell us about you*",
                child: Container(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  decoration: defaultBoxDecoration,
                  child: TextFormField(
                    maxLines: 4,
                    maxLength: 100,
                    validator: (text) => text?.validatDescription,
                    decoration: const InputDecoration(
                      counterStyle: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.grey),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(15.0),
                      hintText:
                          "Provide some brief about yourself, so helper can get to know your a litle better before your connection.",
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              // Submit button....
              SizedBox(
                height: 45.0,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: onSubmittButton,
                  child: Text(
                    "Submit",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //--------------------------------------------------------------- Helper Widgets ---------------------------------------------------------------//
  // Language button...
  TextfieldHeader _buildLanguage(BuildContext context) {
    return TextfieldHeader(
      title: "Fluently spoken language(s) *",
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 0.0,
          right: 12.0,
          left: 12.0,
        ),
        decoration: defaultBoxDecoration,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<LanguageModel>(
            icon: Icon(
              Icons.add_circle_outline_rounded,
              color: Colors.grey.withOpacity(0.7),
            ),
            hint: Text(
              "Add language",
              style: TextStyleDecoration.hintTextStyle,
            ),
            value: userInfo.language
                    .firstWhere(
                      (language) => language.isSelected,
                      orElse: () => LanguageModel(),
                    )
                    .name
                    .isEmpty
                ? null
                : userInfo.language.firstWhere(
                    (language) => language.isSelected,
                    orElse: () => LanguageModel(),
                  ),
            isExpanded: true,
            iconSize: 30.0,
            style: const TextStyle(color: Colors.blue),
            items: userInfo.language.map(
              (languagae) {
                return DropdownMenuItem<LanguageModel>(
                  value: languagae,
                  child: Text(
                    languagae.name,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                );
              },
            ).toList(),
            onChanged: (LanguageModel? val) {
              setState(() {
                for (var lang in userInfo.language) {
                  lang.isSelected = lang.id == val?.id;
                }
              });
            },
          ),
        ),
      ),
    );
  }

  // Prefer serivce...
  TextfieldHeader _buildPerferService(BuildContext context) {
    return TextfieldHeader(
      title: "Prefered Service",
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 0.0,
          right: 12.0,
          left: 12.0,
        ),
        decoration: defaultBoxDecoration,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<LanguageModel>(
            icon: Icon(
              Icons.arrow_drop_down_rounded,
              color: Colors.grey.withOpacity(0.7),
            ),
            hint: Text(
              "Add your prefered service",
              style: TextStyleDecoration.hintTextStyle,
            ),
            value: userInfo.preferedService
                    .firstWhere(
                      (service) => service.isSelected,
                      orElse: () => LanguageModel(),
                    )
                    .name
                    .isEmpty
                ? null
                : userInfo.preferedService.firstWhere(
                    (service) => service.isSelected,
                    orElse: () => LanguageModel(),
                  ),
            isExpanded: true,
            iconSize: 30.0,
            style: const TextStyle(color: Colors.blue),
            items: userInfo.preferedService.map(
              (service) {
                return DropdownMenuItem<LanguageModel>(
                  value: service,
                  child: Text(
                    service.name,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                );
              },
            ).toList(),
            onChanged: (LanguageModel? val) {
              setState(() {
                for (var lang in userInfo.preferedService) {
                  lang.isSelected = lang.id == val?.id;
                }
              });
            },
          ),
        ),
      ),
    );
  }

  //--------------------------------------------------------------- Button actions ---------------------------------------------------------------//
  void onSubmittButton() {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_formKey.currentState?.validate() ?? false) {
      if (userInfo.language
              .firstWhere((element) => element.isSelected,
                  orElse: () => LanguageModel())
              .isSelected ==
          false) {
        var snackBar = SnackBar(
          backgroundColor: Colors.orange.shade200,
          content: Text(
            "Please select one language",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (userInfo.preferedService
              .firstWhere((element) => element.isSelected,
                  orElse: () => LanguageModel())
              .isSelected ==
          false) {
        var snackBar = SnackBar(
          backgroundColor: Colors.orange.shade200,
          content: Text(
            "Please select one service",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        var snackBar = SnackBar(
          backgroundColor: Colors.orange.shade200,
          content: Text(
            "Form submitted successfully",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        milestones[2].isCompleted = true;
        widget.onNextPage();
        widget.pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        milestones = milestonlist;
        userInfo = getDefaultUserInfo;
      }
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }
}

extension RemoveSpecialcharacter on String {
  // Remove Special character from string...
  String get removeSpecialCharacters =>
      trim().replaceAll(RegExp(r'[^A-Za-z0-9]'), '');

  //Validate company name...
  String? get validateCompannyName =>
      trim().isEmpty ? "Enter company name" : null;

  //Validate occupation name...
  String? get validateOccupation =>
      trim().isEmpty ? "Enter your occupation" : null;

  //Validate language...
  String? get validateLanguage =>
      trim().isEmpty ? "Select your language" : null;

  //Validate service...
  String? get validateService => trim().isEmpty ? "Select your service" : null;

  //Validate description...
  String? get validatDescription =>
      trim().isEmpty ? "Enter something about you" : null;
}
