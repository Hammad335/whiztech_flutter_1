import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../constants/constants.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import '../widgets/about_us_contact_row.dart';
import '../widgets/about_us_service.dart';

class AboutUsPage extends StatelessWidget {
  static const routeName = 'about-us-page';
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('About Us'), backgroundColor: kPrimaryColor),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: 100.h,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/about_us_images/about_us_background.png',
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BlurryContainer(
                    blur: 10,
                    elevation: 1,
                    color: Colors.white30,
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'We Are',
                          style: kTitleExtraLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          textAlign: TextAlign.center,
                          softWrap: true,
                          text: TextSpan(
                            text: 'The Ultimate POS Solutions!\n',
                            style: kTitleMediumBlack,
                            children: [
                              TextSpan(
                                text: 'Whiztech',
                                style: kTitleMediumBold.copyWith(
                                    color: kPrimaryColor),
                              ),
                              TextSpan(
                                text: ' provides a long range of Desktop & '
                                    'Cloud POS solutions catered for every business type and industry.',
                                style: kTitleMediumBlack,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/about_us_images/about_us_services_background.png'),
                          alignment: Alignment.topRight),
                    ),
                    child: BlurryContainer(
                      blur: 10,
                      elevation: 1,
                      color: Colors.white30,
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Services',
                            style: kTitleExtraLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          AboutUsService(serviceText: 'Software Development'),
                          AboutUsService(serviceText: 'Mobile Application'),
                          AboutUsService(
                              serviceText: 'Web Design & Development'),
                          AboutUsService(serviceText: 'Digital Marketing'),
                          AboutUsService(serviceText: 'Strategy & Consulting'),
                          AboutUsService(serviceText: 'Promotional Material'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlurryContainer(
                    blur: 10,
                    elevation: 1,
                    color: Colors.white54,
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Contact Us',
                          style: kTitleExtraLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        AboutUsContactRow(
                          iconPath:
                              'assets/images/about_us_images/insta_logo.png',
                          title: 'Whiztechint',
                        ),
                        AboutUsContactRow(
                          iconPath:
                              'assets/images/about_us_images/gmail_logo.png',
                          title: 'info@whiztechint.com',
                        ),
                        AboutUsContactRow(
                          iconPath:
                              'assets/images/about_us_images/whatsapp_logo.png',
                          title: '+923000553066',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
