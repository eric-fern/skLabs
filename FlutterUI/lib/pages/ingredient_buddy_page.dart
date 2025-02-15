import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../widgets/image_upload_section.dart';
import '../widgets/scrollable_items_list.dart';
import '../widgets/ai_output_display.dart';

class IngredientBuddyPage extends StatefulWidget {
  const IngredientBuddyPage({super.key});

  @override
  State<IngredientBuddyPage> createState() => _IngredientBuddyPageState();
}

class _IngredientBuddyPageState extends State<IngredientBuddyPage> {
  final TextEditingController _textController = TextEditingController();

  void _handleReceivedText(String text) {
    _textController.text = text;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        color: AppColors.primaryDark,
        child: SingleChildScrollView(
          child: Padding(
            padding: AppSpacing.pagePadding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            ImageUploadSection(
                              onTextReceived: _handleReceivedText,
                            ),
                            const SizedBox(height: 20),
                            const SizedBox(
                              height: 300,
                              child: ScrollableItemsList(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: AIOutputDisplay(
                          controller: _textController,
                          hintText: 'Raw Text Extracted With AI',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
