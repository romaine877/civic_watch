import 'package:civic_watch/wrappers/animated_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../cubits/auth/auth_cubit.dart';
import '../cubits/theme/theme_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text('Romaine Halstead',
                          overflow: TextOverflow.visible,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 30))),
                  const CircleAvatar(
                    radius: 30,
                  ),
                ],
              ),
            ),
            const Row(
             
              children: [
                AccountHighlightWidget(
                  title: 'Reports',
                  subtitle: '24',
                  icon: LucideIcons.bookmark,
                ),
                SizedBox(width: 16),
                AccountHighlightWidget(
                  title: 'Points',
                  subtitle: '12',
                  icon: LucideIcons.star,
                ),
              ],
            ),
            ListItem(
              title: 'Account Details',
              icon: LucideIcons.user,
              onTap: () {
                context.goNamed('account');
              },
            ),
            ListItem(
              title: 'About',
              icon: LucideIcons.info,
              onTap: () {
                context.go('/profile/about');
              },
            ),
            ListItem(
                title: 'Appearance',
                icon: context.read<ThemeCubit>().state.when(
                                system: () {
                                  if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
                                    return LucideIcons.moon;
                                  } else {
                                    return LucideIcons.sun;
                                  }
                                },
                                light: () => LucideIcons.sun,
                                dark: () => LucideIcons.moon,
                              ),
                onTap: () {
                  showModalBottomSheet(context: context, 
                  useRootNavigator: true,
                  useSafeArea: true,
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      height: 400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text('Appearance', style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ShadRadioGroup<ThemeMode>(
                              initialValue: context.read<ThemeCubit>().state.when(
                                system: () => ThemeMode.system,
                                light: () => ThemeMode.light,
                                dark: () => ThemeMode.dark,
                              ),
                              onChanged: (value) {
                                context.read<ThemeCubit>().toggleTheme(value);
                              },
                              items: const[
                                ShadRadio(
                                   padding:  EdgeInsets.all(12),
                                  label: Text('Dark'),
                                  value: ThemeMode.dark,
                                ),
                                ShadRadio(
                                  padding:  EdgeInsets.all(12),
                                  label: Text('Light'),
                                  value: ThemeMode.light,
                                ),
                                ShadRadio(
                                  padding:  EdgeInsets.all(12),
                                  label: Text('Automatic'),
                                  value: ThemeMode.system,
                                ),
                              ],
                            ),
                          ),
                          Text('Choose a theme for the app', style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                        ],
                      ),
                    );
                  });
              //     showShadSheet(
              //         side: ShadSheetSide.bottom,
              //         context: context,
              //         builder: (context) {
              //           return ShadSheet(
              //             draggable: true,
              //             child: ShadRadioGroup<ThemeMode>(
              //               onChanged: (value) {
                              
              //               },
              //               items: [
              //                 ShadRadio(
              //                   label: Text('Dark'),
              //                   value: ThemeMode.dark,
              //                 ),
              //                 ShadRadio(
              //                   label: Text('Light'),
              //                   value: ThemeMode.light,
              //                 ),
              //                 ShadRadio(
              //                   label: Text('Automatic'),
              //                   value: ThemeMode.system,
              //                 ),
              //                  SizedBox(
              //   height: MediaQuery.of(context).padding.bottom,
              // ),
              //               ],
              //             ),
              //           );
              //         });
                }),
            ListItem(
              title: 'Settings',
              icon: LucideIcons.settings,
              onTap: () {
                context.go('/profile/settings');
              },
            ),
            ListItem(
              title: 'Logout',
              icon: LucideIcons.logOut,
              onTap: () {
                context.read<AuthCubit>().signOut();
              },
            ),
            ShadButton.destructive(
              child: const Text('Logout'),
              onPressed: () {
                context.read<AuthCubit>().signOut();
              },
            )
          ],
        ),
      ),
    );
  }
}

class AccountHighlightWidget extends StatelessWidget {
  const AccountHighlightWidget({
    super.key,
    this.title = 'Points',
    this.subtitle,
    this.onTap,
    this.icon,
  });

  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      child: Row(children: [
        Icon(
          icon,
          size: 40,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (subtitle != null)
              Text(subtitle!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24)),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ]),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.onTap,
    this.icon,
  });

  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return AnimatedTap(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Row(children: [
          Icon(icon),
          const SizedBox(width: 16),
          Expanded(
            child: Text(title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
          ),
          const Spacer(),
          const Icon(Icons.chevron_right),
        ]),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Screen')),
      body: const Center(
        child: Text('Detail Screen'),
      ),
    );
  }
}
