import 'package:flutter/material.dart';

import '../../../theme/app_constants.dart';

// Flutter imports:

// Project imports:

class AboutUsView extends StatelessWidget {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(Constants.defaultPadding),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: EdgeInsets.all(Constants.defaultPadding),
                child: Text(
                  "COMSATS University Islamabad, Sahiwal campus is situated half-way between Lahore and Multan on COMSATS Road off G.T Road Sahiwal, was formally inaugurated on September 23, 2006. The campus is purpose built and is spread over area of 36 acres on land. \n\nCUI Sahiwal is committed to provide state of the art training and education to our students and prepare them for successful career in their respective fields. Our mission is to encourage learning and promote research activities in order to facilitate our students to fulfill their aims and aspirations objectively.\n\nWe are offering a broad range of programs, especially in the areas of Management Sciences, Computer Science, Biosciences, Engineering and Humanities. Our programs are focused on creating crucially needed transitions toward sustainable practice. CUI Sahiwal strives to prepare a knowledge workforce which is comparable to the best in the world. This is achieved through instruction and the use of up-to-date technology. Our highly qualified faculty plays the role mentors for our students and nurtures their individual talents. We also accentuate group projects to make our students learn to be co-operative and productive as team members.\n\nWe have developed collaborative relationships with the international academic institutions for pursuing excellence in the fields of education and research. Our educational approach is process-oriented so we give industry exposure to our students through internship programs which provide our young professionals the opportunity to thrive in the existent work environment. In this way we emphasize on bridging the theory and practice, and stress upon learning through collaboration and participation. We, at CUI Sahiwal, endeavor to ensure that the time spent by the students with us is a time of growth and discovery. The success achieved by our alumni is the evidence of our focus on the students.",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
