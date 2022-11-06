import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit_shop/cubit_shop.dart';
import 'package:shop_app/cubit_shop/states_shop.dart';

import '../../model/search_model.dart';
var controllerSearch = TextEditingController();
var keyForm = GlobalKey<FormState>();

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => ShopCubit(),
  child: BlocConsumer<ShopCubit, ShopState>(
  listener: (context, state) {
    if (state is SuccessSearchData) {
      var model = state.searchModel.data!.datap![0].name;
      print(model);
    }
  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: keyForm,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                controller: controllerSearch,
                onFieldSubmitted: (value) {
                ShopCubit.get(context).getSearchData(value);
                },
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter text to search';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                  labelText: 'Search',
                ),
              ),
              const SizedBox(height: 10),

              if (state is LoadingSearchData)
                LinearProgressIndicator(),
              const SizedBox(height: 10),
              if (state is SuccessSearchData)
                Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => BuildSearchItem(
                      ShopCubit.get(context).searchModel!.data!.datap![index],context
                      ),
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.grey,
                  ),
                  itemCount:
                  ShopCubit.get(context).searchModel!.data!.datap!.length,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  },
),
);
  }
  Widget BuildSearchItem(Datap model,context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(
                    '${model.image}',
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price!.round()}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),

                      const Spacer(),
                      IconButton(
                        onPressed: () {

                        },
                        icon: CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(0.9),
                            radius: 16,
                            child: const Icon(Icons.favorite_border,
                                color: Colors.white, size: 17)),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
