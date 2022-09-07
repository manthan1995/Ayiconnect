import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constant/constant_string.dart';

Future<bool?> showAlert({
  required BuildContext context,
  String title = "Error",
  dynamic message = "Some thing went wrong",
  void Function()? onRightAction,
  void Function()? onLeftAction,
  TextAlign contentAlign = TextAlign.center,
  String leftBttnTitle = ConstantString.no,
  String rigthBttnTitle = ConstantString.yes,
  String singleBtnTitle = ConstantString.ok,
  bool signleBttnOnly = true,
  bool barrierDismissible = true,
  bool disableDefaultPop = false,
  bool showCustomContent = false,
  Widget? content,
  MainAxisAlignment buttonAlignmnet = MainAxisAlignment.end,
}) async {
  //Retry button...
  Widget retryButton(BuildContext ctx) => InkWell(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            singleBtnTitle,
            style: Theme.of(ctx)
                .textTheme
                .bodyText2
                ?.copyWith(fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
        onTap: () {
          if (Navigator.of(ctx).canPop() && !disableDefaultPop) {
            Navigator.of(ctx).pop(true);
          }

          if (onRightAction == null) return;
          onRightAction();
        },
      );

  //Left Button...
  Widget leftButton(BuildContext ctx) => InkWell(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            leftBttnTitle,
            style: Theme.of(ctx)
                .textTheme
                .bodyText2
                ?.copyWith(fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        onTap: () {
          if (Navigator.of(ctx).canPop()) Navigator.of(ctx).pop(true);
          if (onLeftAction == null) return;
          onLeftAction();
        },
      );

  //Right Bttn...
  Widget rightButton(BuildContext ctx) => InkWell(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            rigthBttnTitle,
            style: Theme.of(ctx)
                .textTheme
                .bodyText2
                ?.copyWith(fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        onTap: () {
          if (Navigator.of(ctx).canPop() && !disableDefaultPop) {
            Navigator.of(ctx).pop(true);
          }
          if (onRightAction == null) return;
          onRightAction();
        },
      );

  // SetUp the AlertDialog
  AlertDialog alert(BuildContext ctx) => AlertDialog(
        backgroundColor: Colors.white,
        actionsPadding: const EdgeInsets.only(top: 10.0, right: 5.0),
        contentPadding: const EdgeInsets.only(
          left: 25.0,
          right: 25.0,
        ),
        titlePadding: const EdgeInsets.only(
          left: 30.0,
          right: 30.0,
          top: 20.0,
          bottom: 15.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        title: title.isEmpty
            ? Container()
            : Text(
                toBeginningOfSentenceCase(
                      title,
                    ) ??
                    "",
                textAlign: TextAlign.center,
                style: Theme.of(ctx).textTheme.headline2?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
              ),
        content: showCustomContent
            ? content
            : Text(
                "Some thing went wrong",
                textAlign: contentAlign,
                style: Theme.of(ctx)
                    .textTheme
                    .headline1
                    ?.copyWith(color: Colors.black),
              ),
        actions: signleBttnOnly
            ? [
                Row(
                  mainAxisAlignment: buttonAlignmnet,
                  children: [
                    retryButton(ctx),
                  ],
                )
              ]
            : [
                Row(
                  mainAxisAlignment: buttonAlignmnet,
                  children: [
                    leftButton(ctx),
                    rightButton(ctx),
                  ],
                )
              ],
      );

  // show the dialog
  return showDialog<bool>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: alert,
  );
}
