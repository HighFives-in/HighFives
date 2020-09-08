import 'package:flutter/material.dart';
import 'package:highfives_ui/constants/const/business.dart';
import 'package:highfives_ui/constants/const/employerSideMenuItems.dart';
import 'package:highfives_ui/constants/const/size.dart';
import 'package:highfives_ui/locator.dart';
import 'package:highfives_ui/screens/employer/dashboard/sidemenumodel.dart';
import 'package:highfives_ui/screens/utils/navigationService.dart';
import 'package:provider/provider.dart';

class EmployerSideView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: SIDE_VIEW_WIDTH,
      height: size.height,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor,
            blurRadius: 3,
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: _sideMenuItemsList(context),
        ),
      ),
    );
  }
}

//TODO MAKE SEPARATE WIDGET FOR EVERY MENU ITEM AS ICONS AND SOME PROPERTIES ARE TO BE DIFFERENT LIKE FOR COMMUNICATION THERE ARE SUB HEADINGS
//IT IS STILL POSSIBLE IN THIS LOOP BUT SEE LATER
List<Widget> _sideMenuItemsList(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  String selectedItem =
      Provider.of<EmployerSideMenuModel>(context).selectedItem;
  List<Widget> _menuItems = List<Widget>();
  for (int i = 0; i < EMPLOYERSIDEMENULIST.length; i++) {
    bool selected = false;

    if (EMPLOYERSIDEMENULIST[i] == selectedItem) {
      selected = true;
    }

    String item = EMPLOYERSIDEMENULIST[i];

    Widget itemWidget = GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Provider.of<EmployerSideMenuModel>(context, listen: false)
            .setSideMenuItem(item);
        locator<NavigationService>().navitgateTo('/' + EMPLOYER + '/' + item);
      },
      // color: Colors.orange,
      child: Container(
        color: selected
            ? Theme.of(context).accentColor.withOpacity(0.1)
            : Theme.of(context).primaryColor,
        margin: EdgeInsets.only(top: 10),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: getIcon(item),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(item,
                    style: Theme.of(context).textTheme.headline6,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ),
      ),
    );

    _menuItems.add(itemWidget);
  }
  return _menuItems;
}

Widget getIcon(String item) {
  switch (item) {
    case EMPLOYER_PROFILE:
      return Icon(
        Icons.account_box,
        size: 25,
      );
      break;
    case EMPLOYER_COMMUNICATIONS:
      return Icon(
        Icons.insert_comment_outlined,
        size: 25,
      );
      break;
    case EMPLOYER_ONGOING_INTERVIEW:
      return Icon(
        Icons.people,
        size: 25,
      );
      break;
    case EMPLOYER_STUDENTS:
      return Icon(
        Icons.people_alt_sharp,
        size: 25,
      );
      break;
    case EMPLOYER_ANALYTICS:
      return Icon(
        Icons.analytics_outlined,
        size: 25,
      );
      break;
    case EMPLOYER_HELP:
      return Icon(
        Icons.help,
        size: 25,
      );
      break;
    default:
      return Icon(
        Icons.menu,
        size: 25,
      );
  }
}