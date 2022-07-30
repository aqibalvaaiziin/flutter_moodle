import 'package:flutter/material.dart';
import 'package:flutter_moodle/helper/global_variable.dart';

class CustomScaffold extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState>? scaffoldKey;
  final AppBar? appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;

  const CustomScaffold({
    Key? key,
    this.scaffoldKey,
    this.appBar,
    required this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomScaffoldState createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: widget.appBar,
        key: widget.scaffoldKey,
        body: widget.body,
        floatingActionButton: widget.floatingActionButton,
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
      ),
    );
  }
}

Widget customText(
  double width,
  String text, {
  FontWeight fw = FontWeight.normal,
  double lt = 0.2,
  double th = 1.0,
  Color color = Colors.black87,
  TextAlign ta = TextAlign.left,
  TextDecoration td = TextDecoration.none,
}) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: "Visby",
      fontSize: width,
      fontWeight: fw,
      letterSpacing: lt,
      color: color,
      decoration: td,
      height: th,
      decorationThickness: 4,
    ),
    textAlign: ta,
  );
}

Widget headerText(
  double width,
  String text, {
  FontWeight fw = FontWeight.normal,
  double lt = 0.2,
  double th = 1.0,
  Color color = Colors.white,
  TextAlign ta = TextAlign.left,
  TextDecoration td = TextDecoration.none,
}) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: "Visby",
      fontSize: width,
      fontWeight: fw,
      letterSpacing: lt,
      color: color,
      decoration: td,
      height: th,
      decorationThickness: 4,
    ),
    textAlign: ta,
  );
}

Widget loaderPage() {
  return Center(
    child: CircularProgressIndicator(
      color: CustomColor.mainColor,
    ),
  );
}

Widget loadingScreenBlock() {
  return Scaffold(
    // ignore: avoid_unnecessary_containers
    body: Container(
      color: Colors.white,
      // ignore: prefer_const_constructors
      child: Center(
        // ignore: prefer_const_constructors
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(CustomColor.mainColor),
        ),
      ),
    ),
  );
}

List<BoxShadow> customShadow() {
  return [
    const BoxShadow(
      color: Colors.grey,
      spreadRadius: 1,
      blurRadius: 5,
      offset: Offset(1, 1),
    )
  ];
}
