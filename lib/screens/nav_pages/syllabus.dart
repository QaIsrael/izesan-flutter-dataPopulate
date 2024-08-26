import 'package:flutter/material.dart';
import 'package:izesan/utils/colors.dart';
//
// class Section {
//   final String header;
//   final List<Item> items;
//
//   Section({required this.header, required this.items});
// }
//
// class Item {
//   final String title;
//
//   Item({required this.title});
// }
//
// class Syllabus extends StatefulWidget {
//   const Syllabus({super.key});
//
//   @override
//   _SyllabusState createState() => _SyllabusState();
// }
//
// class _SyllabusState extends State<Syllabus> {
//
//   final List<Map<String, dynamic>> dummyData = [
//     {
//       'header': 'Primary 1',
//       'items': [
//         'Greetings in Yorùbá',
//         'Writing the Alphabets',
//         'Forming words from the Alphabets',
//         'Numbers 1-10',
//         'Parts of the Body',
//         'Care of the Body',
//         'Dialogue among Learners',
//         'Nursery Rhyme for Exercise',
//         'Good Behaviour',
//         'Weather Conditions'
//       ]
//     },
//     {
//       'header': 'Second Term',
//       'items': [
//         'Greetings in Different Weather Conditions',
//         'Good behaviour',
//         'Good behaviour Part 2',
//         'Parental responsibility',
//         'Dialogue among learners',
//         'Foods, fruits and vegetables',
//         'Learning the Alphabets in sections',
//         'Expressing oneself',
//         'Short Compositions'
//       ]
//     },
//     {
//       'header': 'Primary 2',
//       'items': [
//         'Writing the Alphabets',
//         'Forming words from the Alphabets',
//         'Numbers 1-10',
//         'Parts of the Body',
//         'Care of the Body',
//         'Dialogue among Learners',
//         'Nursery Rhyme for Exercise',
//         'Good Behaviour',
//         'Weather Conditions'
//       ]
//     },
//     {
//       'header': 'Primary 3',
//       'items': [
//         'Writing the Alphabets',
//         'Forming words from the Alphabets',
//         'Numbers 1-10',
//         'Parts of the Body',
//         'Care of the Body',
//         'Dialogue among Learners',
//         'Nursery Rhyme for Exercise',
//         'Good Behaviour',
//         'Weather Conditions'
//       ]
//     },
//     {
//       'header': 'Primary 4',
//       'items': [
//         'Writing the Alphabets',
//         'Forming words from the Alphabets',
//         'Numbers 1-10',
//         'Parts of the Body',
//         'Care of the Body',
//         'Dialogue among Learners',
//         'Nursery Rhyme for Exercise',
//         'Good Behaviour',
//         'Weather Conditions'
//       ]
//     }
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final sections = dummyData.map((data) {
//       return Section(
//         header: data['header'],
//         items: (data['items'] as List<String>).map((item) => Item(title: item)).toList(),
//       );
//     }).toList();
//
//     return CustomScrollView(
//       slivers: [
//         for (var section in sections) ...[
//           SliverPersistentHeader(
//             pinned: true,
//             delegate: _SectionHeaderDelegate(section.header),
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//                   (context, itemIndex) {
//                 final item = section.items[itemIndex];
//                 return ListTile(
//                   title: Text(item.title),
//                 );
//               },
//               childCount: section.items.length,
//             ),
//           ),
//         ],
//       ],
//     );
//   }
// }
//
// class _SectionHeaderDelegate extends SliverPersistentHeaderDelegate {
//   final String header;
//
//   _SectionHeaderDelegate(this.header);
//
//   @override
//   Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       color: Colors.orange,
//       padding: EdgeInsets.all(16.0),
//       child: Text(
//         header,
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
//
//   @override
//   double get maxExtent => 50.0;
//
//   @override
//   double get minExtent => 50.0;
//
//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
//     return oldDelegate is _SectionHeaderDelegate && oldDelegate.header != header;
//   }
// }


class Syllabus extends StatelessWidget {
  const Syllabus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dummyData = [
      {
        'header': 'Primary 1',
        'subHeader': 'First Term',
        'topics': [
          {'week': 1, 'topic': 'Greetings in Yorùbá', 'description': 'Learn basic greetings in Yorùbá'},
          {'week': 1, 'topic': 'Writing the Alphabets', 'description': 'Practice writing the alphabet'},
          {'week': 2, 'topic': 'Forming words from the Alphabets', 'description': 'Learn to form words from letters'},
          {'week': 2, 'topic': 'Numbers 1-10', 'description': 'Introduction to numbers 1 to 10'},
          {'week': 3, 'topic': 'Parts of the Body', 'description': 'Learn names of different body parts'},
          {'week': 3, 'topic': 'Care of the Body', 'description': 'Basic hygiene practices'},
          {'week': 4, 'topic': 'Dialogue among Learners', 'description': 'Practice conversational skills'},
          {'week': 4, 'topic': 'Nursery Rhyme for Exercise', 'description': 'Learn a nursery rhyme'},
          {'week': 5, 'topic': 'Good Behaviour', 'description': 'Understanding and practicing good behavior'},
          {'week': 5, 'topic': 'Weather Conditions', 'description': 'Learn about different weather conditions'},
        ],
      },
      {
        'header': 'Primary 2',
        'subHeader': 'Second Term',
        'topics': [
          {'week': 6, 'topic': 'Greetings in Different Weather Conditions', 'description': 'Greetings based on weather'},
          {'week': 6, 'topic': 'Good behaviour', 'description': 'Continuation of good behavior'},
          {'week': 7, 'topic': 'Good behaviour Part 2', 'description': 'More on good behavior'},
          {'week': 7, 'topic': 'Parental responsibility', 'description': 'Understanding parental roles'},
          {'week': 8, 'topic': 'Dialogue among learners', 'description': 'Practice conversational skills'},
          {'week': 8, 'topic': 'Foods, fruits and vegetables', 'description': 'Learning about food types'},
          {'week': 9, 'topic': 'Learning the Alphabets in sections', 'description': 'Alphabet learning in sections'},
          {'week': 9, 'topic': 'Expressing oneself', 'description': 'Learning self-expression'},
          {'week': 10, 'topic': 'Short Compositions', 'description': 'Writing short compositions'},
        ],
      },
      // Add more sections as needed
    ];

    return MaterialApp(
        debugShowCheckedModeBanner: false,
      home: Scaffold(

      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.maxFinite,
              height: 60,
              child: SizedBox(),
            ),
            Container(
              color: Colors.orange[400],
              padding: EdgeInsets.all(8.0),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Week',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Topic',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Description',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 2, color: Colors.black),
            Expanded(
              child: ListView.separated(
                itemCount: dummyData.length,
                separatorBuilder: (context, index) => Divider(height: 2, color: Colors.black),
                itemBuilder: (context, index) {
                  final section = dummyData[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        color: Colors.orange[400],
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              section['header'],
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              section['subHeader'],
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      SectionWidget(topics: List<Map<String, dynamic>>.from(section['topics'])),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionWidget extends StatelessWidget {
  final List<Map<String, dynamic>> topics;

  const SectionWidget({
    required this.topics,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: topics.length,
      itemBuilder: (context, index) {
        final topic = topics[index];
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '${topic['week']}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    topic['topic'],
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    topic['description'],
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

//
// class Syllabus extends StatefulWidget {
//   const Syllabus({Key? key}) : super(key: key); // Corrected constructor syntax
//
//   @override
//   _SyllabusState createState() => _SyllabusState();
// }
//
// class _SyllabusState extends State<Syllabus> {
//   List<bool> _isOpenList = [];
//
//   final List<Map<String, dynamic>> dummyData = [
//     {
//       'header': 'Primary 1',
//       'items': [
//         'Greetings in Yorùbá',
//         'Writing the Alphabets',
//         'Forming words from the Alphabets',
//         'Numbers 1-10',
//         'Parts of the Body',
//         'Care of the Body',
//         'Dialogue among Learners',
//         'Nursery Rhyme for Exercise',
//         'Good Behaviour',
//         'Weather Conditions'
//       ]
//     },
//     {
//       'header': 'Second Term',
//       'items': [
//         'Greetings in Different Weather Conditions',
//         'Good behaviour',
//         'Good behaviour Part 2',
//         'Parental responsibility',
//         'Dialogue among learners',
//         'Foods, fruits and vegetables',
//         'Learning the Alphabets in sections',
//         'Expressing oneself',
//         'Short Compositions'
//       ]
//     },
//     {
//       'header': 'Primary 2',
//       'items': [
//         'Writing the Alphabets',
//         'Forming words from the Alphabets',
//         'Numbers 1-10',
//         'Parts of the Body',
//         'Care of the Body',
//         'Dialogue among Learners',
//         'Nursery Rhyme for Exercise',
//         'Good Behaviour',
//         'Weather Conditions'
//       ]
//     },
//     {
//       'header': 'Primary 3',
//       'items': [
//         'Writing the Alphabets',
//         'Forming words from the Alphabets',
//         'Numbers 1-10',
//         'Parts of the Body',
//         'Care of the Body',
//         'Dialogue among Learners',
//         'Nursery Rhyme for Exercise',
//         'Good Behaviour',
//         'Weather Conditions'
//       ]
//     },
//     {
//       'header': 'Primary 4',
//       'items': [
//         'Writing the Alphabets',
//         'Forming words from the Alphabets',
//         'Numbers 1-10',
//         'Parts of the Body',
//         'Care of the Body',
//         'Dialogue among Learners',
//         'Nursery Rhyme for Exercise',
//         'Good Behaviour',
//         'Weather Conditions'
//       ]
//     }
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _isOpenList = List<bool>.filled(dummyData.length, true);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//
//         body: SectionedListView(
//           dummyData: dummyData,
//           isOpenList: _isOpenList,
//           onExpansionChanged: _handleExpansionChanged,
//         ),
//       ),
//     );
//   }
//
//   void _handleExpansionChanged(int index, bool expanded) {
//     setState(() {
//       _isOpenList[index] = expanded;
//     });
//   }
// }
//
// class SectionedListView extends StatelessWidget {
//   final List<Map<String, dynamic>> dummyData;
//   final List<bool> isOpenList;
//   final Function(int, bool) onExpansionChanged;
//
//   const SectionedListView({
//     required this.dummyData,
//     required this.isOpenList,
//     required this.onExpansionChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: dummyData.length,
//       itemBuilder: (context, index) {
//         final section = dummyData[index];
//         return SectionWidget(
//           header: section['header'],
//           items: List<String>.from(section['items']), // Ensure items list is converted to String
//           initiallyExpanded: isOpenList[index],
//           onExpansionChanged: (expanded) => onExpansionChanged(index, expanded),
//         );
//       },
//     );
//   }
// }
//
// class SectionWidget extends StatelessWidget {
//   final String header;
//   final List<String> items;
//   final bool initiallyExpanded;
//   final ValueChanged<bool> onExpansionChanged;
//
//   const SectionWidget({
//     required this.header,
//     required this.items,
//     required this.initiallyExpanded,
//     required this.onExpansionChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ExpansionTile(
//       title: Text(
//         header,
//         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//       ),
//       initiallyExpanded: initiallyExpanded,
//       onExpansionChanged: onExpansionChanged,
//       children: items.map((item) {
//         return ListTile(
//           title: Text(item),
//         );
//       }).toList(),
//     );
//   }
// }
