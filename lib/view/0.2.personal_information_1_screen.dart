import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:profile_demo/constant/img_name.dart';
import 'package:profile_demo/model/user_model.dart';
import 'package:profile_demo/utils/common_methods.dart';
import 'package:profile_demo/widgets/image_picker_button.dart';
import 'package:profile_demo/widgets/textfield_header.dart';

import '../constant/custom_color.dart';
import '../main.dart';
import '../utils/app_permissions_service.dart';
import '../widgets/cust_image.dart';
import '../widgets/custom_alert.dart';
import '0.0.profile_setup_screen.dart';

class PersonalInformation1Screen extends StatefulWidget {
  const PersonalInformation1Screen({
    super.key,
    required this.pageController,
    required this.onNextPage,
  });

  final PageController pageController;
  final VoidCallback onNextPage;

  @override
  State<PersonalInformation1Screen> createState() =>
      _PersonalInformation1ScreenState();
}

class _PersonalInformation1ScreenState
    extends State<PersonalInformation1Screen> {
  //------------------------------------------------------------------ Variables -----------------------------------------------------------------//
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode? autovalidateMode = AutovalidateMode.disabled;

  //--------------------------------------------------------------------- UI ---------------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          autovalidateMode: autovalidateMode,
          child: Wrap(
            runSpacing: 20.0,
            children: [
              // Profile Photo...
              _buildProfileImage(context),
              const Divider(height: 1.0),
              const SizedBox(height: 10.0),
              const Divider(height: 1.0),

              // Full name...
              TextfieldHeader(
                title: 'Full Name',
                child: TextFormField(
                  textCapitalization: TextCapitalization.words,
                  validator: (text) => text?.validateName,
                  decoration: const InputDecoration(hintText: 'Your Fullname'),
                ),
              ),
              // Gender...
              _buildGender(context),
              // Date of birth...
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  _selectDate();
                },
                child: TextfieldHeader(
                  title: 'Choose Your Date of Birth ',
                  child: TextFormField(
                    enabled: false,
                    controller: dateOfBirthController,
                    validator: (text) => text?.validateDOB,
                    onTap: () {},
                    decoration: const InputDecoration(
                      hintText: 'MM/DD/YYYY',
                      suffixIcon: Icon(
                        Icons.calendar_month,
                      ),
                    ),
                  ),
                ),
              ),
              // Phone number...
              TextfieldHeader(
                title: 'Phone Number',
                child: SizedBox(
                  height: 48.0,
                  child: _buildPhoneFiled(),
                ),
              ),
              // Location...
              TextfieldHeader(
                title: 'Current Location*',
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: userCurrentLocationTapAction,
                  child: TextFormField(
                    enabled: false,
                    controller: locationController,
                    validator: (text) => text?.validateLocation,
                    decoration: const InputDecoration(
                      hintText: 'Find your location here',
                    ),
                  ),
                ),
              ),
              // Next button....
              SizedBox(
                height: 45.0,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: onNextButton,
                  child: Text(
                    "Next",
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
  TextfieldHeader _buildGender(BuildContext context) {
    return TextfieldHeader(
      title: 'Select Your Gender',
      child: Row(
        children: userInfo.gender
            .map(
              (genderInfo) => InkWell(
                onTap: () {
                  setState(() {
                    for (var gen in userInfo.gender) {
                      gen.isSelected = gen.gender == genderInfo.gender;
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: userInfo.gender
                                    .firstWhere(
                                      (gender) => gender.isSelected,
                                      orElse: () => userInfo.gender.first,
                                    )
                                    .id ==
                                genderInfo.id
                            ? Colors.transparent
                            : Colors.grey.withOpacity(0.4),
                      ),
                      color: userInfo.gender
                                  .firstWhere(
                                    (gender) => gender.isSelected,
                                    orElse: () => userInfo.gender.first,
                                  )
                                  .id ==
                              genderInfo.id
                          ? ConstantColor.ffff9266
                          : Colors.transparent,
                    ),
                    child: Row(
                      children: [
                        Radio<GenderModel>(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: genderInfo,
                          activeColor: Colors.white,
                          groupValue: userInfo.gender.firstWhere(
                            (gender) => gender.isSelected,
                            orElse: () => userInfo.gender.first,
                          ),
                          onChanged: (gender) {
                            setState(() {
                              for (var gen in userInfo.gender) {
                                gen.isSelected = gen.gender == gender?.gender;
                              }
                            });
                          },
                        ),
                        Text(
                          genderInfo.gender,
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: userInfo.gender
                                                .firstWhere(
                                                  (gender) => gender.isSelected,
                                                  orElse: () =>
                                                      userInfo.gender.first,
                                                )
                                                .id ==
                                            genderInfo.id
                                        ? Colors.white
                                        : null,
                                  ),
                        ),
                        const SizedBox(width: 10.0),
                      ],
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  // Profile image...
  ImagePickerButton _buildProfileImage(BuildContext context) {
    return ImagePickerButton(
      onImageSelected: (image) {
        setState(() {
          userInfo.profileUrl = image.first;
        });
      },
      child: Row(
        children: [
          CustImage(
            imgURL: userInfo.profileUrl,
            cornerRadius: 100 / 2,
            errorImage: ImgName.noProfile,
            height: 100.0,
            width: 100.0,
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    enabled: false,
                    initialValue: 'Add profile photo',
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.add_circle_outline_rounded,
                        color: Colors.grey.withOpacity(0.35),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  "Add a profile to make it more personal. It makes a difference!",
                  style: Theme.of(context)
                      .textTheme
                      .overline
                      ?.copyWith(color: Colors.black87),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // Country code with phone number textField...
  Widget _buildPhoneFiled() {
    return Container(
      decoration: defaultBoxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Country Code...
          Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 1.0,
                  color: Colors.grey.withOpacity(0.35),
                ),
              ),
            ),
            child: SizedBox(
              width: 80.0,
              child: CountryCodePicker(
                padding: const EdgeInsets.all(0.0),
                onChanged: (CountryCode code) {},
                showCountryOnly: false,
                hideSearch: true,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
                showFlag: false,
                flagWidth: 25.0,
                initialSelection: "ID",
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          // Phone Number...
          Expanded(
            child: TextFormField(
              cursorColor: Colors.black,
              autofillHints: const [AutofillHints.telephoneNumber],
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              inputFormatters: [
                MaskedInputFormatter("000-000-0000"),
              ],
              onChanged: (text) {
                userInfo.phoneNumber = text;
              },
              decoration: const InputDecoration(
                counter: SizedBox(),
                contentPadding: EdgeInsets.only(top: 0.0),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //-------------------------------------------------------------- Helper Functions --------------------------------------------------------------//
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: userInfo.dateOfBirth ?? DateTime.now(),
        firstDate: DateTime(1800, 1, 1),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: ConstantColor.ffE5E7EB,
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              colorScheme:
                  ColorScheme.light(primary: ConstantColor.ffE5E7EB).copyWith(
                secondary: ConstantColor.ffE5E7EB,
              ),
            ),
            child: child!,
          );
        });
    if (picked != null && picked != userInfo.dateOfBirth) {
      setState(() {
        userInfo.dateOfBirth = picked;
        dateOfBirthController.text = DateFormat('MM/dd/yyyy').format(
          userInfo.dateOfBirth ?? DateTime.now(),
        );
      });
    }
  }

  // Get current location...
  Future<void> userCurrentLocationTapAction() async {
    try {
      final bool locationPermission =
          await AppPermissionsService.getLocationPermission;
      if (locationPermission) {
        getLatLong();
      } else {
        showAlert(
          context: context,
          message:
              "Go to Settings - Location and grant permission to access your current location to use it to display in profile.",
          title: "Permission denied",
          signleBttnOnly: false,
          leftBttnTitle: "Cancel",
          rigthBttnTitle: "Settings",
          onRightAction: () {
            openAppSettings();
          },
        );
      }
    } catch (e) {
      showAlert(
        context: context,
        message: e,
      );
    }
  }

  // Get latlon...
  Future<void> getLatLong() async {
    final Position position = await Geolocator.getCurrentPosition();
    getaddressFromCoordinates(position.latitude, position.longitude);
  }

  // Get address from latlong...
  Future<void> getaddressFromCoordinates(
      double latitude, double longitude) async {
    final List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);

    if (placemarks.isEmpty) return;

    setState(() {
      userInfo.location = [
        placemarks.first.name,
        placemarks.first.administrativeArea,
        placemarks.first.subAdministrativeArea
      ].where((text) => text?.isNotEmpty ?? false).join(", ");
      locationController.text = userInfo.location;
    });
  }

  //--------------------------------------------------------------- Button actions ---------------------------------------------------------------//
  void onNextButton() {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_formKey.currentState?.validate() ?? false) {
      if (dateOfBirthController.text.validateDOB != null) {
        var snackBar = SnackBar(
          backgroundColor: Colors.orange.shade200,
          content: Text(
            dateOfBirthController.text.validateDOB ?? "",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (userInfo.profileUrl.isEmpty) {
        var snackBar = SnackBar(
          backgroundColor: Colors.orange.shade200,
          content: Text(
            "Please select profile image",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (userInfo.phoneNumber.isEmpty ||
          userInfo.phoneNumber.removeSpecialCharacters.length != 10) {
        var snackBar = SnackBar(
          backgroundColor: Colors.orange.shade200,
          content: Text(
            "Please enter a valid 10 digit phone number",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        milestones[1].isCompleted = true;
        widget.onNextPage();
        widget.pageController.animateToPage(
          milestones[2].pageIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
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

  //Validate name...
  String? get validateName => trim().isEmpty ? "Enter full name" : null;

  //Validate DOB...
  String? get validateDOB => trim().isEmpty ? "Select you date of birth" : null;

  //Validate location...
  String? get validateLocation =>
      trim().isEmpty ? "Select your location" : null;
}
