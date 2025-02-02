import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/models/event/event_model.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/pages/homepage/widgets/events/events_showcase.dart';
import 'package:efficacy_admin/pages/homepage/widgets/tab_navigation/tab_view.dart';
import 'package:efficacy_admin/utils/local_database/local_database.dart';
import 'package:efficacy_admin/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:efficacy_admin/widgets/custom_drawer/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:efficacy_admin/utils/tutorials/tutorials.dart';
import 'package:flutter/services.dart';

import '../../utils/utils.dart';

class Homepage extends StatefulWidget {
  static const String routeName = "/homePage";

  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentTabIndex = 0;

  // Global keys for guide
  GlobalKey drawerKey = GlobalKey();
  GlobalKey createEventKey = GlobalKey();
  GlobalKey listEventsKey = GlobalKey();
  GlobalKey feedKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // To view guide everytime uncomment the next line
    // LocalDatabase.resetGuideCheckpoint();
    if (LocalDatabase.getAndSetGuideStatus(LocalGuideCheck.home)) {
      Future.delayed(const Duration(seconds: 1), () {
        showHomePageTutorial(
          context,
          listEventsKey,
          drawerKey,
          feedKey,
          onFinish: () {
            if (UserController.clubWithModifyEventPermission.isNotEmpty &&
                LocalDatabase.getAndSetGuideStatus(
                    LocalGuideCheck.createEvent)) {
              showCreateEventTutorial(
                context,
                createEventKey,
              );
            }
          },
        );
      });
    } else if (UserController.clubWithModifyEventPermission.isNotEmpty &&
        LocalDatabase.getAndSetGuideStatus(LocalGuideCheck.createEvent)) {
      Future.delayed(const Duration(seconds: 1), () {
        showCreateEventTutorial(
          context,
          createEventKey,
        );
      });
    }
  }

  void navigator(EventStatus buttonMessage) {
    setState(() {
      currentTabIndex = EventStatus.values.indexOf(buttonMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await showExitWarning(context);
        if (shouldPop) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(drawerKey: drawerKey, title: "Home"),
        endDrawer: CustomDrawer(
          pageContext: context,
        ),
        body: Column(
          children: [
            TabView(
              key: listEventsKey,
              currentTabIndex: currentTabIndex,
              navigator: navigator,
            ),
            Expanded(
              key: feedKey,
              child: EventsShowcasePage(
                createEventKey: createEventKey,
                eventStatus: currentTabIndex == 0
                    ? EventStatus.Upcoming
                    : currentTabIndex == 1
                        ? EventStatus.Ongoing
                        : EventStatus.Completed,
              ),
            ),
          ].separate(26),
        ),
      ),
    );
  }
}
