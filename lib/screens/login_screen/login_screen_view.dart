import 'package:flutter/material.dart';
import 'package:flutter_moodle/helper/global_variable.dart';
import 'package:flutter_moodle/screens/login_screen/login_screen_view_model.dart';
import 'package:flutter_moodle/widgets/custom_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreenView extends LoginScreenViewModel {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    // final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return CustomScaffold(
      key: scaffoldKey,
      body: isLoading
          ? loadingScreenBlock()
          : Stack(
              children: [
                backgroundLogin(),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // ignore: avoid_unnecessary_containers
                            Container(
                              width: width * 0.78,
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText(
                                    width * 0.1,
                                    "Login",
                                    fw: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                  customText(
                                    width * 0.04,
                                    "Silahkan login terlebih dahulu !",
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(height: height * 0.01),
                            buildBoxInput(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget backgroundLogin() {
    return Container(
      width: width,
      height: height * 0.45,
      decoration: BoxDecoration(
        color: CustomColor.mainColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            right: -width * 0.4,
            top: -height * 0.1,
            child: decorCircle(width, CustomColor.cicrle1),
          ),
          Positioned(
            right: -width * 0.5,
            top: -height * 0.15,
            child: decorCircle(width, CustomColor.cicrle2),
          ),
          Positioned(
            right: -width * 0.6,
            top: -height * 0.2,
            child: decorCircle(width, CustomColor.cicrle3),
          ),
          Positioned(top: height * 0.08, child: boxImage())
        ],
      ),
    );
  }

  Widget boxImage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Container(
        //   width: width * 0.35,
        //   height: width * 0.35,
        //   decoration: const BoxDecoration(
        //     color: Colors.white,
        //     shape: BoxShape.circle,
        //   ),
        // ),
        Icon(
          // ignore: deprecated_member_use
          FontAwesomeIcons.userCircle,
          size: width * 0.26,
          color: Colors.white,
        ),
        // Icon(
        //   Icons.person,
        // size: width * 0.3,
        // color: CustomColor.mainColor,
        // )
      ],
    );
  }

  Widget decorCircle(double size, Color colorData) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorData,
      ),
    );
  }

  Widget buildBoxInput() {
    return Column(
      children: [
        SizedBox(height: height * 0.03),
        inputForm(
          "email",
          Icons.person,
          username,
        ),
        inputForm(
          "Password",
          Icons.lock,
          password,
          isPassword: true,
        ),
        SizedBox(height: height * 0.01),
        loginButton(),
        SizedBox(height: height * 0.02),
      ],
    );
  }

  Widget loginButton() {
    return Container(
      width: width * 0.8,
      height: height * 0.06,
      decoration: BoxDecoration(
        color: CustomColor.mainColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: MaterialButton(
          onPressed: () {
            loginUserAction();
          },
          child: customText(
            height * 0.03,
            "Login",
            fw: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget inputForm(
    String hint,
    IconData icon,
    TextEditingController controller, {
    TextInputType inputType = TextInputType.text,
    bool isPassword = false,
  }) {
    return Container(
      width: width * 0.8,
      height: height * 0.06,
      margin: EdgeInsets.only(bottom: height * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: CustomColor.mainColor,
          width: 1.5,
        ),
      ),
      child: Center(
        child: TextField(
          scrollPadding: EdgeInsets.zero,
          obscureText: isPassword && isVisible,
          controller: controller,
          style: TextStyle(
            fontSize: isPassword ? height * 0.026 : height * 0.023,
            color: CustomColor.mainColor,
            fontFamily: "Visby",
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(
                fontSize: height * 0.023,
                color: CustomColor.mainColor,
                fontFamily: "Visby"),
            prefixIcon: Icon(
              icon,
              size: height * 0.028,
              color: CustomColor.mainColor,
            ),
            prefixIconConstraints:
                BoxConstraints(minHeight: 0, minWidth: width * 0.1),
            suffixIconConstraints:
                BoxConstraints(minHeight: 0, minWidth: width * 0.1),
          ),
          keyboardType: inputType,
        ),
      ),
    );
  }
}
