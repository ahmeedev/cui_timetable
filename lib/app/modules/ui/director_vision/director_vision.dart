import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_constants.dart';

// Flutter imports:

// Project imports:

class DirectorVisionView extends StatelessWidget {
  const DirectorVisionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Director Vision',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(Constants.defaultPadding),
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
                  .titleLarge!
                  .copyWith(color: Colors.black)),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(
                  top: Constants.defaultPadding,
                  left: Constants.defaultPadding,
                  right: Constants.defaultPadding),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildText(
                      context: context,
                      text:
                          'COMSATS University Islamabad is one of the most prestigious universities of Pakistan with its seven physical campuses and one virtual campus across the country, CUI distinguishes itself as a leading university in the higher education sector of Pakistan. It gives me an immense pleasure and honor to serve as Director COMSATS University Islamabad, Sahiwal Campus.'),
                  _buildSpace(),
                  _buildText(
                    context: context,
                    text:
                        'COMSATS University Islamabad has registered an exponential growth and success since its inception, which is quite unprecedented in the history of Pakistani universities. Within a short span of two decades, it has produced above eighty thousand graduates including 500+ PhDs serving in various capacities in the different organizations throughout the country and the world; and currently more than thirty-five thousand students are enrolled across its campuses. CUI stands out as a torch bearer of excellence among the universities in Pakistan as one of the leading emerging economy universities in South Asia and the world. It has been ranked high among Pakistani Universities by the national and international ranking agencies, such as Times Higher Education (THE), UK; Quacquarelli Symonds (QS); and the Higher Education Commission (HEC), Pakistan. With a clear vision and a mission to develop a world-class university in the Pakistan, CUI has formulated three-pronged mission: Research and Discovery; Teaching and Learning; Outreach & Public Service. CUI is committed to pursuing this mission diligently by producing, archiving, and innovating the knowledge.',
                  ),
                  _buildSpace(),
                  _buildText(
                      context: context,
                      text:
                          'CUI, Sahiwal campus was established in December 2006, since then, it has played a due role in uplifting and developing educational environment in the country and has established itself as a leading higher education institution in the region. Sahiwal campus stretches over an area of 36-acres with purpose-built buildings, it offers a wide range of undergraduate and graduate programs in seven departments under the Faculty of Information Science and Technology, Sciences, Engineering and Business Administration. The Sahiwal campus is committed to achieving CUI goals, vision and mission, and has established linkages with the local agriculture and dairy industry, which is a testimony to its commitment to public service.'),
                  _buildSpace(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildText({required context, required String text}) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  _buildSpace({space = 10.0}) {
    return SizedBox(
      height: space,
    );
  }
}
