
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/presentation/bloc/github_search_bloc.dart';

import '../../../../../core/app_colors.dart';



class CustomTextField extends StatefulWidget {

   CustomTextField({Key? key}) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
    final _textController = TextEditingController();

    late GithubSearchBloc githubSearchBloc;

    @override
    void initState() {
      super.initState();
      githubSearchBloc = context.read<GithubSearchBloc>();
    }

    @override
    void dispose() {
      _textController.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return     Padding(
      padding: const EdgeInsets.only(left: 15,right: 15,bottom: 32),
      child: SizedBox(
        height: 48,
        child: TextField(
          controller: _textController,
          autocorrect: false,
          onChanged: (text) {
            githubSearchBloc.add(
              TextChanged(text: text),
            );
          },
          decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed:() {

                },
                icon: const Icon(Icons.search,
                  color: AppColors.textfieldSearchIconColor,),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15.0),
              ),
              filled: true,
              hintStyle: const TextStyle(color: AppColors.hintTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            //  hintText: "কাঙ্ক্ষিত পণ্যটি খুঁজুন",
              fillColor: AppColors.colorWhite),

        ),
      ),
    );
  }
}
