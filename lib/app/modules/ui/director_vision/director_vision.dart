import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';

class DirectorVisionView extends StatelessWidget {
  const DirectorVisionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Director Vision'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 2),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/misc/director.jpg',
                            ),
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text('Prof, Dr. Nazir Ahmad Zafar',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: defaultPadding,
                  left: defaultPadding,
                  right: defaultPadding),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Text(
                    'COMSATS University Islamabad is one of the most prestigious universities of Pakistan;with its seven physical campuses and one virtual campus across the country, CUI distinguishes itself as a leading university in the higher education sector of Pakistan. It gives me an immense pleasure and honor to serve as Director COMSATS University Islamabad, Sahiwal Campus.',
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'COMSATS University Islamabad has registered an exponential growth and successsince its inception, which is quite unprecedented in the history of Pakistani universities.Within a short span of two decades, it has producedaboveeighty thousand graduates including 500+ PhDs serving in various capacities in the different organizations throughout the country and the world; and currentlymore than thirty-five thousandstudents are enrolled across its campuses. CUI stands out as a torch bearer of excellence among the universities in Pakistan as one of the leading emerging economy universities in South Asia and the world. It has been ranked high among Pakistani Universitiesby the national and international ranking agencies, such as Times Higher Education (THE), UK; Quacquarelli Symonds (QS); and the Higher Education Commission (HEC), Pakistan. With a clear vision and a mission to develop a world-class university in the Pakistan, CUI has formulated three-pronged mission: Research and Discovery; Teaching and Learning; Outreach & Public Service. CUI is committed to pursuing this mission diligently by producing, archiving, and innovating the knowledge.',
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'CUI, Sahiwal campus was established in December 2006, since then, it has played a due role in uplifting and developing educational environment in the country and has established itself as a leading higher education institution in the region. Sahiwal campus stretches over an area of 36-acres with purpose-built buildings, it offers a wide range of undergraduate and graduate programs in seven departments under the Faculty of Information Science and Technology, Sciences, Engineering and Business Administration. The Sahiwal campus is committed to achieving CUI goals, vision and mission, and has established linkages with the local agriculture and dairy industry, which is a testimony to its commitment to public service.',
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
