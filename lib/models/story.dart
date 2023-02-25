import 'package:flutter/material.dart';
import 'package:ekank_stories/assets/bottomWidgets.dart';
import 'package:ekank_stories/assets/topProgressBar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Story extends StatelessWidget {
  final Color bgColor;
  final String url;
  late BuildContext _context;
  final dynamic detectLeftRightTap;

  Story({required this.bgColor, required this.url, required this.detectLeftRightTap});

  void launchURL() async{
    if (await canLaunchUrlString(url)) {
      showModalBottomSheet(context: _context, builder: (context){
        return Container(
          color: const Color(0xff757575),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
            ),
            padding: const EdgeInsets.all(12.0),
            child: Text('Opening Link: $url', style: const TextStyle(fontSize: 18),),
          ),
        );
      });
    await launchUrlString(url, mode: LaunchMode.inAppWebView);
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return GestureDetector(
      onTapDown: (details){
        var position = details.globalPosition;
        detectLeftRightTap(position);
      },
      onPanUpdate: (details) async{
        if(details.delta.dy<0) {
          launchURL();
        }
      },
      child: Container(
        color: bgColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TopProgressBar(),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          CircleAvatar(
                            radius: 18,
                            child: Icon(
                              Icons.account_balance_rounded,
                              size: 25,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'ThisDay',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                      Row(children: [
                        IconButton(
                          icon: const Icon(
                            Icons.telegram,
                            size: 35,
                            color: Colors.white,
                          ),
                          onPressed: () async{
                            Share.share('Check out this story at $url');
                          },
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Icon(
                          Icons.clear_sharp,
                          size: 35,
                          color: Colors.white,
                        ),
                      ])
                    ],
                  ),
                ],
              ),
              BottomWidgets(onPress: (){
                launchURL();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
