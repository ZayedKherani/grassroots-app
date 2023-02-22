import 'package:flutter/material.dart';

import 'package:grassroots_app/models/dayPlan/day_plans.dart';
import 'package:grassroots_app/services/themeModeNotifierService/theme_mode_notifier_service.dart';

ThemeMode? appThemeMode = ThemeMode.system;

TargetPlatform? appTargetPlatform = TargetPlatform.android;

int? appThemeSettingsInt = 0;

ThemeModeNotifier? globalThemeModeNotifier;

DayPlans globalDayPlans = DayPlans();
