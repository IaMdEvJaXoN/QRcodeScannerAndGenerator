import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proscan/Core/Themes/app_themes.dart';
//import 'package:proscan/Core/Utils/navigation_bar_index.dart';
import 'package:proscan/Features/Settings/Presentation/Widgets/app_logo_card.dart';
import 'package:proscan/Features/Settings/Presentation/Widgets/list_tile.dart';
import 'package:proscan/Features/Settings/Presentation/Widgets/settings_section_card.dart';
//import 'package:proscan/Shared/Providers/BottomNav_selectedIndexProvider/selected_index_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    //final indexReader = ref.read(selectedIndexProvider.notifier);
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppThemes.background,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            floating: true,
            pinned: false,
            title: Text(
              'Settings',
              style: textTheme.headlineMedium?.copyWith(
                color: AppThemes.primaryText,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
                SettingsSectionCard(
                  title: 'General',
                  children: [
                    SettingsListTile(
                      leadingIcon: Icons.volume_up_rounded,
                      title: 'Beep',
                      subtitle: 'Play a sound after a successful scan.',
                      trailing: Switch(value: true, onChanged: (_) {}),
                    ),
                    SettingsListTile(
                      leadingIcon: Icons.content_copy_rounded,
                      title: 'Auto Copy to Clipboard',
                      subtitle: 'Automatically copy scanned content.',
                      trailing: Switch(value: false, onChanged: (_) {}),
                    ),
                    SettingsListTile(
                      leadingIcon: Icons.vibration_rounded,
                      title: 'Vibration',
                      subtitle: 'Vibrate after successful scans.',
                      trailing: Switch(value: true, onChanged: (_) {}),
                    ),
                    SettingsListTile(
                      leadingIcon: Icons.search_rounded,
                      title: 'Search Engine',
                      subtitle: 'Choose the default search engine.',
                      onTap: () {},
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Google',
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppThemes.secondaryText,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: AppThemes.secondaryText,
                          ),
                        ],
                      ),
                    ),
                    SettingsListTile(
                      leadingIcon: Icons.language_rounded,
                      title: 'Language',
                      subtitle: 'Application display language.',
                      onTap: () {},
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'English',
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppThemes.secondaryText,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: AppThemes.secondaryText,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SettingsSectionCard(
                  title: 'Help & Support',
                  children: [
                    SettingsListTile(
                      leadingIcon: Icons.feedback_outlined,
                      title: 'Feedback',
                      subtitle: 'Report bugs and suggest improvements.',
                      onTap: () {},
                      trailing: Icon(
                        Icons.chevron_right_rounded,
                        color: AppThemes.secondaryText,
                      ),
                    ),
                    SettingsListTile(
                      leadingIcon: Icons.privacy_tip_outlined,
                      title: 'Privacy Policy',
                      subtitle: 'Read our privacy policy.',
                      onTap: () {},
                      trailing: Icon(
                        Icons.chevron_right_rounded,
                        color: AppThemes.secondaryText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SettingsSectionCard(
                  title: 'About',
                  children: [
                    SettingsListTile(
                      leadingIcon: Icons.info_outline_rounded,
                      title: 'Version Information',
                      trailing: Text(
                        'v1.0.0',
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppThemes.secondaryText,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const ApplicationLogoCard(),
                const SizedBox(height: 24),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
