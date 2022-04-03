import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:weather_app/app/features/home/view/home_page.dart';

class OnboardingFooter extends StatefulWidget {
  const OnboardingFooter({Key? key}) : super(key: key);

  @override
  State<OnboardingFooter> createState() => _OnboardingFooterState();
}

class _OnboardingFooterState extends State<OnboardingFooter> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    initializeConfiguration();
  }

  void initializeConfiguration() {
    textEditingController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        alignment: Alignment.center,
        color: Palette.purple,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter a location to view its weather',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: textEditingController,
                textAlignVertical: TextAlignVertical.center,
                onChanged: (value) {},
                textCapitalization: TextCapitalization.sentences,
                onEditingComplete: () {},
                onFieldSubmitted: (_) {
                  if (textEditingController.text.isNotEmpty) {
                    Navigator.push<HomePage>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          location: textEditingController.text,
                        ),
                      ),
                    );
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  isCollapsed: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (textEditingController.text.isNotEmpty) {
                        Navigator.push<HomePage>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(
                              location: textEditingController.text,
                            ),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.search),
                  ),
                  contentPadding: const EdgeInsets.only(left: 10),
                  hintText: 'Berlin',
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Palette.background,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Palette.purple),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Palette.background),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
