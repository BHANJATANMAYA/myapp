// import 'package:flutter/material.dart';

// class TermsPage extends StatelessWidget {
//   const TermsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFE75480),
//         title: const Text(
//           "Terms & Conditions",
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//             color: Colors.black,
//             letterSpacing: 0.9,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: const Text(
//           '''
// Welcome to LoveXL ❤️ – the app that tells you what your heart *probably* already knows (or maybe not).

// Please read these Terms and Conditions carefully before using our application. By using LoveXL, you agree to the following:

// 1. Acceptance of Terms
// By downloading or using this app, you accept these terms. If you don’t agree, sadly, you’ll have to break up with us (aka uninstall the app). 💔

// 2. Purpose of the App
// LoveXL is meant for **entertainment purposes only**.  
// The results are not based on science, astrology, or divine intervention. Don’t make life-changing decisions (like proposing or ghosting someone) based solely on this app. 😉

// 3. User Responsibilities
// - Please don’t misuse the app for harmful, offensive, or creepy purposes.  
// - Enter names responsibly. No, “Pizza” + “Netflix” is not a valid couple… but we respect your priorities.

// 4. Privacy Policy
// - We don’t sell your data. We don’t stalk you. Relax. ✌️  
// - Names you enter are used only for generating results and aren’t stored forever. (Your secrets are safe.)

// 5. Limitations of Liability
// If you decide to marry, dump, or text your crush based on our results – that’s on you. We’ll cheer you on, but we take zero responsibility. 😅

// 6. Modifications
// We may update these Terms & Conditions anytime (because life changes, and so does love). By continuing to use the app, you accept the latest version.

// 7. Contact Us
// Got questions, feedback, or love confessions?  
// Reach out at:

// - Email: tanmaybhanja1@gmail.com
// - Instagram: @ral_ph01

// Thank you for using LoveXL 💘  
// Go spread some love… responsibly!
//           ''',
//           style: TextStyle(
//             fontSize: 15,
//             height: 1.6,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  // CHANGE THESE TO YOUR REAL DETAILS
  static const String _contactEmail = 'tanmaybhanja1@gmail.com';
  static const String _portfolioOwnerName = 'TANMAYA BHANJA CHAKRADHAR';


// removed due to unused warning  
  // Future<void> _openUrl(String url) async {
  //   final uri = Uri.parse(url);
  //   if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
  //     debugPrint('Could not launch $url');
  //   }
  // }

  Future<void> _sendEmail() async {
    final uri = Uri(
      scheme: 'mailto',
      path: _contactEmail,
      query: Uri.encodeQueryComponent(
        'subject=Portfolio App - Terms & Conditions',
      ),
    );
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch email client');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DefaultTextStyle(
              style: theme.textTheme.bodyMedium!,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Terms & Conditions (v1.2)',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Last updated: 02 Dec 2025',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodySmall?.color
                          ?.withValues(alpha:0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Divider(height: 1),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: SelectableText(
                _termsText,
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.4,
                ),
              ),
            ),
          ),

          const Divider(height: 1),

          // Contact section
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              children: [
                const Icon(Icons.info_outline, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'If you have any questions about these Terms & Conditions, '
                    'you can contact me via email.',
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: ElevatedButton.icon(
              onPressed: _sendEmail,
              icon: const Icon(Icons.email_outlined),
              label: Text('Contact $_portfolioOwnerName'),
            ),
          ),
        ],
      ),
    );
  }
}

// text separation to avoid staking.
const String _termsText = '''
1. Introduction
This portfolio application ("App") is developed and maintained by the developer for the purpose of showcasing personal projects, skills, and related work. By using this App, you agree to these Terms & Conditions.

2. Nature of the App
This App is for demonstration and portfolio purposes only. It is not a commercial product, nor does it provide any guaranteed services, support, or uptime.

3. No Professional Advice
Any content shown in this App (including code samples, project descriptions, or external links) is for informational and educational purposes only. It should not be treated as professional, legal, financial, medical, or any other kind of formal advice.

4. Data and Permissions
This App does not intentionally collect sensitive personal information such as passwords, payment details, or government IDs.
If the App requests any permissions (for example: internet access), they are used strictly for displaying content or opening external links.

5. Third-Party Links
The App may contain links to third-party platforms such as GitHub, LinkedIn, Instagram, email, or app stores.
These links are provided only to showcase work or provide contact options.
The developer is not responsible for the content, policies, or practices of any third-party websites, apps, or services you open from this App.

6. Intellectual Property
All source code, designs, screenshots, text, and other content inside this App are owned by the developer, unless otherwise stated.
You may not copy, redistribute, or claim the work as your own without explicit permission from the developer.

7. No Warranty
This App is provided on an "AS IS" and "AS AVAILABLE" basis.
The developer makes no warranties, expressed or implied, regarding:
- accuracy or completeness of information shown,
- error-free operation of the App,
- compatibility with all devices, screen sizes, or OS versions.

8. Limitation of Liability
To the maximum extent permitted by law, the developer shall not be liable for any direct, indirect, incidental, or consequential damages arising from:
- the use or inability to use this App,
- reliance on any information displayed in the App,
- issues caused by third-party links, services, or platforms.

9. Changes to the App and Terms
The developer may update, modify, or remove features of this App at any time without prior notice.
These Terms & Conditions may be updated from time to time. Continued use of the App after changes means you accept the updated Terms.

10. Termination of Use
The developer reserves the right to restrict or block access to the App for any reason, without prior notice, especially in cases of misuse or attempts to reverse-engineer or tamper with the App.

11. Contact
If you have questions or concerns about these Terms & Conditions, you can contact the developer via the email address provided in the App.

By using this App, you confirm that you have read, understood, and agree to these Terms & Conditions.
''';
