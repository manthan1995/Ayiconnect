import 'package:flutter/material.dart';
import 'package:profile_demo/model/milestone_model.dart';
import 'package:profile_demo/view/0.1.select_role_screen.dart';
import 'package:profile_demo/view/0.2.personal_information_1_screen.dart';
import 'package:profile_demo/view/0.3.personal_information_2_screen.dart';

List<MilestoneModel> milestones = milestonlist;

class ProfileSetupScreen extends StatefulWidget {
  // Default constructor...
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => ProfileSetupScreenState();
}

class ProfileSetupScreenState extends State<ProfileSetupScreen> {
  //------------------------------------------------------------------ Variables -----------------------------------------------------------------//
  Size get size => MediaQuery.of(context).size;
  final PageController pageController = PageController();
  List<Widget> screens = [];

  //--------------------------------------------------------------------- UI ---------------------------------------------------------------------//
  @override
  void initState() {
    super.initState();
    screens = [
      SelectRoleScreen(
          pageController: pageController,
          onNextPage: () {
            setState(() {});
          }),
      PersonalInformation1Screen(
          pageController: pageController,
          onNextPage: () {
            setState(() {});
          }),
      PersonalInformation2Screen(
          pageController: pageController,
          onNextPage: () {
            setState(() {});
          }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          pageController.previousPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
          return false;
        },
        child: Scaffold(
          body: Column(
            children: [
              // Milestones...
              _buidMilestoneList(context),
              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  itemCount: screens.length,
                  itemBuilder: (context, index) => screens[index],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Milestones...
  Widget _buidMilestoneList(BuildContext context) {
    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      width: double.maxFinite,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(
            right: 40.0,
            left: 40.0,
            top: 35.0,
            bottom: 20.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              milestones.length + (milestones.length - 1),
              (index) => index.isOdd
                  ? // Divider...
                  _buildDivider()
                  // Milestone...
                  : _buildMilestone(
                      milestones[
                          index > 0 ? index ~/ (milestones.length - 1) : index],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  //--------------------------------------------------------------- Helper Widgets ---------------------------------------------------------------//
  // Milestone...
  Widget _buildMilestone(
    MilestoneModel milestoneInfo,
  ) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        pageController.animateToPage(
          milestoneInfo.pageIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Count...
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            height: 35.0,
            width: 35.0,
            child: milestoneInfo.isCompleted
                // Tick icon...
                ? Icon(
                    Icons.check,
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    size: 20.0,
                  )
                // Text...
                : Text(
                    milestoneInfo.header,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: Theme.of(context).appBarTheme.backgroundColor,
                          fontWeight: FontWeight.w500,
                        ),
                    textAlign: TextAlign.center,
                  ),
          ),
          const SizedBox(height: 5.0),
          // Text...
          Text(
            milestoneInfo.subHeader,
            style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Divider...
  Widget _buildDivider() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Container(
          color: Colors.white.withOpacity(0.7),
          height: 1.0,
        ),
      ),
    );
  }
}
