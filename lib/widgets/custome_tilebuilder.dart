import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CustomTileBuilder extends StatelessWidget {
  // final BuildContext context;
  final String? imagepath;
  final String? name;

  CustomTileBuilder({
    // @required this.context,
    @required this.name,
    @required this.imagepath,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * (kIsWeb ? 0.25 : 0.45),
            height: MediaQuery.of(context).size.height * 0.6,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image(
                  fit: BoxFit.fill,
                  image: AssetImage(imagepath!),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: kIsWeb ? 45.0 : 25.0,
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text(
                        name!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'IranSansLight',
                            fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
