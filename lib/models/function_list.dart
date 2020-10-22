import 'package:ChitChat/screens/vendor_list_screen.dart';

import '../screens/chat_screen.dart';
import '../screens/complaints/complaint_screen.dart';
import '../screens/events_screen.dart';
import '../screens/help_screen.dart';
import '../screens/poll_screen.dart';

import './main_functions_Model.dart';
import 'package:flutter/material.dart';

const List<MainFunctionsModel> FUNCTION_LIST = const [
  MainFunctionsModel(
    "Events",
    Icon(Icons.event),
    EventsScreen.routeName
    
  ),
  MainFunctionsModel(
    "Help",
    Icon(Icons.help),
    HelpScreen.routeName
  ),
MainFunctionsModel(
    "Complaints",
    Icon(Icons.error),
    ComplaintScreen.routeName
  ),
MainFunctionsModel(
    "Chat",
    Icon(Icons.chat),
    ChatScreen.routeName
  ),
MainFunctionsModel(
    "Polls",
    Icon(Icons.poll, ),
    PollScreen.routeName
),
MainFunctionsModel(
    "Vendors",
    Icon(Icons.shopping_basket, ),
    VendorListScreen.routeName
),
];
