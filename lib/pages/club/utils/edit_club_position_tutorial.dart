import 'package:efficacy_admin/widgets/coach_mark_desc/coach_mark_desc.dart';
import 'package:flutter/cupertino.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

void showEditClubPosTutorial(
  BuildContext context,
  GlobalKey newPosNameKey,
  GlobalKey addKey,
  GlobalKey posNameKey,
  GlobalKey membersKey,
  GlobalKey editPosKey,
) {
  List<TargetFocus> targets =
      getTargets(newPosNameKey, addKey, posNameKey, membersKey, editPosKey);

  TutorialCoachMark(
    hideSkip: true,
    useSafeArea: true,
    targets: targets, // List<TargetFocus>
  ).show(context: context);
}

List<TargetFocus> getTargets(
  GlobalKey newPosNameKey,
  GlobalKey addKey,
  GlobalKey posNameKey,
  GlobalKey membersKey,
  GlobalKey editPosKey,
) {
  return [
    TargetFocus(
      identify: "New Club Position Name",
      keyTarget: newPosNameKey,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return CoachmarkDesc(
              heading: "New Club Position Name",
              text: "Type your new club position name here.",
              onNext: () {
                controller.next();
              },
              onSkip: () {
                controller.skip();
              },
            );
          },
        )
      ],
    ),
    TargetFocus(
      identify: "Add button",
      keyTarget: addKey,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return CoachmarkDesc(
              heading: "Add",
              text: "Click here to add  the new club position name.",
              onNext: () {
                controller.next();
              },
              onSkip: () {
                controller.skip();
              },
            );
          },
        )
      ],
    ),
    TargetFocus(
      identify: "Club Position Name",
      keyTarget: posNameKey,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return CoachmarkDesc(
              heading: "Club Position Name",
              text: "These are the existing club positions.",
              onNext: () {
                controller.next();
              },
              onSkip: () {
                controller.skip();
              },
            );
          },
        )
      ],
    ),
    TargetFocus(
      identify: "Members",
      keyTarget: membersKey,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return CoachmarkDesc(
              heading: "Members",
              text: "Click here to view the list of members in this position.",
              onNext: () {
                controller.next();
              },
              onSkip: () {
                controller.skip();
              },
            );
          },
        ),
      ],
    ),
    TargetFocus(
      identify: "Edit Position",
      keyTarget: editPosKey,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return CoachmarkDesc(
              heading: "Edit Position",
              text: "Click here to edit the respective club position.",
              onNext: () {
                controller.next();
              },
              onSkip: () {
                controller.skip();
              },
            );
          },
        ),
      ],
    ),
  ];
}
