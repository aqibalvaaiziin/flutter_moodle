import 'package:flutter/material.dart';
import 'package:flutter_moodle/helper/global_variable.dart';
import 'package:flutter_moodle/widgets/custom_widget.dart';
import './profile_screen_view_model.dart';

class ProfileScreenView extends ProfileScreenViewModel {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return CustomScaffold(
      body: isLoading
          ? loaderPage()
          : SizedBox(
              width: width,
              height: height,
              child: Stack(
                children: [
                  backgroundProfile(),
                  Positioned(
                    bottom: height * 0.18,
                    child: Column(
                      children: [
                        itemDataUser(Icons.email, "Email :", userData['email']),
                        itemDataUser(
                            Icons.home, "Departemen :", userData['department']),
                        itemDataUser(
                            Icons.flag, "Negara :", userData['country']),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget backgroundProfile() {
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
          Positioned(
            top: height * 0.03,
            child: customText(width * 0.045, "Biodata",
                fw: FontWeight.bold, color: Colors.white),
          ),
          Positioned(
            bottom: height * 0.125,
            child: boxImage(),
          ),
          Positioned(
            bottom: height * 0.05,
            child: boxDataUserHeader(),
          )
        ],
      ),
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

  Widget boxDataUserHeader() {
    return Column(
      children: [
        customText(
          width * 0.04,
          userData['fullname'],
          fw: FontWeight.w700,
          color: Colors.white,
        ),
        SizedBox(height: height * 0.007),
        customText(
          width * 0.03,
          "Siswa",
          color: Colors.white,
        ),
      ],
    );
  }

  Widget boxImage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: width * 0.35,
          height: width * 0.35,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(
            userData['profileimageurl'],
            fit: BoxFit.cover,
            width: width * 0.34,
            height: width * 0.34,
          ),
        ),
      ],
    );
  }

  Widget itemDataUser(IconData icon, String label, String value) {
    return Container(
      width: width,
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height * 0.01,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: width * 0.06,
                color: Colors.orange,
              ),
              SizedBox(width: width * 0.02),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customText(
                      width * 0.028,
                      label,
                      color: Colors.grey,
                      fw: FontWeight.bold,
                    ),
                    SizedBox(height: height * 0.005),
                    customText(
                      width * 0.03,
                      value,
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: height * 0.02),
          Container(
            width: width,
            height: 2,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
