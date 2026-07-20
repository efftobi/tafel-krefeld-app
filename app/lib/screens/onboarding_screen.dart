import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/strings.dart';
import '../theme.dart';
import '../widgets/common.dart';

/// Erster Start: Sprache wählen + PLZ eingeben. Bewusst nur ein Screen,
/// keine Konten, keine weiteren Abfragen — niedrigschwellig.
class OnboardingScreen extends StatefulWidget {
  final Future<void> Function(String lang, String plz) onDone;
  const OnboardingScreen({super.key, required this.onDone});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  String _lang = 'de';
  final _plzController = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _plzController.dispose();
    super.dispose();
  }

  void _submit() {
    final plz = _plzController.text.trim();
    if (plz.length != 5 || int.tryParse(plz) == null) {
      setState(() => _error = t(_lang, 'onboarding.plzInvalid'));
      return;
    }
    widget.onDone(_lang, plz);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 12),
            const Center(child: TafelLogoMark(size: 72)),
            const SizedBox(height: 10),
            Center(
              child: Text(
                '${t(_lang, 'onboarding.welcome')} · Welcome!\nأهلاً بكم · Ласкаво просимо',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(height: 6),
            Center(
              child: Text(
                '${t(_lang, 'onboarding.chooseLanguage')} / Choose your language',
                style: const TextStyle(color: TafelColors.grey),
              ),
            ),
            const SizedBox(height: 18),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2.9,
              children: [
                for (final l in appLanguages)
                  _LangTile(
                    lang: l,
                    selected: l.code == _lang,
                    onTap: () => setState(() => _lang = l.code),
                  ),
              ],
            ),
            const SizedBox(height: 22),
            Text(
              t(_lang, 'onboarding.plzLabel'),
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _plzController,
              keyboardType: TextInputType.number,
              maxLength: 5,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: const TextStyle(fontSize: 22, letterSpacing: 6, fontWeight: FontWeight.w700),
              decoration: InputDecoration(
                hintText: t(_lang, 'onboarding.plzHint'),
                counterText: '',
                errorText: _error,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: TafelColors.line, width: 1.5),
                ),
              ),
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 14),
            FilledButton(onPressed: _submit, child: Text('${t(_lang, 'onboarding.go')} →')),
          ],
        ),
      ),
    );
  }
}

class _LangTile extends StatelessWidget {
  final AppLang lang;
  final bool selected;
  final VoidCallback onTap;
  const _LangTile({required this.lang, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: selected ? TafelColors.orangeLight : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? TafelColors.orange : TafelColors.line,
            width: selected ? 2.5 : 1.5,
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(lang.nativeName,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            if (lang.code != 'de')
              Text(lang.germanName,
                  style: const TextStyle(fontSize: 10, color: TafelColors.grey)),
          ],
        ),
      ),
    );
  }
}
