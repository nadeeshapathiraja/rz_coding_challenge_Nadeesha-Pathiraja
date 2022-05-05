import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nba_team/components/custom_header_section.dart';
import 'package:nba_team/components/custom_loader.dart';
import 'package:nba_team/components/custom_text.dart';
import 'package:nba_team/controllers/nba_team_user_controller.dart';
import 'package:nba_team/models/objects.dart';
import 'package:nba_team/providers/nba_user_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/nba_team_provider.dart';

class NBAUserDetailsScreen extends StatefulWidget {
  const NBAUserDetailsScreen({Key? key}) : super(key: key);

  @override
  State<NBAUserDetailsScreen> createState() => _NBAUserDetailsScreenState();
}

class _NBAUserDetailsScreenState extends State<NBAUserDetailsScreen> {
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
            text: Provider.of<NBAUserProvider>(context, listen: false)
                .selectedUserName,
          ),
          //content Section

          Expanded(
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: InstancesUsers().SelecteduserStream(
                    Provider.of<NBAUserProvider>(context, listen: false)
                        .selectedUserId,
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
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.network(
                                  list[index].imgUrl,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              CustomText(
                                text: list[index].name,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                text: Provider.of<NBATeamProvider>(context,
                                        listen: false)
                                    .selectedTeamName,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              CustomText(
                                text: list[index].desc,
                                textOverflow: TextOverflow.clip,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
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
