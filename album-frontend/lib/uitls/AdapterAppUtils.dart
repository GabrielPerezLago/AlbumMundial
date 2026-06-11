import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

bool isDesktop = Platform.isMacOS || Platform.isWindows || Platform.isLinux;
bool isMovile = Platform.isAndroid || Platform.isIOS;

double width(BuildContext context) => MediaQuery.of(context).size.width;
double height(BuildContext context) => MediaQuery.of(context).size.width;

double cromoHeightPorcent = isDesktop ? 0.2 : 0.5;
double cromoWidthPorcent = isDesktop ? 0.15 : 0.3;

Color MyGreen = Color(0xCD65FF00);