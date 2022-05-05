import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nba_team/components/custom_header_section.dart';
import 'package:nba_team/components/custom_loader.dart';
import 'package:nba_team/components/custom_text.dart';
import 'package:nba_team/controllers/nba_team_controller.dart';
import 'package:nba_team/models/objects.dart';
import 'package:nba_team/providers/nba_team_provider.dart';
import 'package:nba_team/utils/util_functions.dart';
import 'package:nba_team/views/nba_user_list.dart/nba_user_list_screen.dart';
import 'package:provider/provider.dart';

class NBAListScreen extends StatefulWidget {
  const NBAListScreen({Key? key}) : super(key: key);

  @override
  State<NBAListScreen> createState() => _NBAListScreenState();
}

class _NBAListScreenState extends State<NBAListScreen> {
  List<NBATeamModel> list = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          //Header Section
          CustomHeaderSection(
            size: size,
            text: "NBA Teams",
          ),
          //content Section
          Expanded(
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: Instances().testStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const CustomText(text: "No Teams Yet");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CustomLoader();
                    }
                    Logger().w(snapshot.data!.docs.length);

                    //List always clear before load
                    list.clear();

                    for (var item in snapshot.data!.docs) {
                      Map<String, dynamic> data =
                          item.data() as Map<String, dynamic>;

                      var model = NBATeamModel.fromJson(data);

                      list.add(model);
                    }

                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomTeamSection(
                          url: list[index].imgUrl,
                          title: list[index].name,
                          ontap: () async {
                            await Provider.of<NBATeamProvider>(context,
                                    listen: false)
                                .changeTeamId(
                              list[index].id,
                            );
                            await Provider.of<NBATeamProvider>(context,
                                    listen: false)
                                .changeTeamName(list[index].name);
                            UtilFunctions.navigateTo(
                                context, NBAUserListScreen());
                          },
                        );
                      },
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTeamSection extends StatelessWidget {
  const CustomTeamSection({
    Key? key,
    required this.url,
    required this.title,
    required this.ontap,
  }) : super(key: key);
  final String url;
  final String title;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        elevation: 3.0,
        child: Container(
          width: double.infinity,
          height: 100,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  width: 100,
                  height: 100,
                  child: Image.network(
                    url,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: title,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
