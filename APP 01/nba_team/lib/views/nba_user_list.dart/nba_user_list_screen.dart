import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nba_team/components/custom_header_section.dart';
import 'package:nba_team/components/custom_loader.dart';
import 'package:nba_team/components/custom_text.dart';
import 'package:nba_team/controllers/nba_team_user_controller.dart';
import 'package:nba_team/models/objects.dart';
import 'package:nba_team/providers/nba_user_provider.dart';
import 'package:nba_team/utils/app_colors.dart';
import 'package:nba_team/utils/util_functions.dart';
import 'package:nba_team/views/nba_user_details/nba_user_details_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/nba_team_provider.dart';

class NBAUserListScreen extends StatefulWidget {
  const NBAUserListScreen({Key? key}) : super(key: key);

  @override
  State<NBAUserListScreen> createState() => _NBAUserListScreenState();
}

class _NBAUserListScreenState extends State<NBAUserListScreen> {
  List<NBAUserModel> list = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          //Header Section
          CustomHeaderSection(
            size: size,
            text: Provider.of<NBATeamProvider>(context, listen: false)
                .selectedTeamName,
          ),
          //content Section
          Expanded(
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: InstancesUsers().userStream(
                    Provider.of<NBATeamProvider>(context, listen: false)
                        .selectedTeamId,
                  ),
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

                      var model = NBAUserModel.fromJson(data);

                      list.add(model);
                    }

                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomTeamSection(
                          url: list[index].imgUrl,
                          title: list[index].name,
                          onUsertap: () async {
                            print(list[index].id);
                            await Provider.of<NBAUserProvider>(context,
                                    listen: false)
                                .changeUserId(
                              list[index].id,
                            );
                            await Provider.of<NBAUserProvider>(context,
                                    listen: false)
                                .changeUserName(list[index].name);
                            UtilFunctions.navigateTo(
                                context, const NBAUserDetailsScreen());
                          },
                          width: size.width,
                          onButtonPress: () {},
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

class CustomTeamSection extends StatefulWidget {
  const CustomTeamSection({
    Key? key,
    required this.url,
    required this.title,
    required this.onUsertap,
    this.width = 10,
    required this.onButtonPress,
  }) : super(key: key);
  final String url;
  final String title;
  final Function() onUsertap;
  final double width;
  final Function() onButtonPress;

  @override
  State<CustomTeamSection> createState() => _CustomTeamSectionState();
}

class _CustomTeamSectionState extends State<CustomTeamSection> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onUsertap,
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
                    widget.url,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      top: 10,
                      right: widget.width * 0.2,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: widget.title,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const CustomText(
                      text: "Download",
                      color: kwhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
