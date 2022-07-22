import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_moodle/helper/global_variable.dart';
import 'package:flutter_moodle/helper/utils.dart';
import 'package:flutter_moodle/widgets/custom_widget.dart';
import './detail_modul_screen_view_model.dart';

class DetailModulScreenView extends DetailModulScreenViewModel {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return CustomScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.name,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
        backgroundColor: CustomColor.mainColor,
      ),
      body: isLoading
          ? loaderPage()
          : SingleChildScrollView(
              child: Html(
                data: content[0]['content'].contains(".jpg")
                    ? UtilsData.mappingImageUrl(content[0]['content'], token)
                    : content[0]['content'].contains(".jpeg")
                        ? UtilsData.mappingImageUrl(
                            content[0]['content'], token)
                        : content[0]['content'].contains(".png")
                            ? UtilsData.mappingImageUrl(
                                content[0]['content'], token)
                            : content[0]['content'],
              ),
            ),
    );
  }
}
