import 'package:flutter/material.dart';
import 'package:profile_demo/view/0.0.profile_setup_screen.dart';

import '../constant/custom_color.dart';
import '../constant/img_name.dart';

class SelectRoleScreen extends StatefulWidget {
  // Default constructor...
  const SelectRoleScreen({
    super.key,
    required this.pageController,
    required this.onNextPage,
  });

  final PageController pageController;
  final VoidCallback onNextPage;

  @override
  State<SelectRoleScreen> createState() => _SelectRoleScreenState();
}

class _SelectRoleScreenState extends State<SelectRoleScreen> {
  //------------------------------------------------------------------ Variables -----------------------------------------------------------------//
  Size get size => MediaQuery.of(context).size;

  //--------------------------------------------------------------------- UI ---------------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Find a Helper...
            Flexible(
              child: _buildInstruction(
                context,
                ImgName.noProfile,
                "Are you seeking care for your\nlove one?",
                "Find a Helper",
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                onPressed: () {
                  milestones.first.isCompleted = true;
                  widget.onNextPage();
                  widget.pageController.animateToPage(
                    milestones[1].pageIndex,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
            const SizedBox(height: 70.0),
            // Find for a Job...
            Flexible(
              child: _buildInstruction(
                context,
                ImgName.noProfile,
                "Or you're looking for a care,\nhousekeeper, or tutor job?",
                "Find for a Job",
                backgroundColor: ConstantColor.ffff9266,
                onPressed: () {
                  milestones.first.isCompleted = true;
                  widget.onNextPage();
                  widget.pageController.animateToPage(
                    milestones[1].pageIndex,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //--------------------------------------------------------------- Helper Widgets ---------------------------------------------------------------//

  // Instruction...
  Widget _buildInstruction(
    BuildContext context,
    icon,
    instruction,
    buttonTitle, {
    void Function()? onPressed,
    Color? backgroundColor,
  }) {
    return Center(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image...
            ClipRRect(
              borderRadius: BorderRadius.circular(140.0 / 2.0),
              child: Image.asset(
                icon,
                height: 140.0,
              ),
            ),
            const SizedBox(height: 30.0),
            // Instruction...
            Text(
              instruction,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(height: 20.0),
            // Button...
            SizedBox(
              height: 60.0,
              width: 200.0,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(
                  backgroundColor,
                )),
                onPressed: onPressed,
                child: Text(
                  buttonTitle,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
